# 📱 Sideloading PaymentApp with Sideloadly

This guide will help you build the PaymentApp as an .ipa file and sideload it using Sideloadly.

## Prerequisites

- **macOS with Xcode** (for building the .ipa)
- **Sideloadly** installed on your computer
- **Apple ID** (free account works fine)
- **iOS device** with USB cable

## Method 1: Quick Build (Recommended for Sideloadly)

### Step 1: Build in Xcode

1. **Open the project**:
   ```bash
   # Navigate to the project directory
   cd PaymentApp
   # Open in Xcode
   open PaymentApp.xcodeproj
   ```

2. **Configure for device**:
   - In Xcode, select your project in the navigator
   - Go to "Signing & Capabilities" tab
   - Change "Bundle Identifier" to something unique like: `com.yourname.paymentapp`
   - Set "Team" to your Apple ID (or leave as "None" for Sideloadly to handle)

3. **Build for device**:
   - Select "Any iOS Device (arm64)" as the destination (NOT simulator)
   - Go to Product → Archive
   - Wait for the archive to complete

4. **Export the .ipa**:
   - In the Organizer window that opens:
   - Click "Distribute App"
   - Select "Custom" → "Next"
   - Select "Development" → "Next"
   - Keep default settings → "Next"
   - Choose export location → "Export"

### Step 2: Use Sideloadly

1. **Open Sideloadly**
2. **Connect your iOS device** via USB
3. **Drag the .ipa file** into Sideloadly
4. **Enter your Apple ID** credentials
5. **Click "Start"** and wait for installation

## Method 2: Command Line Build (Advanced)

### PowerShell Script (Windows)

```powershell
# Run this in PowerShell from the PaymentApp directory
./build_ipa.ps1
```

### Bash Script (macOS/Linux)

```bash
# Run this in Terminal from the PaymentApp directory
chmod +x build_ipa.sh
./build_ipa.sh
```

Both scripts will create `./build/PaymentApp.ipa` ready for Sideloadly.

## Method 3: Manual Command Line

```bash
# Navigate to project directory
cd PaymentApp

# Create build directory
mkdir -p build

# Archive the project
xcodebuild archive \
    -project PaymentApp.xcodeproj \
    -scheme PaymentApp \
    -archivePath ./build/PaymentApp.xcarchive \
    -destination "generic/platform=iOS"

# Export to IPA
xcodebuild -exportArchive \
    -archivePath ./build/PaymentApp.xcarchive \
    -exportPath ./build/ipa \
    -exportOptionsPlist ExportOptions.plist

# The IPA will be in ./build/ipa/PaymentApp.ipa
```

## Troubleshooting

### Common Issues

**"Failed to create provisioning profile"**:
- Let Sideloadly handle signing (don't pre-sign in Xcode)
- Make sure Bundle ID is unique

**"App installation failed"**:
- Check iOS device is in Developer Mode (Settings → Privacy & Security → Developer Mode)
- Trust the developer certificate (Settings → General → VPN & Device Management)

**"Archive failed"**:
- Make sure you selected "Any iOS Device" not simulator
- Check that all Swift files compile without errors

### Sideloadly-Specific Tips

- **Bundle ID**: Use a unique identifier like `com.yourname.paymentapp`
- **App Name**: Will show as "Payment App Demo" on your device
- **Signing**: Let Sideloadly handle all code signing
- **Certificates**: Sideloadly automatically manages development certificates

## App Features Reminder

Once installed, your Payment App will have:

- ✅ **Balance Display**: Shows current balance with gradient UI
- ✅ **Add Cash**: Add money with custom amounts or quick buttons
- ✅ **Cash Out**: Withdraw money with balance validation
- ✅ **Transaction History**: View all past transactions
- ✅ **Demo Data**: Starts with $250 balance and sample transactions

## File Locations

After building, you'll find:
- **IPA file**: `./build/PaymentApp.ipa` (drag this to Sideloadly)
- **Archive**: `./build/PaymentApp.xcarchive` (for future exports)
- **Build logs**: Check Console app if builds fail

## Security Note

This is a **demo app** with no real financial functionality:
- No real money is handled
- No network connections are made
- All data is stored locally on your device
- Safe to install and test

---

**Ready to sideload?** Build the .ipa using any method above, then drag it into Sideloadly! 🎉