//
//  AddTaskViewModel.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation
import SwiftUI
import Combine
import Observation

enum AddTaskError: String, LocalizedError {
    case emptyTitle = "Task title is empty."
    case pastDate = "Due date of the task has alredy passed."
    
    var errorDescription: String? {
        self.rawValue
    }
}

@Observable
final class AddTaskViewModel: ObservableObject {
    var title: String = ""
    var dueDate: Date = .now.adding30MinsOrCurrentIfFail
    var priority: PriorityOfTask = .medium
    var note: String = ""
    var selectedColor: Color = AppConstant.defaultTaskColor
    let colors: [Color] = AppConstant.allTaskColors
    var shouldDismissView: Bool = false
    var shouldShowConfirmationDialouge: Bool = false
    @ObservationIgnored private(set) var confirmationMessage: String = ""
    var shouldShowErrorAlert: Bool = false
    @ObservationIgnored private(set) var error: AddTaskError? = nil
    
    
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
        
        taskManager.add(newTask)
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
