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

extension Color {
    init?(_ taskColor: TaskColorString?) {
        switch taskColor?.rawValue {
        case "red": self = .red
        case "orange": self = .orange
        case "yellow": self = .yellow
        case "green": self = .green
        case "mint": self = .mint
        case "teal": self = .teal
        case "cyan": self = .cyan
        case "blue": self = .blue
        case "indigo": self = .indigo
        case "purple": self = .purple
        case "pink": self = .pink
        case "brown": self = .brown
        default: return nil
        }
    }
}


struct Task: Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
    var priority: TaskPriority
    var notes: String?
    var completionDate: Date? = nil
    let taskColor = Color(TaskColorString.allCases.randomElement())
    
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
