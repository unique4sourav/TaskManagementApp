//
//  Task.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation

enum TaskPriority: Int {
    case low, medium, high
    
    var description: String {
        "\(self)".capitalized
    }
}

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
    var priority: TaskPriority
    var notes: String?
    private(set) var isCompleted: Bool = false
    var completionDate: Date? = nil
    
    mutating func markComplete() {
        if !isCompleted {
            isCompleted = true
            completionDate = Date()
        }
        else {
            isCompleted = false
            completionDate = nil
        }
        print(isCompleted)
    }
}
