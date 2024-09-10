//
//  HomeViewModel.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import Foundation
import Combine
import CoreStore
import EventKit

typealias ItemId = String

enum HomeNavigation: Equatable {
    case selectItem(ItemId)
}

final class HomeViewModel: ObservableObject, Navigable {
    
    @Published var listTask: [Task] = []
    @Published var editingTask: Task? = nil
    @Published var isLoading: Bool = true
    private var cancellable = Set<AnyCancellable>()
    @Published var eventStore = EKEventStore()
    @Published var isAccessGranted = false
    
    var onNavigation: ((HomeNavigation) -> Void)!
    
    private func addEventToCalendar(_ task: TaskModel? = nil, baseTask: Task? = nil) {
        guard isAccessGranted else { return }
        let newEvent = EKEvent(eventStore: eventStore)
        newEvent.title = task?.title ?? baseTask?.title ?? ""
        newEvent.notes = task?.desc ?? baseTask?.desc ?? ""
        newEvent.startDate = task?.date ?? baseTask?.date
        newEvent.endDate = task?.date ?? baseTask?.date
        newEvent.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.save(newEvent, span: .thisEvent)
        } catch let error {
            print("\(error.localizedDescription)")
        }
        
    }
    
    private func requestAccessToCalendar(_ task: TaskModel? = nil, baseTask: Task? = nil) {
        eventStore.requestFullAccessToEvents { (granted, error) in
            if granted {
                DispatchQueue.main.async{
                    self.isAccessGranted = true
                    self.addEventToCalendar(task, baseTask: baseTask)
                }
            } else {
                print("\(String(describing: error))")
            }
        }
    }
    
    private func removeAllEventIn(_ date: Date, title: String?, desc: String?) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)?.addingTimeInterval(-1) ?? Date()
        let predicate = self.eventStore.predicateForEvents(withStart: startOfDay, end: endOfDay, calendars: nil)
        let events = self.eventStore.events(matching: predicate)
        for event in events {
            if event.title == title && event.notes == desc {
                do {
                    try eventStore.remove(event, span: .thisEvent)
                } catch let error {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    func filterByType(_ type: String) {
        do {
            switch type {
            case Strings.taskTypeWork:
                listTask = try CoreStoreDefaults.dataStack.fetchAll(From<Task>().where(\.taskType == TaskType.work.rawValue))
            case Strings.taskTypePersonal:
                listTask = try CoreStoreDefaults.dataStack.fetchAll(From<Task>().where(\.taskType == TaskType.personal.rawValue))
            default:
                fetchTasks()
            }
        } catch {
            fatalError()
        }
    }
    
    func addTask(_ task: TaskModel) {
        isLoading = true
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { transaction in
                let newTask = transaction.create(Into<Task>())
                newTask.title = task.title
                newTask.tag = task.tag
                newTask.desc = task.desc
                newTask.status = task.status
                newTask.date = task.date
                newTask.id = UUID().uuidString
                newTask.isRemind = task.isRemind
                newTask.taskType = task.taskType
            },
            completion: { [weak self] _ in
                self?.isLoading = false
                self?.fetchTasks()
                if task.isRemind {
                    self?.requestAccessToCalendar(task)
                } else if let startDate = task.date, let self = self{
                    self.removeAllEventIn(startDate, title: task.title, desc: task.desc)
                }
            }
        )
    }
    
    func modifiedTask(_ task: Task) {
        self.isLoading = true
        CoreStoreDefaults.dataStack.perform { transaction in
            guard let editingTask = transaction.edit(task) else { return}
            editingTask.taskType = task.taskType
            editingTask.status = task.status
            editingTask.isRemind = task.isRemind
        } success: { _ in
            self.isLoading = false
            if task.isRemind {
                self.requestAccessToCalendar(baseTask: task)
            } else if let startDate = task.date{
                self.removeAllEventIn(startDate, title: task.title, desc: task.desc)
            }
        } failure: { error in
            fatalError(error.debugDescription)
        }
    }
    
    func deleteTask(_ indexSet: IndexSet) {
        let taskDelete = indexSet.map { self.listTask[$0] }
        isLoading = true
        CoreStoreDefaults.dataStack.perform(
            asynchronous: { transaction in
                transaction.delete(taskDelete)
            },
            completion: { [weak self] _ in
                self?.isLoading = false
                self?.fetchTasks()
            }
        )
        
    }
    
    private func fetchTasks() {
        do {
            listTask = try CoreStoreDefaults.dataStack.fetchAll(From<Task>())
        } catch {
            fatalError()
        }
    }
    
    func viewLoad() {
        fetchTasks()
    }
    
    func viewAppear() {
    }
    
    func viewDisappear() {
    }
    
}
