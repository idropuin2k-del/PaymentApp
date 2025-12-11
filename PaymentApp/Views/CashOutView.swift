import SwiftUI

struct CashOutView: View {
    @EnvironmentObject var walletManager: WalletManager
    @Environment(\.dismiss) private var dismiss
    @State private var amount: String = ""
    @State private var selectedAmount: Double? = nil
    @State private var showingSuccess = false
    @State private var showingError = false
    @State private var errorMessage = ""

    var quickAmounts: [Double] {
        let balance = walletManager.balance
        let amounts: [Double] = [10, 20, 50, 100, 200, 500]
        return amounts.filter { $0 <= balance }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Cash Out")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Withdraw money from your account")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)

                // Current Balance
                VStack(spacing: 4) {
                    Text("Available Balance")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(walletManager.formattedBalance)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(walletManager.balance > 0 ? .primary : .red)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

                // Amount Input
                VStack(alignment: .leading, spacing: 12) {
                    Text("Enter Amount")
                        .font(.headline)

                    HStack {
                        Text("$")
                            .font(.title2)
                            .fontWeight(.semibold)

                        TextField("0.00", text: $amount)
                            .font(.title2)
                            .keyboardType(.decimalPad)
                            .onChange(of: amount) { _ in
                                selectedAmount = nil
                            }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)

                    // Validation Message
                    if enteredAmount > walletManager.balance {
                        Text("Amount exceeds available balance")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                // Quick Amount Buttons
                if !quickAmounts.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Amounts")
                            .font(.headline)

                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                            ForEach(quickAmounts, id: \.self) { quickAmount in
                                Button(action: {
                                    selectedAmount = quickAmount
                                    amount = String(format: "%.0f", quickAmount)
                                }) {
                                    Text("$\(String(format: "%.0f", quickAmount))")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(selectedAmount == quickAmount ? .white : .orange)
                                        .frame(height: 44)
                                        .frame(maxWidth: .infinity)
                                        .background(selectedAmount == quickAmount ? Color.orange : Color.orange.opacity(0.1))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }

                // Max Amount Button
                if walletManager.balance > 0 {
                    Button(action: {
                        selectedAmount = walletManager.balance
                        amount = String(format: "%.2f", walletManager.balance)
                    }) {
                        Text("Cash Out All ($\(walletManager.formattedBalance))")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }
                }

                Spacer()

                // Cash Out Button
                Button(action: cashOut) {
                    Text("Cash Out $\(formattedEnteredAmount)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(isValidAmount ? Color.orange : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!isValidAmount)

                // Cancel Button
                Button("Cancel") {
                    dismiss()
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding()
            .navigationBarHidden(true)
        }
        .alert("Cash Out Successful!", isPresented: $showingSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("$\(formattedEnteredAmount) has been withdrawn from your account.")
        }
        .alert("Cash Out Failed", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }

    private var enteredAmount: Double {
        return Double(amount) ?? 0.0
    }

    private var formattedEnteredAmount: String {
        return String(format: "%.2f", enteredAmount)
    }

    private var isValidAmount: Bool {
        return enteredAmount > 0 && enteredAmount <= walletManager.balance
    }

    private func cashOut() {
        guard isValidAmount else { return }

        let success = walletManager.cashOut(amount: enteredAmount)
        if success {
            showingSuccess = true
        } else {
            errorMessage = "Unable to process cash out. Please check your balance and try again."
            showingError = true
        }
    }
}

#Preview {
    CashOutView()
        .environmentObject(WalletManager())
}