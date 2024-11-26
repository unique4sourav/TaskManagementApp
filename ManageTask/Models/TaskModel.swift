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


enum TaskBackground: String, CaseIterable, Identifiable {
    case red, orange, green, cyan, blue, indigo, purple, pink, brown
    
    var id: Self { self }
    
    var color: Color {
        switch self {
        case .red:
            return Color.red
            
        case .orange:
            return Color.orange
            
        case .green:
            return Color.green
            
        case .cyan:
            return Color.cyan
            
        case .blue:
            return Color.blue
            
        case .indigo:
            return Color.indigo
            
        case .purple:
            return Color.purple
            
        case .pink:
            return Color.pink
            
        case .brown:
            return Color.brown
        }
    }
    
    static var allColors: [Color] {
        TaskBackground.allCases.map { $0.color }
    }
}



struct TaskModel: Identifiable {
    let id = UUID()
    var title: String
    var dueDate: Date
    var priority: PriorityOfTask
    var note: String
    var completionDate: Date? = nil
    let color = Color(TaskBackground.allCases.randomElement())
    
    init(title: String, dueDate: Date, priority: PriorityOfTask, notes: String, completionDate: Date? = nil) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.note = notes
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
