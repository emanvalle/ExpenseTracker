//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Eric Valle on February 25, 2025.
//
//  Description: Landing screen for ExpenseTracker app.
//
//  © 2025 Eric Valle. All rights reserved.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false // Dark Mode preference
//    @AppStorage("selectedCurrency") private var selectedCurrency = "USD" // Currency preference
//    @AppStorage("notificationsEnabled") private var notificationsEnabled = true // Notifications toggle

//    let currencyOptions = ["USD", "EUR", "GBP", "JPY", "INR"]

    var body: some View {
        NavigationView {
            Form {
                // 🌙 Dark Mode Toggle
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }

//                // 💰 Currency Selection
//                Section(header: Text("Preferences")) {
//                    Picker("Currency", selection: $selectedCurrency) {
//                        ForEach(currencyOptions, id: \.self) { currency in
//                            Text(currency)
//                        }
//                    }
//                }

//                // 🔔 Notifications Toggle
//                Section(header: Text("Notifications")) {
//                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
//                }
//                // 🔔 Notifications Toggle
//                Section(header: Text("Notifications")) {
//                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
//                        .onChange(of: notificationsEnabled) { newValue in
//                            toggleNotifications(isEnabled: newValue)
//                        }
//                }

                // 🗑️ Reset Data Option
//                Section {
//                    Button(action: resetExpenses) {
//                        Text("Reset All Expenses")
//                            .foregroundColor(.red)
//                    }
//                }
            }
            .navigationTitle("Settings")
        }
    }
    
//    // 🔔 Enable or Disable Notifications
//        func toggleNotifications(isEnabled: Bool) {
//            let center = UNUserNotificationCenter.current()
//            center.getNotificationSettings { settings in
//                DispatchQueue.main.async {
//                    if settings.authorizationStatus == .notDetermined {
//                        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
//                            DispatchQueue.main.async {
//                                if granted {
//                                    print("✅ Notifications enabled")
//                                    notificationsEnabled = true
//                                } else {
//                                    print("❌ Notifications denied")
//                                    notificationsEnabled = false
//                                }
//                            }
//                        }
//                    } else if settings.authorizationStatus == .denied {
//                        print("🚫 Notifications are disabled in system settings")
//                        notificationsEnabled = false
//                    } else {
//                        print("🔔 Notifications enabled: \(isEnabled)")
//                    }
//                }
//            }
//        }

    // Function to Reset All Expenses
//    func resetExpenses() {
//        let context = CoreDataManager.shared.context
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Expense.fetchRequest()
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(batchDeleteRequest)
//            try context.save()
//        } catch {
//            print("Failed to reset expenses: \(error.localizedDescription)")
//        }
//    }

//    func resetExpenses() {
//        let context = CoreDataManager.shared.context
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Expense.fetchRequest()
//        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        do {
//            try context.execute(batchDeleteRequest)
//            try context.save()
//            refreshView() // 🔥 Force UI update
//        } catch {
//            print("❌ Failed to reset expenses: \(error.localizedDescription)")
//        }
//    }

    
    func refreshView() {
        DispatchQueue.main.async {
            // Notifies SwiftUI that Core Data has changed
            let context = CoreDataManager.shared.context
            context.refreshAllObjects()
        }
    }


}
