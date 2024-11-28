//
//  TaskDashboardFilteringConstant.swift
//  ManageTask
//
//  Created by Sourav Santra on 28/11/24.
//

import Foundation


struct TaskDashboardFilteringConstant {
    private init() { }
    
    static let navigationTitle = "Filter Tasks"
    static let filterSectionTitle = "Filter by:"
    
    struct ToolBarItemTitle {
        private init() { }
        
        static let apply = "Apply"
        static let cancel = "Cancel"
    }
    
    struct FieldTitle {
        private init() { }
        
        static let dateFrom = "From"
        static let dateTo = "To"
    }
}
