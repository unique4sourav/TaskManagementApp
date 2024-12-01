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
    var allTasks: [any TaskModelProtocol] { get set }
    func addTask(_ task: any TaskModelProtocol)
    func update(_ task: any TaskModelProtocol)
    func markComplete(_ task: any TaskModelProtocol)
    func markIncomplete(_ task: any TaskModelProtocol)
}

@Observable
final class TaskManager: ObservableObject, TaskManagerProtocol {
    var allTasks: [any TaskModelProtocol] = /*[]*/ [PreviewContent.shared.task]
    
    func addTask(_ task: any TaskModelProtocol) {
        allTasks.append(task)
    }
    
    func update(_ task: any TaskModelProtocol) {
        // TODO: Add implementation
    }
    
    func markComplete(_ task: any TaskModelProtocol) {
        guard let index = allTasks.firstIndex(where: { $0.id == task.id })
        else { return }
        
        allTasks[index].completionDate = Date()
    }
    
    func markIncomplete(_ task: any TaskModelProtocol) {
        guard let index = allTasks.firstIndex(where: { $0.id == task.id })
        else { return }
        
        allTasks[index].completionDate = nil
    }
    
}
