//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by Eric Valle on February 17, 2025.
//
//  Description: Data manager to save user information on device.
//
//  © 2025 Eric Valle. All rights reserved.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "ExpenseTracker")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    // Save Function
    func save() {
        do {
            try context.save()
        } catch {
            print("Failed to save expense: \(error.localizedDescription)")
        }
    }
}
