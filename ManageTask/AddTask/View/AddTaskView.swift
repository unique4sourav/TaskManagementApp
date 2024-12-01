//
//  AddTaskView.swift
//  ManageTask
//
//  Created by Sourav Santra on 26/11/24.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var taskManager: TaskManager
    
    @StateObject private var viewModel = AddTaskViewModel()
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
                
                saveToolBarItem
            }
            .confirmationDialog("", isPresented: $viewModel.shouldShowConfirmationDialouge) {
                Button(viewModel.confirmationMessage, role: .destructive) {
                    viewModel.dismissView()
                }
            }
            .alert(Text(AddTaskConstant.Error.alertTitle),
                   isPresented: $viewModel.shouldShowErrorAlert, actions: {
                Button(AddTaskConstant.Error.buttonTitle) {
                    viewModel.acknowledgeError()
                }
            }, message: {
                if let error = viewModel.error {
                    Text(error.localizedDescription)
                }
            })
            .onChange(of: viewModel.shouldDismissView, initial: false) { _, newValue in
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
        .environmentObject(TaskManager(dataStore: PreviewContent.shared.inMemoryDataStore))
}

// MARK: - SubViews
private extension AddTaskView {
    var titleView: some View {
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
            Image(systemName: AppConstant.SFSymbolName.cross)
                .padding()
                .opacity(viewModel.title.isEmpty ? 0.0 : 1.0)
                .onTapGesture { viewModel.clearTitle() }
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
    
    
    var dueDateView: some View {
        DatePicker(AddTaskConstant.FieldTitle.dueDate,
                   selection: $viewModel.dueDate,
                   in: Date().adding30MinsOrCurrentIfFail...)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    
    var priorityView: some View {
        Picker(AddTaskConstant.FieldTitle.priority,
               selection: $viewModel.priority) {
            ForEach(PriorityOfTask.allCases, id: \.self) { priority in
                Text(priority.description)
            }
        }.pickerStyle(.menu)
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
    
    var noteView: some View {
        VStack(alignment: .leading) {
            Text(AddTaskConstant.FieldTitle.note)
                .padding(.horizontal)
            
            TextField("", text: $viewModel.note,
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
                Image(systemName: AppConstant.SFSymbolName.cross)
                    .padding()
                    .opacity(viewModel.note.isEmpty ? 0.0 : 1.0)
                    .onTapGesture { viewModel.clearNote() }
                , alignment: .topTrailing)
            .onChange(of: viewModel.note, initial: true, { _, newValue in
                if let last = newValue.last, last == "\n" {
                    viewModel.note.removeLast()
                    handleOnSubmitInKeyboard()
                }
            })
        }
    }
    
    var colorPickerView: some View {
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
    
    var cancelToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarLeading) {
            Button(AddTaskConstant.ToolBarItemTitle.cancel, role: .destructive) {
                focusedField = nil
                viewModel.cancelAddingTask()
            }
            .tint(.red)
        }
    }
    
    var saveToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button(AddTaskConstant.ToolBarItemTitle.save) {
                focusedField = nil
                viewModel.addTask(using: taskManager)
            }
            .disabled(viewModel.title.isEmpty)
        }
    }
    
    
}

// MARK: - View functions
private extension AddTaskView {
    func handleOnSubmitInKeyboard() {
        switch focusedField {
        case .title:
            focusedField = .note
        case .note:
            focusedField = nil
        case nil:
            break
        }
    }
}

// MARK: - Custom types
private extension AddTaskView {
    enum FocusedField {
        case title, note
    }

}
