//
//  HomeView.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import SwiftUI
import CoreStore
import SwiftUITooltip

struct HomeView: View {
    
    @EnvironmentObject var global: GlobalModel
    @ObservedObject var viewModel: HomeViewModel
    @State private var showSheet = false
    @State private var showChart = false
    @State private var showToolTip = [true, false]
    @State private var addNewTaskIsDateEnabled: Bool = false
    @State private var addNewTaskSelectedDate: Date = Date()
    @State private var addNewTaskIsRemind: Bool = false
    @State private var addNewTaskTitle: String = ""
    @State private var addNewTaskDescription: String = ""
    @State private var isEditFlow: Bool = false
    @State private var tagTaskType: Bool = false
    @State private var selectedTaskTypesIndex = 0
    private var taskTypes = [Strings.taskTypeWork, Strings.taskTypePersonal]
    @State private var selectedFilterTaskTypesIndex = 0
    @State private var selectedTaskStatusIndex = 0
    private var taskStatus = [TaskStatus.toDo.rawValue, TaskStatus.pending.rawValue, TaskStatus.completed.rawValue]
    
    private func setTask(_ task: Task? = nil){
        if let task = task {
            addNewTaskIsDateEnabled = task.date != nil
            addNewTaskSelectedDate = task.date ?? Date()
            addNewTaskIsRemind = task.isRemind
            addNewTaskTitle = task.title ?? ""
            addNewTaskDescription = task.desc ?? ""
            viewModel.editingTask = task
            selectedTaskTypesIndex = TaskType.convertToInt(task.taskType ?? "") ?? 0
            selectedTaskStatusIndex = TaskStatus.convertToInt(task.status ?? "")
        } else {
            addNewTaskIsDateEnabled = false
            addNewTaskSelectedDate = Date()
            addNewTaskIsRemind = false
            addNewTaskTitle = ""
            addNewTaskDescription = ""
            selectedTaskTypesIndex = 0
            selectedTaskStatusIndex = 0
        }
        
    }
    
    private func validateAddNewTask() -> Bool {
        return !addNewTaskTitle.isEmpty && !addNewTaskDescription.isEmpty
    }
    
    init() {
        self.viewModel = HomeViewModel()
    }
    
    private func buttonFilter(_ text: String) -> some View {
        var gradient = Gradient(colors: [])
        var opacityBg = 0.0
        switch text {
        case Strings.taskTypeWork:
            opacityBg = selectedFilterTaskTypesIndex == 1 ? 0.1 : 0
            gradient = Gradient(colors: [.red, .yellow])
        case Strings.taskTypePersonal:
            opacityBg = selectedFilterTaskTypesIndex == 2 ? 0.1 : 0
            gradient = Gradient(colors: [Assets.primaryColor.swiftUIColor, .cyan])
        default:
            opacityBg = selectedFilterTaskTypesIndex == 0 ? 0.1 : 0
            gradient = Gradient(colors: [.gray, Assets.primaryColor.swiftUIColor])
        }
        return Button {
            viewModel.filterByType(text)
            switch text {
            case Strings.taskTypeWork:
                selectedFilterTaskTypesIndex = 1
            case Strings.taskTypePersonal:
                selectedFilterTaskTypesIndex = 2
            default:
                selectedFilterTaskTypesIndex = 0
            }
        } label: {
            HStack {
                Circle()
                    .fill(RadialGradient(
                        gradient   : gradient,
                        center     : UnitPoint(x: 0.25, y: 0.25),
                        startRadius: 0.2,
                        endRadius  : 200
                    )).frame(width: 16)
                Text(text).foregroundStyle(.gray)
            }
        }
        .padding(10)
        .background(.black.opacity(opacityBg))
        .cornerRadius(16)
    }
    
