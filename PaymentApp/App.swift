import SwiftUI

@main
struct PaymentApp: App {
    @StateObject private var walletManager = WalletManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(walletManager)
        }
    }
}