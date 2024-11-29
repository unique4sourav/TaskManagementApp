//
//  AddTaskConstant.swift
//  ManageTask
//
//  Created by Sourav Santra on 28/11/24.
//

import Foundation
struct AddTaskConstant {
    private init() { }
    
    static let navigationTitle = "Add New Task"
    
    struct Error {
        private init() { }
        
        static let alertTitle = "Oops!"
        static let buttonTitle = "Understood"
    }
    
    struct FieldTitle {
        private init() { }
        
        static let dueDate = "Due Date"
        static let priority = "Priority"
        static let note = "Note"
        static let taskBackground = "Task Background"
    }
    
    struct FieldPrompt {
        private init() { }
        
        static let title = "Add a task..."
        static let note = "Here you can add a note about your task."
    }
    
    struct ToolBarItemTitle {
        private init() { }
        
        static let cancel = "Cancel"
        static let save = "Save"
    }
    
    struct ConfirmationDialougeTitle {
        private init() { }
        
        static let discardSavng = "Discard Saving"
    }
}
