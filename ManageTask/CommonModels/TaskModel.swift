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



struct TaskModel: Identifiable {
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
    
    mutating func toggleCompleteness() {
        if completionDate == nil {
            completionDate = Date()
        }
        else {
            completionDate = nil
        }
    }
}

extension TaskModel {
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
