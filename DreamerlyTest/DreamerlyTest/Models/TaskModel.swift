//
//  TaskModel.swift
//  DreamerlyTest
//
//  Created by Long Quách on 09/09/2024.
//

import Foundation
import SwiftUI

struct TaskModel: Codable {
    var title, id, desc, status, tag: String
    var date: Date?
    var isRemind: Bool
    var taskType: String?
    var subtasks: String

    enum CodingKeys: String, CodingKey {
        case title, id, desc, status, tag, date, isRemind, taskType, subtasks
    }
}

enum TaskType: String {
    case work = "work"
    case personal = "personal"
    static func convertToStr(_ value: Int) -> String? {
        switch value {
        case 0:
            return TaskType.work.rawValue
        case 1:
            return TaskType.personal.rawValue
        default:
            return nil
        }
    }
    static func convertToInt(_ value: String) -> Int? {
        switch value {
        case TaskType.work.rawValue:
            return 0
        case TaskType.personal.rawValue:
            return 1
        default:
            return nil
        }
    }
}

enum TaskStatus: String {
    case toDo = "To do"
    case pending = "Pending"
    case completed = "Completed"
    static func convertToStr(_ value: Int) -> String {
        switch value {
        case 0:
            return TaskStatus.toDo.rawValue
        case 1:
            return TaskStatus.pending.rawValue
        case 2:
            return TaskStatus.completed.rawValue
        default:
            return TaskStatus.toDo.rawValue
        }
    }
    static func convertToInt(_ value: String) -> Int {
        switch value {
        case TaskStatus.toDo.rawValue:
            return 0
        case TaskStatus.pending.rawValue:
            return 1
        case TaskStatus.completed.rawValue:
            return 2
        default:
            return 0
        }
    }
}