    var pieChartView: some View {
        var dataToyShape: [ToyShape] = [
            ToyShape(type: TaskType.personal.rawValue, status: TaskStatus.toDo.rawValue, count: 0),
            ToyShape(type: TaskType.personal.rawValue, status: TaskStatus.pending.rawValue, count: 0),
            ToyShape(type: TaskType.personal.rawValue, status: TaskStatus.completed.rawValue, count: 0),
            ToyShape(type: TaskType.work.rawValue, status: TaskStatus.toDo.rawValue, count: 0),
            ToyShape(type: TaskType.work.rawValue, status: TaskStatus.pending.rawValue, count: 0),
            ToyShape(type: TaskType.work.rawValue, status: TaskStatus.completed.rawValue, count: 0),
        ]
        viewModel.listTask.forEach { _task in
            switch _task.status {
            case TaskStatus.completed.rawValue:
                switch _task.taskType {
                case TaskType.personal.rawValue:
                    dataToyShape[2].count += 1
                case TaskType.work.rawValue:
                    dataToyShape[5].count += 1
                default:
                    break
                }
            case TaskStatus.pending.rawValue:
                switch _task.taskType {
                case TaskType.personal.rawValue:
                    dataToyShape[1].count += 1
                case TaskType.work.rawValue:
                    dataToyShape[4].count += 1
                default:
                    break
                }
            case TaskStatus.toDo.rawValue:
                switch _task.taskType {
                case TaskType.personal.rawValue:
                    dataToyShape[0].count += 1
                case TaskType.work.rawValue:
                    dataToyShape[3].count += 1
                default:
                    break
                }
            default:
                break
            }
        }
        return NavigationView {
            ChartView(data: dataToyShape).navigationBarItems(
                leading: Button(Strings.cancel) {
                    withAnimation {
                        showChart.toggle()
                    }
                }.foregroundColor(.blue)
            )
        }
    }
    
