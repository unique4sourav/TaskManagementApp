//
//  TaskManager.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation
import Observation

@Observable
final class TaskManager: ObservableObject, TaskManagerProtocol {
    private let dataStore: TaskDataStore
    var allTasks: [any TaskModelProtocol] = []
    
    init(dataStore: TaskDataStore) {
        self.dataStore = dataStore
        _ = fetchAllTask()
    }
    
    func fetchAllTask() -> [TaskModelProtocol] {
        let allTasks = dataStore.fetchAllTask()
        self.allTasks = allTasks
        return allTasks
    }
    
    func add(_ task: TaskModelProtocol) {
        dataStore.add(task)
        allTasks.append(task)
    }
    
    func update(_ task: TaskModelProtocol) {
        dataStore.update(task)
        allTasks = dataStore.fetchAllTask()
    }
    
    
    func markComplete(_ task: any TaskModelProtocol) {
        var updatedTask = task
        updatedTask.completionDate = .now
        update(updatedTask)
    }
    
    func markIncomplete(_ task: any TaskModelProtocol) {
        var updatedTask = task
        updatedTask.completionDate = nil
        update(updatedTask)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func addTask(_ task: any TaskModelProtocol) {
//        allTasks.append(task)
//    }
//    
//    func update(_ task: any TaskModelProtocol) {
//        // TODO: Add implementation
//    }
//    
//    func markComplete(_ task: any TaskModelProtocol) {
//        guard let index = allTasks.firstIndex(where: { $0.id == task.id })
//        else { return }
//        
//        allTasks[index].completionDate = Date()
//    }
//    
//    func markIncomplete(_ task: any TaskModelProtocol) {
//        guard let index = allTasks.firstIndex(where: { $0.id == task.id })
//        else { return }
//        
//        allTasks[index].completionDate = nil
//    }
    
}
