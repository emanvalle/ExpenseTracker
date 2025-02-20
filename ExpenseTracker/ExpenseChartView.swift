import SwiftUI
import Charts

struct ExpenseChartView: View {
    @FetchRequest(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)])
    var expenses: FetchedResults<Expense>

    var body: some View {
        VStack {
            Text("Expenses Breakdown")
                .font(.title2)
                .bold()
                .padding(.bottom, 10)

//            Chart(expenses) { expense in
//                BarMark(
//                    x: .value("Category", expense.category ?? "Other"),
//                    y: .value("Amount", expense.amount)
//                )
//                .foregroundStyle(by: .value("Category", expense.category ?? "Other"))
//            }
            Chart(expenses) { expense in
                SectorMark(
                    angle: .value("Amount", expense.amount),
                    innerRadius: .ratio(0.5),
                    outerRadius: .ratio(1.0)
                )
                .foregroundStyle(by: .value("Category", expense.category ?? "Other"))
            }

            .frame(height: 300)
            .padding()
        }
    }
}
