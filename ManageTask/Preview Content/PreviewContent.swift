//
//  PreviewContent.swift
//  ManageTask
//
//  Created by Sourav Santra on 28/11/24.
//

import Foundation
import SwiftUI

class PreviewContent {
    static let shared = PreviewContent()
    
    private init() { }
    
    let task: any TaskModelProtocol =  TaskModel(title: "Complete developing the task management app.",
                          dueDate: Date().addingTimeInterval(Double((-1_000_000_0...1_000_000_0).randomElement() ?? 0)),
                          priority: PriorityOfTask.allCases.randomElement() ?? .medium,
                          notes: "Task Management App This app will help users manage their tasks effectively. Key Features: \n* Home Screen: Displays a list of tasks with options to filter by priorities or due dates. \n* Add/Edit Task Screen: Allows users to add or edit a task, specifying details like title, due date, priority, and notes. Implement data persistence to save tasks. \n* Task Details Screen: Shows detailed information about a selected task with options to mark it as complete or delete it. \n* Dummy Description: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          completionDate: [
                            Date().addingTimeInterval(Double((-1_000_000_0...1_000_000_0).randomElement() ?? 0)),
                            nil
                          ] .randomElement() ?? nil,
                          color: AppConstant.allTaskColors.randomElement() ?? AppConstant.defaultTaskColor
    )
}
