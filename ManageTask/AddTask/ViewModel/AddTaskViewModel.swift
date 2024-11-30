//
//  AddTaskViewModel.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation
import SwiftUI
import Combine

enum AddTaskError: String, LocalizedError {
    case emptyTitle = "Task title is empty."
    case pastDate = "Due date of the task has alredy passed."
    
    var errorDescription: String? {
        self.rawValue
    }
}

final class AddTaskViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var dueDate: Date = .now.adding30MinsOrCurrentIfFail
    @Published var priority: PriorityOfTask = .medium
    @Published var note: String = ""
    @Published var selectedColor: Color = AppConstant.defaultTaskColor
    @Published var colors: [Color] = AppConstant.allTaskColors
    @Published var shouldDismissView: Bool = false
    @Published var shouldShowConfirmationDialouge: Bool = false
    @Published var confirmationMessage: String = ""
    @Published var shouldShowErrorAlert: Bool = false
    @Published var error: AddTaskError? = nil
    
    
    func addTask(using taskManager: TaskManagerProtocol) {
        guard !title.isEmpty
        else {
            error = AddTaskError.emptyTitle
            shouldShowErrorAlert = true
            return
        }
        
        guard dueDate > .now
        else {
            error = AddTaskError.pastDate
            shouldShowErrorAlert = true
            return
        }
        
        let newTask = TaskModel(
            title: title, dueDate: dueDate, priority: priority, notes: note, color: selectedColor)
        
        taskManager.addTask(newTask)
        dismissView()
    }
    
    func cancelAddingTask() {
        if !title.isEmpty {
            confirmationMessage = AddTaskConstant.ConfirmationDialougeMessage.discardSaving
            shouldShowConfirmationDialouge = true
        }
        else {
            dismissView()
        }
    }
    
    func dismissView() {
        shouldDismissView = true
    }
    
    func acknowledgeError() {
        shouldShowErrorAlert = false
        error = nil
    }
    
    func clearTitle() {
        title = ""
    }
    
    func clearNote() {
        note = ""
    }
}
