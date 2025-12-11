import SwiftUI

struct AddCashView: View {
    @EnvironmentObject var walletManager: WalletManager
    @Environment(\.dismiss) private var dismiss
    @State private var amount: String = ""
    @State private var selectedAmount: Double? = nil
    @State private var showingSuccess = false

    let quickAmounts: [Double] = [10, 20, 50, 100, 200, 500]

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Add Cash")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Add money to your account")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top)

                // Current Balance
                VStack(spacing: 4) {
                    Text("Current Balance")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text(walletManager.formattedBalance)
                        .font(.title2)
                        .fontWeight(.semibold)
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
                }

                // Quick Amount Buttons
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
                                    .foregroundColor(selectedAmount == quickAmount ? .white : .blue)
                                    .frame(height: 44)
                                    .frame(maxWidth: .infinity)
                                    .background(selectedAmount == quickAmount ? Color.blue : Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }

                Spacer()

                // Add Cash Button
                Button(action: addCash) {
                    Text("Add $\(formattedEnteredAmount)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(isValidAmount ? Color.green : Color.gray)
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
        .alert("Cash Added Successfully!", isPresented: $showingSuccess) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("$\(formattedEnteredAmount) has been added to your account.")
        }
    }

    private var enteredAmount: Double {
        return Double(amount) ?? 0.0
    }

    private var formattedEnteredAmount: String {
        return String(format: "%.2f", enteredAmount)
    }

    private var isValidAmount: Bool {
        return enteredAmount > 0
    }

    private func addCash() {
        guard isValidAmount else { return }

        walletManager.addCash(amount: enteredAmount)
        showingSuccess = true
    }
}

#Preview {
    AddCashView()
        .environmentObject(WalletManager())
}