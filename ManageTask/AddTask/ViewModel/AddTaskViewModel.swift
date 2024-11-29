//
//  AddNewTaskViewModel.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation
import SwiftUI
import Combine

enum AddNewTaskError: String, LocalizedError {
    case emptyTitle = "Task title is empty."
    case pastDate = "Due date of the task has alredy passed."
    
    var errorDescription: String? {
        self.rawValue
    }
}

class AddTaskViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var dueDate = Date().adding30MinsOrCurrentIfFail
    @Published var priority: PriorityOfTask = .medium
    @Published var note: String = ""
    @Published var selectedColor: Color = TaskBackground.defaultStyle.color
    @Published var colors: [Color] = TaskBackground.allColors
    @Published var confirmationDialouge: (shouldShow: Bool, message: String?) = (false, nil)
    @Published var errorAlert: (shouldShow: Bool, error: AddNewTaskError?) = (false, nil)
    @Published var isTaskAdded: Bool = false
    
    @MainActor
    func addNewTask(using taskManager: TaskManager) async throws {
        guard !title.isEmpty
        else { throw  AddNewTaskError.emptyTitle}
        
        guard dueDate > Date()
        else { throw AddNewTaskError.pastDate }
        
        let newTask = TaskModel(
            title: title, dueDate: dueDate, priority: priority, notes: note, color: selectedColor)
        
        taskManager.addTask(newTask)
        isTaskAdded = true
    }
}
