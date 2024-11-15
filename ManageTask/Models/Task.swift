//
//  Task.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation
import Combine
import SwiftUI

enum TaskPriority: Int {
    case low, medium, high
    
    var description: String {
        "\(self)".capitalized
    }
}

enum TaskColorString: String, CaseIterable {
    case red, orange, green, mint, teal, cyan, blue, indigo, purple, pink, brown
}


struct Task: Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
    var priority: TaskPriority
    var notes: String?
    var completionDate: Date? = nil
    let color = Color(TaskColorString.allCases.randomElement())
    
    init(title: String, dueDate: Date, priority: TaskPriority, notes: String? = nil, completionDate: Date? = nil) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.notes = notes
        self.completionDate = completionDate
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
