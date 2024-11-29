//
//  AddTaskView.swift
//  ManageTask
//
//  Created by Sourav Santra on 26/11/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var taskManager: TaskManager
    
    @StateObject private var viewModel = AddNewTaskViewModel()
    @FocusState private var focusedField: FocusedField?
    
    
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
            .navigationTitle(AddTaskConstant.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                cancelToolBarItem
                
                applyToolBarItem
            }
            .confirmationDialog("", isPresented: $viewModel.confirmationDialouge.shouldShow) {
                Button(viewModel.confirmationDialouge.message ?? "", role: .destructive) {
                    viewModel.confirmationDialouge = (false, nil)
                    dismiss()
                }
            }
            .alert(Text(AddTaskConstant.Error.alertTitle), isPresented: $viewModel.errorAlert.shouldShow, actions: {
                Button(AddTaskConstant.Error.buttonTitle) {
                    viewModel.errorAlert = (false, nil)
                }
            }, message: {
                Text(viewModel.errorAlert.error?.localizedDescription ?? "")
            })
            .onChange(of: viewModel.isTaskAdded, initial: false) { _, newValue in
                if newValue {
                    dismiss()
                }
            }
            
        }
        .tint(viewModel.selectedColor)
    }
    
}

#Preview {
    AddTaskView()
        .environmentObject(TaskManager())
}


extension AddTaskView {
    enum FocusedField {
        case title, note
    }
    
    private var titleView: some View {
        TextField(AddTaskConstant.FieldPrompt.title,
                  text: $viewModel.title, axis: .vertical)
            .font(.headline)
            .fontWeight(.semibold)
            .frame(height: 40)
            .padding()
            .padding(.trailing, 30)
            .autocorrectionDisabled()
            .lineLimit(2)
            .focused($focusedField, equals: .title)
            .submitLabel(.next)
            .overlay (
                Image(systemName: AddTaskConstant.SFSymbolName.cross)
                    .padding()
                    .opacity(viewModel.title.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        if !viewModel.title.isEmpty {
                            viewModel.title = ""
                            focusedField = nil
                        }
                    }
                , alignment: .trailing)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.secondary.opacity(0.25))
            }
            .padding(.top, 16)
            .onChange(of: viewModel.title, initial: true, { _, newValue in
                if let last = newValue.last, last == "\n" {
                    viewModel.title.removeLast()
                    handleOnSubmitInKeyboard()
                }
            })
        
    }
    
    private func handleOnSubmitInKeyboard() {
        switch focusedField {
        case .title:
            focusedField = .note
        case .note:
            focusedField = nil
        case nil:
            break
        }
    }
    
    private var dueDateView: some View {
        DatePicker(AddTaskConstant.FieldTitle.dueDate,
                   selection: $viewModel.dueDate,
                   in: Date().adding30MinsOrCurrentIfFail...)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
    
    
    private var priorityView: some View {
        Picker(AddTaskConstant.FieldTitle.priority,
               selection: $viewModel.priority) {
            ForEach(PriorityOfTask.allCases, id: \.self) { priority in
                Text(priority.description)
            }
        }.pickerStyle(.menu)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
    
    private var noteView: some View {
        VStack(alignment: .leading) {
            Text(AddTaskConstant.FieldTitle.note)
                .padding(.horizontal)
            
            TextField("",
                      text: $viewModel.note,
                      prompt: Text(AddTaskConstant.FieldPrompt.note),
                      axis: .vertical)
            .padding()
            .padding(.trailing, 30)
            .lineLimit(5)
            .frame(height: 120)
            .background(.secondary.opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 16)
            .focused($focusedField, equals: .note)
            .submitLabel(.done)
            .overlay (
                Image(systemName: AddTaskConstant.SFSymbolName.cross)
                    .padding()
                    .opacity(viewModel.note.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        if !viewModel.note.isEmpty {
                            viewModel.note = ""
                            focusedField = nil
                        }
                    }
                , alignment: .topTrailing)
            .onChange(of: viewModel.note, initial: true, { _, newValue in
                if let last = newValue.last, last == "\n" {
                    viewModel.note.removeLast()
                    handleOnSubmitInKeyboard()
                }
            })
        }
    }
    
    private var colorPickerView: some View {
        //        Picker("Task Background", selection: $viewModel.selectedColor) {
        //            ForEach(TaskBackground.allColors, id: \.self) { color in
        //                        HStack {
        //                            Image(systemName: "circle.fill")
        //                                .foregroundStyle(color, Color.red)
        //
        //                            Text("  " + color.description.capitalized + " ")
        //                        }
        //                    }
        //                }
        //                .pickerStyle(.menu)
        
        
        
        VStack(alignment: .leading) {
            Text(AddTaskConstant.FieldTitle.taskBackground)
            
            HStack {
                ForEach(viewModel.colors, id: \.self) { color in
                    ZStack {
                        Circle().fill()
                            .foregroundStyle(color)
                            .padding(2)
                        
                        Circle()
                            .strokeBorder(viewModel.selectedColor == color ? .gray : .clear, lineWidth: 2)
                            .scaleEffect(CGSize(width: 1.2, height: 1.2))
                    }
                    .onTapGesture {
                        viewModel.selectedColor = color
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
            Button(AddTaskConstant.ToolBarItemTitle.cancel, role: .destructive) {
                focusedField = nil
                
                if !viewModel.title.isEmpty {
                    viewModel.confirmationDialouge =
                    (true,
                     AddTaskConstant.ConfirmationDialouge.ActionTitle.discardSavng)
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
            Button(AddTaskConstant.ToolBarItemTitle.save) {
                Task {
                    do {
                        try await viewModel.addNewTask(using: taskManager)
                    }
                    catch let error as AddNewTaskError {
                        viewModel.errorAlert = (true, error)
                    }
                }
            }
            .disabled(viewModel.title.isEmpty)
        }
    }
    
    
}


