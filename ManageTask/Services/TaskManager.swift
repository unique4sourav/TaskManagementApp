//
//  TaskManager.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation
import Observation

import Foundation
import Observation

protocol TaskManagerProtocol: AnyObject {
    var allTasks: [TaskModel] { get set }
    func addTask(_ task: TaskModel)
    func update(_ task: TaskModel)
    func markComplete(_ task: TaskModel)
    func markIncomplete(_ task: TaskModel)
}

@Observable
final class TaskManager: ObservableObject, TaskManagerProtocol {
    var allTasks: [TaskModel] = /*[]*/ [PreviewContent.shared.task]
    
    func addTask(_ task: TaskModel) {
        allTasks.append(task)
    }
    
    func update(_ task: TaskModel) {
        // TODO: Add implementation
    }
    
    func markComplete(_ task: TaskModel) {
        guard let index = allTasks.firstIndex(where: { $0.id == task.id })
        else { return }
        
        allTasks[index].completionDate = Date()
    }
    
    func markIncomplete(_ task: TaskModel) {
        guard let index = allTasks.firstIndex(where: { $0.id == task.id })
        else { return }
        
        allTasks[index].completionDate = nil
    }
    
}
