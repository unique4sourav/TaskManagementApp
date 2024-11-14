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

class Task: Identifiable, ObservableObject {
    let id = UUID()
    var title: String
    var dueDate: Date
    var priority: TaskPriority
    var notes: String?
    @Published private(set) var isCompleted: Bool = false
    var completionDate: Date? = nil
    
    init(title: String, dueDate: Date, priority: TaskPriority, notes: String? = nil,
         isCompleted: Bool = false, completionDate: Date? = nil) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.notes = notes
        self.isCompleted = isCompleted
        self.completionDate = completionDate
    }
    
    func markComplete() {
        if !isCompleted {
            isCompleted = true
            completionDate = Date()
        }
        else {
            isCompleted = false
            completionDate = nil
        }
    }
}
