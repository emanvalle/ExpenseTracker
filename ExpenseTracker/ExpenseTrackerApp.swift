//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Eric Valle on February 17, 2025.
//
//  Description: Main code for ExpenseTracker app.
//
//  © 2025 Eric Valle. All rights reserved.
//

//import SwiftUI
//
//@main
//struct ExpenseTrackerApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") private var isDarkMode = false
    
//    init() {
//        requestNotificationPermission()
//    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light) // 🔥 Apply theme globally
        }
    }
    
//    // 🔔 Request Notification Permission
//        func requestNotificationPermission() {
//            let center = UNUserNotificationCenter.current()
//            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//                if granted {
//                    print("✅ Notifications enabled!")
//                } else {
//                    print("❌ User denied notifications")
//                }
//            }
//        }
}
