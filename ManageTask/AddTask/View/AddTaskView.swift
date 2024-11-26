//
//  AddTaskView.swift
//  ManageTask
//
//  Created by Sourav Santra on 26/11/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var title: String = ""
    @State var dueDate = Calendar.current
        .date(byAdding: .minute, value: 30, to: Date()) ?? Date()
    @State var priority: PriorityOfTask = .medium
    @State var note: String = ""
    @State var color: Color = TaskBackground.pink.color
    @State var colors: [Color] = TaskBackground.allColors
    
    var body: some View {
        NavigationStack {
            List {
                titleView
                
                dueDateView
                
                priorityView
                
                noteView
                
                colorPickerView
            }
            .listStyle(.plain)
            .navigationTitle("Add New Task")
            .toolbar {
                cancelToolBarItem
                
                applyToolBarItem
            }
        }
        .tint(color)
    }

}

#Preview {
    AddTaskView()
}


extension AddTaskView {
    private var titleView: some View {
        TextField("Add a task...", text: $title, axis: .vertical)
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
                    .opacity(title.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        if !title.isEmpty {
                            title = ""
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
        DatePicker("Due Date", selection: $dueDate, in: dueDate...)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
    
    
    private var priorityView: some View {
        Picker("Priority", selection: $priority) {
            ForEach(PriorityOfTask.allCases, id: \.self) { priority in
                Text(priority.description)
            }
        }.pickerStyle(.menu)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
    
    private var noteView: some View {
        VStack(alignment: .leading) {
            Text("Note")
                .padding(.horizontal)
            
            TextField("Note",
                      text: $note,
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
    
    private var colorPickerView: some View {
        Picker("Task Background", selection: $color) {
            ForEach(colors, id: \.self) { color in
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(color, Color.red)
                    
                    Text("  " + color.description.capitalized + " ")
                }
            }
        }
        .pickerStyle(.menu)
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
