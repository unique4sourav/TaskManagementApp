//
//  InMemoryTaskDataStore.swift
//  ManageTask
//
//  Created by Sourav Santra on 02/12/24.
//

import Foundation


final class InMemoryTaskDataStore: TaskDataStore {
    private var allTasks: [any TaskModelProtocol] = []
    
    func fetchAllTask() -> [any TaskModelProtocol] {
        if allTasks.isEmpty {
            allTasks.append(PreviewContent.shared.task)
        }
        return allTasks
    }
    
    func add(_ task: any TaskModelProtocol) {
        allTasks.append(task)
    }
    
    func update(_ task: any TaskModelProtocol) {
        guard let index = allTasks.firstIndex(where: {$0.id == task.id})
        else { return }
        
        allTasks[index] = task
    }
}
