//
//  TaskDetailsView.swift
//  ManageTask
//
//  Created by Sourav Santra on 26/11/24.
//

import SwiftUI

struct AddOrEditTaskView: View {
    @Environment(\.dismiss) var dismiss
    @State var task = TaskModel(
        title: "",
        dueDate: Calendar.current
            .date(byAdding: .minute, value: 15, to: Date()) ?? Date(),
        priority: .medium, notes: "")
    
    var body: some View {
        NavigationStack {
            List {
                titleView
                
                dueDateView
                
                priorityView
                
                noteView
            }
            .listStyle(.plain)
            .navigationTitle("Task Details")
            .toolbar {
                cancelToolBarItem
                
                applyToolBarItem
            }
        }
    }
}

#Preview {
    AddOrEditTaskView()
}



extension AddOrEditTaskView {
    
    private var titleView: some View {
        TextField("Add a task...", text: $task.title, axis: .vertical)
            .font(.title3)
            .bold()
            .frame(height: 40)
            .padding()
            .padding(.trailing, 30)
            .autocorrectionDisabled()
            .lineLimit(2)
            .overlay (
                Image(systemName: "xmark.circle")
                    .padding()
                    .opacity(task.title.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        if !task.title.isEmpty {
                            task.title = ""
                        }
                    }
                , alignment: .trailing)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.secondary.opacity(0.25))
            }
            .padding(.top, 16)
    }
    
    private var dueDateView: some View {
        DatePicker("Due Date", selection: $task.dueDate, in: task.dueDate...)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
    
    
    private var priorityView: some View {
        Picker("Priority", selection: $task.priority) {
            ForEach(PriorityOfTask.allCases, id: \.self) { priority in
                Text(priority.description)
            }
        }.pickerStyle(.menu)
            .tint(Color.primary)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
    
    private var noteView: some View {
        VStack(alignment: .leading) {
            Text("Note")
                .padding(.horizontal)
            
            TextField("Note",
                      text: $task.note,
                      prompt: Text("Here you can add a note about your task."),
                      axis: .vertical)
            .padding()
            .lineLimit(5)
            .frame(height: 120)
            .background(.secondary.opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 16)
        }
    }
    
    private var cancelToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel") {
                dismiss()
            }
        }
    }
    
    private var applyToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Save") {
                
                //dismiss()
            }
        }
    }
}
