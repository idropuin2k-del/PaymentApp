import SwiftUI

struct TransactionHistoryView: View {
    @EnvironmentObject var walletManager: WalletManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header with balance
                VStack(spacing: 12) {
                    HStack {
                        Button("Done") {
                            dismiss()
                        }
                        .font(.subheadline)

                        Spacer()

                        Text("Transaction History")
                            .font(.headline)
                            .fontWeight(.semibold)

                        Spacer()

                        // Invisible button for balance
                        Button("") { }
                            .opacity(0)
                    }

                    VStack(spacing: 4) {
                        Text("Current Balance")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text(walletManager.formattedBalance)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding()
                .background(Color(.systemGroupedBackground))

                // Transaction List
                if walletManager.transactions.isEmpty {
                    // Empty State
                    VStack(spacing: 16) {
                        Spacer()

                        Image(systemName: "clock")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)

                        Text("No Transactions Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)

                        Text("Your transaction history will appear here")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)

                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    List {
                        ForEach(walletManager.transactions) { transaction in
                            TransactionRowView(transaction: transaction)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct TransactionRowView: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 16) {
            // Transaction Icon
            ZStack {
                Circle()
                    .fill(iconBackgroundColor)
                    .frame(width: 48, height: 48)

                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(iconColor)
            }

            // Transaction Details
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)

                Text(transaction.formattedDate)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }

            Spacer()

            // Amount
            Text(transaction.formattedAmount)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(amountColor)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }

    private var iconName: String {
        switch transaction.type {
        case .cashIn:
            return "arrow.down.circle.fill"
        case .cashOut:
            return "arrow.up.circle.fill"
        }
    }

    private var iconColor: Color {
        switch transaction.type {
        case .cashIn:
            return .green
        case .cashOut:
            return .orange
        }
    }

    private var iconBackgroundColor: Color {
        switch transaction.type {
        case .cashIn:
            return .green.opacity(0.1)
        case .cashOut:
            return .orange.opacity(0.1)
        }
    }

    private var amountColor: Color {
        switch transaction.type {
        case .cashIn:
            return .green
        case .cashOut:
            return .orange
        }
    }
}

#Preview {
    TransactionHistoryView()
        .environmentObject(WalletManager())
}