//import SwiftUI
//
//struct AddExpenseView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var title: String = ""
//    @State private var amount: String = ""
//    @State private var category: String = ""
//    @State private var date = Date()
//
//    var body: some View {
//        NavigationView {
//            Form {
//                TextField("Title", text: $title)
//                TextField("Amount", text: $amount)
//                    .keyboardType(.decimalPad)
//                TextField("Category", text: $category)
//                DatePicker("Date", selection: $date, displayedComponents: .date)
//            }
//            .navigationTitle("Add Expense")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Cancel") {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Save") {
//                        // Save logic
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }
//            }
//        }
//    }
//}

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var amount = ""
    @State private var category = ""
    @State private var date = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                TextField("Category", text: $category)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        addExpense()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    func addExpense() {
        let newExpense = Expense(context: moc)
        newExpense.id = UUID()
        newExpense.title = title
        newExpense.amount = Double(amount) ?? 0.0
        newExpense.category = category
        newExpense.date = date

        do {
            try moc.save()
        } catch {
            print("Failed to save expense: \(error.localizedDescription)")
        }
    }
}
