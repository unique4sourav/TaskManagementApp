//
//  AddTaskView.swift
//  ManageTask
//
//  Created by Sourav Santra on 26/11/24.
//

import SwiftUI

struct AddNewTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HomeViewModel
    
    @State var title: String = ""
    @State var dueDate = Calendar.current
        .date(byAdding: .minute, value: 30, to: Date()) ?? Date()
    @State var priority: PriorityOfTask = .medium
    @State var note: String = ""
    @State var selectedColor: Color = TaskBackground.orange.color
    @State var colors: [Color] = TaskBackground.allColors
    @State var showErrorAlert: Bool = false
    @State var errorString: String? = nil
    
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                cancelToolBarItem
                
                applyToolBarItem
            }
            .confirmationDialog("", isPresented: $showErrorAlert) {
                Button("Discard Saving", role: .destructive) {
                    errorString = nil
                    showErrorAlert = false
                    dismiss()
                }
            }
            
            
        }
        .tint(selectedColor)
    }

}

#Preview {
    AddNewTaskView(viewModel: HomeViewModel())
}


extension AddNewTaskView {
    private var titleView: some View {
        TextField("Add a task...", text: $title, axis: .vertical)
            .font(.headline)
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
                            UIApplication.shared.endEditing()
                        }
                    }
                , alignment: .trailing)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.secondary.opacity(0.25))
            }
            .padding(.top, 16)
            .submitLabel(.done)
            .onSubmit {
                UIApplication.shared.endEditing()
            }
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
            .padding(.trailing, 30)
            .lineLimit(5)
            .frame(height: 120)
            .background(.secondary.opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 16)
            .overlay (
                Image(systemName: "xmark.circle")
                    .padding()
                    .opacity(note.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        if !note.isEmpty {
                            note = ""
                            UIApplication.shared.endEditing()
                        }
                    }
                , alignment: .topTrailing)
            .submitLabel(.done)
        }
    }
    
    private var colorPickerView: some View {
//        Picker("Task Background", selection: $selectedColor) {
//            ForEach(colors, id: \.self) { color in
//                HStack {
//                    Image(systemName: "circle.fill")
//                        .foregroundStyle(color, Color.red)
//                    
//                    Text("  " + color.description.capitalized + " ")
//                }
//            }
//        }
//        .pickerStyle(.menu)
        
        
        
        VStack(alignment: .leading) {
            Text("Task Background")
            
            HStack {
                ForEach(colors, id: \.self) { color in
                    ZStack {
                        Circle().fill()
                            .foregroundStyle(color)
                            .padding(2)
                        
                        Circle()
                            .strokeBorder(selectedColor == color ? .gray : .clear, lineWidth: 2)
                            .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    }
                    .onTapGesture {
                        selectedColor = color
                    }
                }
            }
        }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
    
    private var cancelToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel", role: .destructive) {
                UIApplication.shared.endEditing()
                
                if !title.isEmpty {
                    showErrorAlert = true
                }
                else {
                    dismiss()
                }
            }
            .tint(.red)
        }
    }
    
    private var applyToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Save") {
                
                
            }
            .disabled(title.isEmpty)
        }
    }

}


