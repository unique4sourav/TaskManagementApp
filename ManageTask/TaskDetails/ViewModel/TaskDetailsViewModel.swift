//
//  TaskDetailsViewModel.swift
//  ManageTask
//
//  Created by Sourav Santra on 29/11/24.
//

import Foundation
import SwiftUI

class TaskDetailsViewModel: ObservableObject {
    
    func completionStatusColor(for task: TaskModel) -> Color {
        switch task.completionStatus {
        case .all:
            return .primary
        case .overdue:
            return .red
        case .incomplete:
            return .orange
        case .completed:
            return .green
        }
    }
    
    
    func priorityColor(for task: TaskModel) -> Color {
        if task.isCompleted {
            return .primary
        }
        else {
            switch task.priority {
            case .high:
                return Color.red
            case .medium:
                return Color.orange
            case .low:
                return Color.green
            }
        }
    }
    
    func markComplete(_ task: TaskModel, using taskManager: TaskManager) {
        taskManager.markComplete(task)
    }
    
    func markIncomplete(_ task: TaskModel, using taskManager: TaskManager) {
        taskManager.markIncomplete(task)
    }
}
