//
//  ExpenseChartView.swift
//  ExpenseTracker
//
//  Created by Eric Valle on February 17, 2025.
//
//  Description: Data visualization for expenses.
//
//  © 2025 Eric Valle. All rights reserved.
//

import SwiftUI
import Charts

struct ExpenseChartView: View {
    @FetchRequest(
        entity: Expense.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)]
    ) var expenses: FetchedResults<Expense>

    var body: some View {
        VStack {
            Text("Expenses Breakdown")
                .font(.title2)
                .bold()
                .padding(.bottom, 10)

            if expenses.isEmpty {
                Text("No expenses to show")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                Chart(expenses) { expense in
                    BarMark(
                        x: .value("Category", expense.category ?? "Other"),
                        y: .value("Amount", expense.amount)
                    )
                    .foregroundStyle(by: .value("Category", expense.category ?? "Other"))
                }
                .frame(height: 300)
                .padding()
            }
        }
    }
}
