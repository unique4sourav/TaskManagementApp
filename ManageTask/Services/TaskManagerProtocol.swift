//
//  TaskManagerProtocol.swift
//  ManageTask
//
//  Created by Sourav Santra on 01/12/24.
//

import Foundation

protocol TaskManagerProtocol:
    AnyObject,
    FetchTaskProtocol,
    AddTaskProtocol,
    UpdateTaskProtocol {
    var allTasks: [any TaskModelProtocol] { get set }
    func markComplete(_ task: TaskModelProtocol)
    func markIncomplete(_ task: TaskModelProtocol)
}
