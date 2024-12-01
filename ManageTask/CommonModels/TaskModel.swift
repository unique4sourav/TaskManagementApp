//
//  Task.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation
import Combine
import SwiftUI

enum PriorityOfTask: Int, CaseIterable, Identifiable {
    case low, medium, high
    
    var description: String {
        "\(self)".capitalized
    }
    
    var id: Self { self }
}

protocol TaskModelProtocol: Identifiable, Hashable {
    var id: UUID { get }
    var title: String { get set }
    var dueDate: Date { get set }
    var priority: PriorityOfTask { get set }
    var note: String { get set }
    var completionDate: Date? { get set }
    var color: Color { get set }
}

extension TaskModelProtocol {
    var isCompleted: Bool {
        completionDate != nil ? true : false
    }
    
    var completionStatus: TaskCompletionStatus {
        if isCompleted {
            return .completed
        }
        else if dueDate > Date() {
            return .incomplete
        }
        else {
            return .overdue
        }
    }
}

struct TaskModel: TaskModelProtocol {
    let id = UUID()
    var title: String
    var dueDate: Date
    var priority: PriorityOfTask
    var note: String
    var completionDate: Date? = nil
    var color: Color
    
    init(title: String, dueDate: Date, priority: PriorityOfTask,
         notes: String, completionDate: Date? = nil,
         color: Color = AppConstant.defaultTaskColor) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.note = notes
        self.completionDate = completionDate
        self.color = color
    }
    
//    mutating func toggleCompleteness() {
//        if completionDate == nil {
//            completionDate = Date()
//        }
//        else {
//            completionDate = nil
//        }
//    }
}

//extension TaskModel {
//    var isCompleted: Bool {
//        completionDate != nil ? true : false
//    }
//    
//    var completionStatus: TaskCompletionStatus {
//        if isCompleted {
//            return .completed
//        }
//        else if dueDate > Date() {
//            return .incomplete
//        }
//        else {
//            return .overdue
//        }
//    }
//    
//    
//    
//}
