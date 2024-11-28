//
//  TaskDetailsConstant.swift
//  ManageTask
//
//  Created by Sourav Santra on 28/11/24.
//

import Foundation
struct TaskDetailsConstant {
    private init() { }
    
    static let navigationTitle = "Task Details"
    
    
    struct FielTitle {
        private init() { }
        static let completion = "Completion Status"
        static let priority = "Priority"
        static let note = "Note"
    }
    
    struct Padding {
        private init() { }
        
        static let betweenNoteFieldAndContent: CGFloat = 4
    }
    
    struct ToolBarItemTitle {
        private init() { }
        
        static let markComplete = "Mark as Complete"
        static let markIncomplete = "Mark as Incomplete"
    }
    
    struct SFSymbolName {
        private init() { }
        
        static let edit = "square.and.pencil"
    }
}
