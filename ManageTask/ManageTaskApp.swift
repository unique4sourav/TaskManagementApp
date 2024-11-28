//
//  ManageTaskApp.swift
//  ManageTask
//
//  Created by Sourav Santra on 14/11/24.
//

import SwiftUI
import SwiftData

@main
struct ManageTaskApp: App {
    @StateObject private var taskManager = TaskManager()

    var body: some Scene {
        WindowGroup {
            TaskDashboardView()
                .environmentObject(taskManager)
        }
 
    }
}
