//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Eric Valle on February 17, 2025.
//
//  Description: Landing screen for ExpenseTracker app.
//
//  © 2025 Eric Valle. All rights reserved.
//


import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)])
    var expenses: FetchedResults<Expense>

    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showingAddExpense = false
    @State private var showingSettings = false

    var body: some View {
        NavigationView {
            VStack {
//                Toggle("Dark Mode", isOn: $isDarkMode)
//                    .padding()
                
                ExpenseChartView() //Add chart at the top
                
                List {
                    ForEach(expenses, id: \.id) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.title ?? "Unknown")
                                    .font(.headline)
                                    .foregroundColor(Color("TextColor"))
                                Text(expense.category ?? "No Category")
                                    .font(.subheadline)
                                    .foregroundColor(Color("TextColor"))
                            }
                            Spacer()
                            Text("$\(expense.amount, specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(Color("TextColor"))
                        }
                    }
                    .onDelete(perform: deleteExpense)
                }
            }
            .background(Color("PrimaryBackground"))
            .navigationTitle("Expenses")
//            .background(Color("PrimaryBackground"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gear") // ⚙️ Settings icon
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
//            .background(Color("PrimaryBackground"))
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView().environment(\.managedObjectContext, moc)
            }
            .background(Color("PrimaryBackground"))
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = expenses[index]
            moc.delete(expense)
        }
        do {
            try moc.save()
        } catch {
            print("Failed to delete expense: \(error.localizedDescription)")
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
