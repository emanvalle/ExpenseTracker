//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Eric Valle on February 17, 2025.
//
//  Description: Struct definition for expense data stored.
//
//  © 2025 Eric Valle. All rights reserved.
//

import Foundation
import CoreData

struct ExpenseModel: Identifiable {
    var id: UUID
    var title: String
    var amount: Double
    var date: Date
    var category: String
}
