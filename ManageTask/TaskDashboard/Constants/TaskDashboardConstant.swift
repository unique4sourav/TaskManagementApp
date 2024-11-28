//
//  TaskDashboardConstant.swift
//  ManageTask
//
//  Created by Sourav Santra on 28/11/24.
//

import Foundation

struct TaskDashboardConstant {
    private init() {}
    static let navigationTitle = "All Tasks"
    
    
    struct SFSymbolName {
        private init() {}
        static let addNewTask = "plus.circle"
        static let inactiveFilter = "line.3.horizontal.decrease.circle"
        static let activeFilter = "line.3.horizontal.decrease.circle.fill"
        static let sort = "arrow.up.arrow.down.circle"
        static let checkmark = "checkmark"
        static let incompleteTask = "circle"
        static let completedTask = "checkmark.circle.fill"
    }
}
