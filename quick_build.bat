@echo off
echo 📱 PaymentApp Quick Build for Sideloadly
echo ==========================================
echo.
echo This script will help you build the PaymentApp for sideloading.
echo.
echo Prerequisites:
echo - macOS with Xcode installed
echo - iOS device connected via USB
echo - Sideloadly installed
echo.
echo Step 1: Build the IPA
echo ---------------------
echo Run ONE of these commands on macOS:
echo.
echo Option A - PowerShell (if available):
echo    powershell -ExecutionPolicy Bypass -File build_ipa.ps1
echo.
echo Option B - Bash:
echo    chmod +x build_ipa.sh
echo    ./build_ipa.sh
echo.
echo Option C - Manual Xcode:
echo    1. Open PaymentApp.xcodeproj in Xcode
echo    2. Select 'Any iOS Device (arm64)' as destination
echo    3. Product → Archive
echo    4. Distribute App → Custom → Development
echo    5. Export the .ipa file
echo.
echo Step 2: Sideload with Sideloadly
echo --------------------------------
echo 1. Open Sideloadly
echo 2. Connect your iOS device via USB
echo 3. Drag the PaymentApp.ipa file to Sideloadly
echo 4. Enter your Apple ID
echo 5. Click Start and wait for installation
echo.
echo The IPA file will be created at: build\PaymentApp.ipa
echo.
echo For detailed instructions, see: SIDELOAD_GUIDE.md
echo.
pause