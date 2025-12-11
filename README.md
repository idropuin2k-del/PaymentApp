# Payment App Demo

A prototype iOS payment app built with SwiftUI that demonstrates basic cash management functionality.

## Features

- **Balance Display**: View current account balance with a beautiful gradient UI
- **Add Cash**: Add money to your account with custom amounts or quick presets
- **Cash Out**: Withdraw money with balance validation and quick amount options
- **Transaction History**: View all past transactions with detailed information
- **Demo Data**: Preloaded with sample transactions for testing

## App Structure

```
PaymentApp/
├── App.swift                    # Main app entry point
├── ContentView.swift           # Main dashboard with balance and navigation
├── Info.plist                  # App configuration
├── Models/
│   ├── Transaction.swift       # Transaction data model
│   └── WalletManager.swift     # State management for balance and transactions
└── Views/
    ├── AddCashView.swift       # Add money interface
    ├── CashOutView.swift       # Withdraw money interface
    └── TransactionHistoryView.swift # Transaction list display
```

## Key Components

### WalletManager
- `@ObservableObject` that manages app state
- Handles balance calculations and transaction storage
- Provides formatted strings for display
- Includes demo data loading

### ContentView
- Main dashboard with gradient background
- Displays current balance prominently
- Navigation buttons for all major features
- Uses sheet presentation for modal views

### AddCashView & CashOutView
- Clean, form-based interfaces
- Quick amount buttons for common values
- Input validation and error handling
- Success/error alerts with feedback

### TransactionHistoryView
- Chronological list of all transactions
- Color-coded transaction types (green for cash in, orange for cash out)
- Empty state handling
- Formatted dates and amounts

## Building & Running

### Requirements
- Xcode 14.0 or later
- iOS 16.0+ deployment target
- Swift 5.7+

### Setup Instructions

1. **Create New Xcode Project**:
   ```bash
   # Open Xcode
   # File → New → Project
   # Choose iOS → App
   # Use SwiftUI interface and Swift language
   ```

2. **Add Files to Project**:
   - Copy all `.swift` files to your Xcode project
   - Ensure proper folder structure (Models/, Views/)
   - Replace default ContentView.swift with provided version

3. **Configure Project Settings**:
   - Set deployment target to iOS 16.0+
   - Update Info.plist with provided content
   - Set bundle identifier (e.g., com.yourname.paymentapp)

4. **Build & Run**:
   ```bash
   # In Xcode: Cmd+R to build and run
   # Or use command line:
   xcodebuild -scheme PaymentApp -destination 'platform=iOS Simulator,name=iPhone 14' build
   ```

## Usage

### Adding Money
1. Tap "Add Cash" on main screen
2. Enter custom amount or select quick amount
3. Tap "Add $X.XX" to confirm
4. View success confirmation

### Withdrawing Money
1. Tap "Cash Out" on main screen
2. Enter amount (cannot exceed balance)
3. Use quick amounts or "Cash Out All" option
4. Tap "Cash Out $X.XX" to confirm

### Viewing History
1. Tap "Transaction History" on main screen
2. Scroll through chronological transaction list
3. View transaction details (amount, date, description)
4. Tap "Done" to return to main screen

## Demo Data

The app includes sample transactions on first launch:
- Initial balance: $100.00
- Bank deposit: +$50.00
- Coffee purchase: -$25.00
- Paycheck: +$200.00
- Groceries: -$75.00

## Security Notes

⚠️ **This is a prototype for demonstration only**:
- No real money or financial institutions involved
- No encryption or secure storage implemented
- No user authentication or authorization
- Not suitable for production use without significant security enhancements

## Customization

### Colors & Styling
- Modify gradient colors in `ContentView.swift`
- Update action button colors in `ActionButton` struct
- Change transaction type colors in `Transaction.swift`

### Quick Amounts
- Edit `quickAmounts` arrays in Add/Cash out views
- Customize default demo data in `WalletManager.loadDemoData()`

### Features to Add
- User authentication
- Bank account linking
- Real payment processing
- Push notifications
- Biometric security
- Data persistence (Core Data/CloudKit)

## License

This is a demonstration project for educational purposes.