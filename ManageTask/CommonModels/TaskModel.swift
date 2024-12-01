//
//  Task.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import Foundation
import Combine
import SwiftUI



struct TaskModel: TaskModelProtocol {
    let id = UUID()
    var title: String
    var dueDate: Date
    var priority: PriorityOfTask
    var note: String
    var completionDate: Date? = nil
    var color: Color
    
    init(title: String, dueDate: Date, priority: PriorityOfTask,
         notes: String, completionDate: Date? = nil,
         color: Color = AppConstant.defaultTaskColor) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
        self.note = notes
        self.completionDate = completionDate
        self.color = color
    }
}
