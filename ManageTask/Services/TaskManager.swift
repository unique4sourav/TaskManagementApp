//
//  TaskManager.swift
//  ManageTask
//
//  Created by Sourav Santra on 27/11/24.
//

import Foundation

class TaskManager: ObservableObject {
    // TODO: Make the all task array empty once done with testing
    @Published var allTasks: [TaskModel] =  /*[]*/ [PreviewContent.shared.task]
    
    func addTask(_ task: TaskModel) {
        allTasks.append(task)
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


