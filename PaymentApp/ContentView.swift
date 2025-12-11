import SwiftUI

struct ContentView: View {
    @EnvironmentObject var walletManager: WalletManager
    @State private var showingAddCash = false
    @State private var showingCashOut = false
    @State private var showingHistory = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // Balance Display
                    VStack(spacing: 10) {
                        Text("Current Balance")
                            .font(.headline)
                            .foregroundColor(.white.opacity(0.9))

                        Text(walletManager.formattedBalance)
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .padding()

                    Spacer()

                    // Action Buttons
                    VStack(spacing: 20) {
                        HStack(spacing: 20) {
                            ActionButton(
                                title: "Add Cash",
                                icon: "plus.circle.fill",
                                color: .green
                            ) {
                                showingAddCash = true
                            }

                            ActionButton(
                                title: "Cash Out",
                                icon: "minus.circle.fill",
                                color: .orange
                            ) {
                                showingCashOut = true
                            }
                        }

                        ActionButton(
                            title: "Transaction History",
                            icon: "clock.fill",
                            color: .white,
                            textColor: .blue
                        ) {
                            showingHistory = true
                        }
                        .frame(width: 200)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationTitle("Payment App")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                // Load demo data on first launch
                if walletManager.transactions.isEmpty {
                    walletManager.loadDemoData()
                }
            }
        }
        .sheet(isPresented: $showingAddCash) {
            AddCashView()
                .environmentObject(walletManager)
        }
        .sheet(isPresented: $showingCashOut) {
            CashOutView()
                .environmentObject(walletManager)
        }
        .sheet(isPresented: $showingHistory) {
            TransactionHistoryView()
                .environmentObject(walletManager)
        }
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    var textColor: Color = .white
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))

                Text(title)
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundColor(textColor)
            .frame(width: 120, height: 80)
            .background(color)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WalletManager())
}