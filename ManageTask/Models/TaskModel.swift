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

enum TaskColorString: String, CaseIterable {
    case red, orange, green, mint, teal, cyan, blue, indigo, purple, pink, brown
}


struct TaskModel: Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
    var priority: PriorityOfTask
    var notes: String?
    var completionDate: Date? = nil
    let color = Color(TaskColorString.allCases.randomElement())
    
    init(title: String, dueDate: Date, priority: PriorityOfTask, notes: String? = nil, completionDate: Date? = nil) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.notes = notes
        self.completionDate = completionDate
    }
    
    mutating func toggleCompleteness() {
        print("toggleCompleteness() is called")
        if completionDate == nil {
            completionDate = Date()
        }
        else {
            completionDate = nil
        }
    }
}
