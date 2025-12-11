import Foundation
import SwiftUI

class WalletManager: ObservableObject {
    @Published var balance: Double = 0.0
    @Published var transactions: [Transaction] = []

    var formattedBalance: String {
        return "$\(String(format: "%.2f", balance))"
    }

    func addCash(amount: Double, description: String = "Cash Added") {
        guard amount > 0 else { return }

        balance += amount
        let transaction = Transaction(
            amount: amount,
            type: .cashIn,
            date: Date(),
            description: description
        )
        transactions.insert(transaction, at: 0) // Most recent first
    }

    func cashOut(amount: Double, description: String = "Cash Out") -> Bool {
        guard amount > 0 && amount <= balance else { return false }

        balance -= amount
        let transaction = Transaction(
            amount: amount,
            type: .cashOut,
            date: Date(),
            description: description
        )
        transactions.insert(transaction, at: 0) // Most recent first
        return true
    }

    // Demo data for testing
    func loadDemoData() {
        addCash(amount: 100.0, description: "Initial Balance")
        addCash(amount: 50.0, description: "Added from Bank")
        _ = cashOut(amount: 25.0, description: "Coffee Purchase")
        addCash(amount: 200.0, description: "Paycheck Deposit")
        _ = cashOut(amount: 75.0, description: "Grocery Store")
    }
}