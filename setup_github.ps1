# PaymentApp GitHub Setup for Windows PowerShell

Write-Host "🚀 PaymentApp GitHub Setup for Windows" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green
Write-Host ""
Write-Host "This will help you set up GitHub Actions to build your iOS app automatically!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Prerequisites:" -ForegroundColor Cyan
Write-Host "- Git installed on Windows" -ForegroundColor White
Write-Host "- GitHub account created" -ForegroundColor White
Write-Host ""

# Check if git is installed
if (!(Get-Command "git" -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git not found! Please install Git first:" -ForegroundColor Red
    Write-Host "https://git-scm.com/download/win" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Read-Host "Press Enter to continue"

try {
    Write-Host ""
    Write-Host "Step 1: Initialize Git Repository" -ForegroundColor Blue
    Write-Host "---------------------------------" -ForegroundColor Blue
    git init
    Write-Host "✅ Git initialized" -ForegroundColor Green

    Write-Host ""
    Write-Host "Step 2: Add all files to Git" -ForegroundColor Blue
    Write-Host "----------------------------" -ForegroundColor Blue
    git add .
    Write-Host "✅ Files added to Git" -ForegroundColor Green

    Write-Host ""
    Write-Host "Step 3: Create initial commit" -ForegroundColor Blue
    Write-Host "-----------------------------" -ForegroundColor Blue
    git commit -m "Initial PaymentApp commit - Ready for iOS build"
    Write-Host "✅ Initial commit created" -ForegroundColor Green

    Write-Host ""
    Write-Host "Step 4: Manual Steps (Do these next)" -ForegroundColor Blue
    Write-Host "====================================" -ForegroundColor Blue
    Write-Host ""
    Write-Host "1. Go to " -ForegroundColor White -NoNewline
    Write-Host "https://github.com/new" -ForegroundColor Cyan
    Write-Host "2. Repository name: " -ForegroundColor White -NoNewline
    Write-Host "PaymentApp" -ForegroundColor Yellow
    Write-Host "3. Make it " -ForegroundColor White -NoNewline
    Write-Host "Public " -ForegroundColor Yellow -NoNewline
    Write-Host "(required for free Actions)" -ForegroundColor Gray
    Write-Host "4. Click " -ForegroundColor White -NoNewline
    Write-Host "Create repository" -ForegroundColor Yellow
    Write-Host "5. Copy the commands GitHub shows you, they'll look like:" -ForegroundColor White
    Write-Host ""
    Write-Host "   git branch -M main" -ForegroundColor Gray
    Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/PaymentApp.git" -ForegroundColor Gray
    Write-Host "   git push -u origin main" -ForegroundColor Gray
    Write-Host ""
    Write-Host "6. Run those commands in this terminal" -ForegroundColor White
    Write-Host "7. Go to your GitHub repository" -ForegroundColor White
    Write-Host "8. Click the " -ForegroundColor White -NoNewline
    Write-Host "Actions " -ForegroundColor Yellow -NoNewline
    Write-Host "tab" -ForegroundColor White
    Write-Host "9. You should see " -ForegroundColor White -NoNewline
    Write-Host "Build iOS App " -ForegroundColor Yellow -NoNewline
    Write-Host "running automatically!" -ForegroundColor White

    Write-Host ""
    Write-Host "Step 5: Download Your IPA" -ForegroundColor Blue
    Write-Host "========================" -ForegroundColor Blue
    Write-Host ""
    Write-Host "1. Wait for the GitHub Action to finish (about 5-10 minutes)" -ForegroundColor White
    Write-Host "2. Go to the " -ForegroundColor White -NoNewline
    Write-Host "Actions " -ForegroundColor Yellow -NoNewline
    Write-Host "tab in your repository" -ForegroundColor White
    Write-Host "3. Click on the latest successful build (green checkmark)" -ForegroundColor White
    Write-Host "4. Scroll down to " -ForegroundColor White -NoNewline
    Write-Host "Artifacts" -ForegroundColor Yellow
    Write-Host "5. Download " -ForegroundColor White -NoNewline
    Write-Host "PaymentApp-IPA" -ForegroundColor Yellow
    Write-Host "6. Extract the ZIP to get PaymentApp.ipa" -ForegroundColor White
    Write-Host "7. Drag the .ipa file to Sideloadly!" -ForegroundColor White
    Write-Host ""
    Write-Host "🎉 Your iOS app will build automatically on every code change!" -ForegroundColor Green

} catch {
    Write-Host "❌ Error: $_" -ForegroundColor Red
    Write-Host "Make sure you're in the PaymentApp directory" -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Press Enter to finish"