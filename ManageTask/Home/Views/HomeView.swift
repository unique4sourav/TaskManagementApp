//
//  HomeView.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State var shouldShowAddNewTaskView = false
    @State var shouldShowFilteringOptionView = false
    @State var shouldShowSortingOptionView = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                taskCompletionSegment
                
                taskList
                    .listStyle(.plain)
                    .onAppear {
                        if viewModel.refinedTasks.isEmpty {
                            viewModel.fetchAllTasks()
                        }
                    }
            }
            //.overlay(alignment: .bottomTrailing) { addNewTaskCustomButton }
            .navigationTitle("All Tasks")
            .toolbar {
                addNewTaskToolBarItem
                
                filteringToolBarItem
                
                sortingToolBarItem
                
            }
            
        }
    }
    
}

#Preview {
    HomeView()
}


extension HomeView {
    private var taskCompletionSegment: some View {
        Picker("Task Completion Status",
               selection: $viewModel.selectedTaskCompletionStatus) {
            ForEach(TaskCompletionStatus.allCases) { taskCompletionStatus in
                Text(taskCompletionStatus.rawValue)
            }
        }.pickerStyle(.segmented)
            .padding(.horizontal)
            .shadow(color: Color.shadow, radius: 10, x: 0, y: 0)
    }
    
    private var taskList: some View {
        List {
            ForEach($viewModel.refinedTasks) { task in
                ZStack(alignment: .leading) {
                    TaskView(task: task)
                    NavigationLink {
                        EmptyView()
                    } label: {
                        EmptyView()
                    }
                    .opacity(0)
                }
                .listRowSeparator(.hidden)
                
            }
        }
    }
    
    
    private var addNewTaskToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowAddNewTaskView.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .sheet(isPresented: $shouldShowAddNewTaskView) {
                EmptyView()
            }
        }
    }
    
    private var filteringToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowSortingOptionView.toggle()
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .sheet(isPresented: $shouldShowSortingOptionView) {
                FilteringView(viewModel: viewModel)
            }
        }
    }
    
    
    private var sortingToolBarItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                shouldShowFilteringOptionView.toggle()
            } label: {
                ZStack {
                    Image(systemName:
                            viewModel.selectedSortingOption != nil ?
                          "arrow.up.arrow.down.circle.fill" :
                            "arrow.up.arrow.down.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
            }
            .sheet(isPresented: $shouldShowFilteringOptionView) {
                SortingView(viewModel: viewModel)
            }
        }
    }
    
    private var addNewTaskCustomButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.mint)
                .northWestShadow(radius: 3, offset: 3)
                .frame(width: 60, height: 60)
            
            RoundedRectangle(cornerRadius: 8)
                .inset(by: 3)
                .fill(Color.mint)
                .southEastShadow(radius: 1, offset: 1)
                .frame(width: 60, height: 60)
            
            Image(systemName: "plus.circle")
                .resizable()
                .foregroundStyle(Color.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
            
        }
        .offset(x: -24, y: -24)
    }
}