    var addNewTaskDetail: some View {
        Form {
            Toggle(isOn: $addNewTaskIsDateEnabled) {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        Text(Strings.datetime)
                    }
                    if addNewTaskIsDateEnabled {
                        Text(addNewTaskSelectedDate.getFormattedDate(format: "dd/MM/yyyy HH:mm")).foregroundStyle(Assets.primaryColor.swiftUIColor).padding(.leading, 28)
                    }
                }
            }
            if addNewTaskIsDateEnabled { DatePicker(Strings.datetime, selection: $addNewTaskSelectedDate, displayedComponents: [.date, .hourAndMinute])
                    .environment(\.locale, Locale(identifier: "en_DK"))
                .datePickerStyle(GraphicalDatePickerStyle())}
            Section {
                Toggle(isOn: $addNewTaskIsRemind) {
                    HStack {
                        Image(systemName: "bell.badge")
                            .foregroundColor(.purple)
                        Text(Strings.addToCalendar)
                    }
                }
            }
        }
    }
    
    var addNewTask: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField(Strings.title, text: $addNewTaskTitle)
                        TextField(Strings.description, text: $addNewTaskDescription)
                            .lineLimit(5...10)
                    }
                    Section {
                        Picker(selection: $selectedTaskTypesIndex, label: HStack {
                            Text(Strings.tagTypeWork)
                            Circle()
                                .fill(RadialGradient(
                                    gradient   : Gradient(colors: selectedTaskTypesIndex == 0 ? [.red, .yellow] : [Assets.primaryColor.swiftUIColor, .cyan]),
                                    center     : UnitPoint(x: 0.25, y: 0.25),
                                    startRadius: 0.2,
                                    endRadius  : 200
                                )).frame(width: 16)
                            Spacer()
                            
                        }) {
                            ForEach(0 ..< taskTypes.count) {
                                Text(self.taskTypes[$0])
                            }
                        }
                    }
                    Section {
                        Picker(selection: $selectedTaskStatusIndex, label: HStack {
                            Text("Status")
                        }) {
                            ForEach(0 ..< taskStatus.count) {
                                Text(self.taskStatus[$0])
                            }
                        }
                    }
                    Section {
                        NavigationLink(destination: addNewTaskDetail) {
                            Text(Strings.detail)
                        }
                    }
                }
            }
            .navigationBarTitle(isEditFlow ? Strings.editTask : Strings.addNewTask, displayMode: .inline)
            .navigationBarItems(
                leading: Button(Strings.cancel) {
                    withAnimation {
                        showSheet.toggle()
                    }
                }
                    .foregroundColor(.blue),
                trailing: Button(action: {
                    if isEditFlow {
                        if let editingTask = viewModel.editingTask {
                            let taskType = TaskType.convertToStr(selectedTaskTypesIndex)
                            editingTask.taskType = taskType
                            editingTask.status = TaskStatus.convertToStr(selectedTaskStatusIndex)
                            editingTask.title = addNewTaskTitle
                            editingTask.desc = addNewTaskDescription
                            editingTask.date = addNewTaskIsDateEnabled ? addNewTaskSelectedDate : nil
                            editingTask.isRemind = addNewTaskIsRemind
                            viewModel.modifiedTask(editingTask)
                        }
                    } else {
                        viewModel.addTask(TaskModel(title: addNewTaskTitle, id: UUID().uuidString, desc: addNewTaskDescription, status: TaskStatus.convertToStr(selectedTaskStatusIndex), tag: "", date: addNewTaskIsDateEnabled ? addNewTaskSelectedDate : nil, isRemind: addNewTaskIsRemind, taskType: TaskType.convertToStr(selectedTaskTypesIndex), subtasks: ""))
                        setTask()
                    }
                    withAnimation {
                        showSheet.toggle()
                    }
                }, label: {
                    Text(isEditFlow ? Strings.save : Strings.add)
                    
                }).foregroundColor(validateAddNewTask() ? .blue : .gray)
                    .disabled(addNewTaskTitle.isEmpty)
            )
        }
    }
    
    var body: some View {
        ZStack(alignment: .top, content: {
            HStack(alignment: .top, spacing: 0){
                VStack {
                    List{
                        Section {
                            ForEach(viewModel.listTask, id: \.id) { task in
                                Button(action: {
                                    isEditFlow = true
                                    viewModel.editingTask = task
                                    setTask(task)
                                    showSheet.toggle()
                                }, label: {
                                    HomeCardView(task: task)
                                })
                            }
                            .onDelete(perform: { indexSet in
                                Utils.hapticFeedbackGenerator?.notificationOccurred(.success)
                                viewModel.deleteTask(indexSet)
                            })
                        }
                    }
                    .listRowSpacing(10)
                    .safeAreaInset(edge: .bottom, spacing: .zero){
                        Spacer().frame(height: 48)
                    }
                    .safeAreaInset(edge: .top, spacing: .zero) {
                        VStack {
                            HStack {
                                Spacer()
                                buttonFilter(Strings.taskTypeWorkAll)
                                Spacer()
                                buttonFilter(Strings.taskTypeWork)
                                Spacer()
                                buttonFilter(Strings.taskTypePersonal)
                                Spacer()
                            }
                            Text(Strings.toDoList).bold().font(.largeTitle)
                        }
                        .padding(.bottom, 8)
                        .padding(.top, 64)
                    }
                    .overlay(Group {
                        if viewModel.listTask.isEmpty{
                            VStack {
                                Assets.icEmptyTaskList
                                    .swiftUIImage
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 128)
                                    .padding(.leading, 28)
                                Text(Strings.toDoListEmpty)
                            }
                        }
                    })
                }
            }
            if (showToolTip[0]) { Color.black.opacity(0.5).ignoresSafeArea() }
            VStack {
                Spacer()
                Button(action: {
                    if (showToolTip[0]) {
                        showToolTip[0].toggle()
                        showToolTip[1].toggle()
                    } else {
                        isEditFlow = false
                        showSheet = true
                        setTask()
                    }
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Text(Strings.addTask)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Assets.primaryColor.swiftUIColor, .blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 10)
                }.tooltip(showToolTip[0], side: .top, config: Utils.appTooltipConfig){
                    Text(Strings.tooltipAddNewTask)
                        .bold()
                        .foregroundStyle(Assets.orangeColor.swiftUIColor)
                }
            }
            if (showToolTip[1]) { Color.black.opacity(0.5).ignoresSafeArea() }
            HStack {
                Button {
                    showChart.toggle()
                } label: {
                    Image(systemName: "chart.pie.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }.frame(width: 50, height: 50)
                Spacer()
                Button {
                    if (showToolTip[1]) {
                        showToolTip[1].toggle()
                    } else {
                        global.toggleLanguague()
                    }
                } label: {
                    Text(global.languague.uppercased())
                }.frame(width: 50, height: 32)
                    .tooltip(showToolTip[1], side: .left, config: Utils.appTooltipConfig){
                        Text(Strings.tooltipChangeLanguage)
                            .bold()
                            .foregroundStyle(Assets.orangeColor.swiftUIColor)
                    }
            }.padding(.horizontal, 16)
        })
        .background(.clear)
        .onLoad {
            viewModel.viewLoad()
        }
        .sheet(
            isPresented: $showChart)
        {
            pieChartView
        }
        .sheet(
            isPresented: $showSheet)
        {
            addNewTask
        }
    }
    
}

#Preview {
    HomeView().environmentObject(GlobalModel())
}
