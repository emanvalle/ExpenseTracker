import Foundation
import CoreData

struct ExpenseModel: Identifiable {
    var id: UUID
    var title: String
    var amount: Double
    var date: Date
    var category: String
}
