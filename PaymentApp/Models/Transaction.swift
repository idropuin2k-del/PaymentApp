import Foundation

struct Transaction: Identifiable, Codable {
    let id = UUID()
    let amount: Double
    let type: TransactionType
    let date: Date
    let description: String

    var formattedAmount: String {
        let prefix = type == .cashIn ? "+" : "-"
        return "\(prefix)$\(String(format: "%.2f", amount))"
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

enum TransactionType: String, Codable, CaseIterable {
    case cashIn = "Cash In"
    case cashOut = "Cash Out"

    var color: String {
        switch self {
        case .cashIn:
            return "green"
        case .cashOut:
            return "red"
        }
    }
}