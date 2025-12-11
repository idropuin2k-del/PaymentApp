@echo off
echo 🚀 PaymentApp GitHub Setup for Windows
echo ======================================
echo.
echo This will help you set up GitHub Actions to build your iOS app automatically!
echo.
echo Prerequisites:
echo - Git installed on Windows
echo - GitHub account created
echo.
pause
echo.
echo Step 1: Initialize Git Repository
echo ---------------------------------
git init
echo ✅ Git initialized

echo.
echo Step 2: Add all files to Git
echo ----------------------------
git add .
echo ✅ Files added to Git

echo.
echo Step 3: Create initial commit
echo -----------------------------
git commit -m "Initial PaymentApp commit - Ready for iOS build"
echo ✅ Initial commit created

echo.
echo Step 4: Manual Steps (Do these next)
echo ====================================
echo.
echo 1. Go to https://github.com/new
echo 2. Repository name: PaymentApp
echo 3. Make it Public (required for free Actions)
echo 4. Click "Create repository"
echo 5. Copy the commands GitHub shows you, they'll look like:
echo.
echo    git branch -M main
echo    git remote add origin https://github.com/YOUR_USERNAME/PaymentApp.git
echo    git push -u origin main
echo.
echo 6. Run those commands in this terminal
echo 7. Go to your GitHub repository
echo 8. Click the "Actions" tab
echo 9. You should see "Build iOS App" running automatically!
echo.
echo Step 5: Download Your IPA
echo ========================
echo.
echo 1. Wait for the GitHub Action to finish (about 5-10 minutes)
echo 2. Go to the "Actions" tab in your repository
echo 3. Click on the latest successful build (green checkmark)
echo 4. Scroll down to "Artifacts"
echo 5. Download "PaymentApp-IPA"
echo 6. Extract the ZIP to get PaymentApp.ipa
echo 7. Drag the .ipa file to Sideloadly!
echo.
echo 🎉 Your iOS app will build automatically on every code change!
echo.
pause