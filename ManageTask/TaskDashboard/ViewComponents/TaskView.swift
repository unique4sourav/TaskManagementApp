//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    let task: any TaskModelProtocol
    @ObservedObject var viewModel: TaskDashboardViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    taskTitle
                    otherTaskDetails
                }
                .foregroundStyle(.white)
                
                taskCompletionView
                rightArrow
            }
            .padding(.all, 16)
            .background(backgroundEffect)
            .padding(.horizontal, 0)
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = TaskDashboardViewModel()
    let task = PreviewContent.shared.task
    TaskView(task: task, viewModel: viewModel)
}



extension TaskView {
    
    private var taskTitle: some View {
        HStack {
            Text(task.title)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Spacer()
        }
    }
    
    private var otherTaskDetails: some View {
        HStack {
            Text(task.dueDate.dateString)
            Text("|")
            Text(task.priority.description)
        }
        .font(.subheadline)
    }
    
    private var taskCompletionView: some View {
        TaskCompletionIconView(
            for: task.completionDate != nil ?
                .completed : .incomplete,
            foregroundColor: .white)
        .frame(width: 20)
        .onTapGesture {
            viewModel.toggleCompletion(of: task, using: taskManager)
        }
    }
    
    private var rightArrow: some View {
        Image(systemName: AppConstant.SFSymbolName.rightArrow)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 8)
            .foregroundStyle(.white)
    }
    
    private var backgroundEffect: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(task.color)
                .northWestShadow(radius: 3, offset: 1)
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 2)
                .fill(task.color)
                .southEastShadow(radius: 1, offset: 1)
        }
    }
}
