//
//  TaskCompletionIconView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

enum TaskCompletionIcon {
    static let incomplete = Image(systemName: "circle")
    static let complete = Image(systemName: "checkmark.circle.fill")
}

enum TaskCompletionStatus {
    case incomplete
    case completed
}

struct TaskCompletionIconView: View {
    var taskCompletionTask: TaskCompletionStatus
    var foregroundColor: Color?
    
    init(for completionStatus: TaskCompletionStatus,
         foregroundColor: Color? = nil) {
        self.taskCompletionTask = completionStatus
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        VStack {
            if taskCompletionTask == .completed {
                TaskCompletionIcon.complete
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            else {
                TaskCompletionIcon.incomplete
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .foregroundStyle(foregroundColor ?? .primary)
        
    }
}


#Preview {
    TaskCompletionIconView(for: .completed, foregroundColor: .brown)
        .frame(width: 40)
}
