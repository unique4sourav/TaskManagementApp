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


class Task: Identifiable, ObservableObject {
    let id = UUID()
    @Published var title: String
    @Published var dueDate: Date
    @Published var priority: TaskPriority
    @Published var notes: String?
    @Published private(set) var completionDate: Date? = nil
    
    init(title: String, dueDate: Date, priority: TaskPriority, notes: String? = nil, completionDate: Date? = nil) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.notes = notes
        self.completionDate = completionDate
    }
    
    func toggleCompleteness() {
        if completionDate == nil {
            completionDate = Date()
        }
        else {
            completionDate = nil
        }
    }
}
