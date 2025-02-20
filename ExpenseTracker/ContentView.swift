//import SwiftUI
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)])
//    var expenses: FetchedResults<Expense>
//
//    @State private var showingAddExpense = false
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(expenses, id: \.id) { expense in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(expense.title ?? "Unknown")
//                                .font(.headline)
//                            Text(expense.category ?? "No Category")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                        Spacer()
//                        Text("$\(expense.amount, specifier: "%.2f")")
//                            .font(.headline)
//                            .foregroundColor(.blue)
//                    }
//                }
//                .onDelete(perform: deleteExpense)
//            }
//            .navigationTitle("Expenses")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        showingAddExpense = true
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddExpenseView().environment(\.managedObjectContext, moc)
//            }
//        }
//    }
//
//    func deleteExpense(at offsets: IndexSet) {
//        for index in offsets {
//            let expense = expenses[index]
//            moc.delete(expense)
//        }
//        do {
//            try moc.save()
//        } catch {
//            print("Failed to delete expense: \(error.localizedDescription)")
//        }
//    }
//}
//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
//SECOND COMMENT SECTION
//import SwiftUI
//
//struct ContentView: View {
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)])
//    var expenses: FetchedResults<Expense>
//
//    @State private var showingAddExpense = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                //ExpenseChartView() // Keep the chart at the top
//                
//                List {
//                    ForEach(expenses, id: \.id) { expense in
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(expense.title ?? "Unknown")
//                                    .font(.headline)
//                                Text(expense.category ?? "No Category")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                            }
//                            Spacer()
//                            Text("$\(expense.amount, specifier: "%.2f")")
//                                .font(.headline)
//                                .foregroundColor(.blue)
//                        }
//                    }
//                    .onDelete(perform: deleteExpense) // 🔥 Add delete functionality
//                }
//            }
//            .navigationTitle("Expenses")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton() // 🔥 Allows users to delete by tapping "Edit"
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        showingAddExpense = true
//                    }) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .sheet(isPresented: $showingAddExpense) {
//                AddExpenseView().environment(\.managedObjectContext, moc)
//            }
//        }
//    }
//
//    // 🗑️ Function to Delete Expenses
//    func deleteExpense(at offsets: IndexSet) {
//        for index in offsets {
//            let expense = expenses[index]
//
//            // Show an alert before deleting
//            let alert = UIAlertController(title: "Delete Expense?",
//                                          message: "Are you sure you want to remove \(expense.title ?? "this expense")?",
//                                          preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
//                moc.delete(expense)
//                try? moc.save()
//            }))
//
//            // Find the topmost view controller to present the alert
//            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let window = scene.windows.first,
//               let rootViewController = window.rootViewController {
//                rootViewController.present(alert, animated: true)
//            }
//        }
//    }
//}

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)])
    var expenses: FetchedResults<Expense>

    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            VStack {
                ExpenseChartView() // 🔥 Add chart at the top
                
                List {
                    ForEach(expenses, id: \.id) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.title ?? "Unknown")
                                    .font(.headline)
                                Text(expense.category ?? "No Category")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("$\(expense.amount, specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    .onDelete(perform: deleteExpense)
                }
            }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView().environment(\.managedObjectContext, moc)
            }
        }
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
