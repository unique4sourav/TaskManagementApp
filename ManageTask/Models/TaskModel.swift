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

enum TaskBackground {
    case defaultStyle
    
    static let allColors: [Color] = [
        .red, .orange, .green, .cyan, .blue,
        .indigo, .purple, .pink, .brown
    ]
    
    var color: Color {
        .orange
    }
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
         color: Color = TaskBackground.allColors.randomElement() ?? .orange) {
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
