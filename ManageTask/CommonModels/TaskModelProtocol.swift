//
//  TaskModelProtocol.swift
//  ManageTask
//
//  Created by Sourav Santra on 01/12/24.
//

import SwiftUI

protocol TaskModelProtocol {
    var id: UUID { get }
    var title: String { get set }
    var dueDate: Date { get set }
    var priority: PriorityOfTask { get set }
    var note: String { get set }
    var completionDate: Date? { get set }
    var color: Color { get set }
}

extension TaskModelProtocol {
    var isCompleted: Bool {
        completionDate != nil ? true : false
    }
    
    var completionStatus: TaskCompletionStatus {
        if isCompleted {
            return .completed
        }
        else if dueDate > Date() {
            return .incomplete
        }
        else {
            return .overdue
        }
    }
}
