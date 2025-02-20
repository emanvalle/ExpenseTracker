import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)])
    var expenses: FetchedResults<Expense>

    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            VStack {
                //ExpenseChartView() //Add chart at the top
                
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
