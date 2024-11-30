//
//  TaskManager.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation

protocol TaskManagerProtocol: AnyObject {
    var allTasks: [TaskModel] { get set }
    func addTask(_ task: TaskModel)
    func update(_ task: TaskModel)
}

final class TaskManager: ObservableObject, TaskManagerProtocol {
    @Published var allTasks: [TaskModel] = []
    
    func addTask(_ task: TaskModel) {
        allTasks.append(task)
    }
    
    func update(_ task: TaskModel) {
        // TODO: Add implementation
    }
}


