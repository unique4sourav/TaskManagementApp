//
//  TaskManager.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation

class TaskManager: ObservableObject {
    @Published var allTasks: [TaskModel] = []
    
    func addTask(_ task: TaskModel) {
        allTasks.append(task)
    }
    
}


