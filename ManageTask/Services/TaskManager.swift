//
//  TaskManager.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation
import Observation

protocol TaskManagerProtocol: AnyObject {
    var allTasks: [TaskModel] { get set }
    func addTask(_ task: TaskModel)
    func update(_ task: TaskModel)
}

@Observable
final class TaskManager: ObservableObject, TaskManagerProtocol {
    var allTasks: [TaskModel] = []
    
    func addTask(_ task: TaskModel) {
        allTasks.append(task)
    }
    
    func update(_ task: TaskModel) {
        // TODO: Add implementation
    }
}


