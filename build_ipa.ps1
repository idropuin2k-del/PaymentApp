# PaymentApp IPA Builder PowerShell Script
# This script builds and exports the PaymentApp as an .ipa file for sideloading

param(
    [string]$Configuration = "Release"
)

$ProjectName = "PaymentApp"
$SchemeName = "PaymentApp"
$ArchivePath = "./build/$ProjectName.xcarchive"
$ExportPath = "./build/ipa"
$IpaName = "$ProjectName.ipa"

Write-Host "🚀 Building $ProjectName for sideloading..." -ForegroundColor Green

# Create build directory
New-Item -ItemType Directory -Force -Path "build" | Out-Null

# Clean previous builds
Write-Host "🧹 Cleaning previous builds..." -ForegroundColor Yellow
Remove-Item -Path "build/*" -Force -Recurse -ErrorAction SilentlyContinue

# Check if xcodebuild is available
if (!(Get-Command "xcodebuild" -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Error: xcodebuild not found. Make sure Xcode Command Line Tools are installed." -ForegroundColor Red
    Write-Host "Run: xcode-select --install" -ForegroundColor Yellow
    exit 1
}

try {
    # Archive the project
    Write-Host "📦 Archiving project..." -ForegroundColor Blue
    & xcodebuild archive `
        -project "$ProjectName.xcodeproj" `
        -scheme $SchemeName `
        -configuration $Configuration `
        -archivePath $ArchivePath `
        -destination "generic/platform=iOS" `
        CODE_SIGN_IDENTITY='""' `
        CODE_SIGNING_REQUIRED=NO `
        CODE_SIGNING_ALLOWED=NO

    if ($LASTEXITCODE -ne 0) {
        throw "Archive failed with exit code $LASTEXITCODE"
    }

    # Create export options plist
    Write-Host "⚙️ Creating export options..." -ForegroundColor Blue
    $ExportOptionsContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>compileBitcode</key>
    <false/>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>stripSwiftSymbols</key>
    <true/>
</dict>
</plist>
"@
    $ExportOptionsContent | Out-File -FilePath "./build/ExportOptions.plist" -Encoding UTF8

    # Export the archive to IPA
    Write-Host "📱 Exporting IPA..." -ForegroundColor Blue
    & xcodebuild -exportArchive `
        -archivePath $ArchivePath `
        -exportPath $ExportPath `
        -exportOptionsPlist "./build/ExportOptions.plist"

    if ($LASTEXITCODE -ne 0) {
        throw "Export failed with exit code $LASTEXITCODE"
    }

    # Find and copy the IPA file
    $IpaFile = Get-ChildItem -Path $ExportPath -Name "*.ipa" -File | Select-Object -First 1
    if ($IpaFile) {
        Copy-Item -Path "$ExportPath/$IpaFile" -Destination "./build/$IpaName"
        Write-Host "✅ IPA file created successfully: ./build/$IpaName" -ForegroundColor Green
        Write-Host "📱 You can now sideload this file using:" -ForegroundColor Cyan
        Write-Host "   - AltStore" -ForegroundColor White
        Write-Host "   - Sideloadly" -ForegroundColor White
        Write-Host "   - 3uTools" -ForegroundColor White
        Write-Host "   - iOS App Installer" -ForegroundColor White
    } else {
        throw "IPA file not found after export"
    }

    Write-Host "🎉 Build completed successfully!" -ForegroundColor Green

} catch {
    Write-Host "❌ Error: $_" -ForegroundColor Red
    Write-Host "💡 Try the manual Xcode method instead." -ForegroundColor Yellow
    exit 1
}