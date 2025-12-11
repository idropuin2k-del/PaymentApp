#!/bin/bash

# PaymentApp IPA Builder Script
# This script builds and exports the PaymentApp as an .ipa file for sideloading

set -e

PROJECT_NAME="PaymentApp"
SCHEME_NAME="PaymentApp"
CONFIGURATION="Release"
ARCHIVE_PATH="./build/${PROJECT_NAME}.xcarchive"
EXPORT_PATH="./build/ipa"
IPA_NAME="${PROJECT_NAME}.ipa"

echo "🚀 Building ${PROJECT_NAME} for sideloading..."

# Create build directory
mkdir -p build

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf build/*

# Archive the project
echo "📦 Archiving project..."
xcodebuild archive \
    -project "${PROJECT_NAME}.xcodeproj" \
    -scheme "${SCHEME_NAME}" \
    -configuration "${CONFIGURATION}" \
    -archivePath "${ARCHIVE_PATH}" \
    -destination "generic/platform=iOS" \
    CODE_SIGN_IDENTITY="" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO

# Create export options plist
echo "⚙️ Creating export options..."
cat > ./build/ExportOptions.plist << EOF
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
EOF

# Export the archive to IPA
echo "📱 Exporting IPA..."
xcodebuild -exportArchive \
    -archivePath "${ARCHIVE_PATH}" \
    -exportPath "${EXPORT_PATH}" \
    -exportOptionsPlist "./build/ExportOptions.plist"

# Find and rename the IPA file
if [ -f "${EXPORT_PATH}/${PROJECT_NAME}.ipa" ]; then
    cp "${EXPORT_PATH}/${PROJECT_NAME}.ipa" "./build/${IPA_NAME}"
    echo "✅ IPA file created successfully: ./build/${IPA_NAME}"
    echo "📱 You can now sideload this file using:"
    echo "   - AltStore"
    echo "   - Sideloadly"
    echo "   - iOS App Installer"
    echo "   - Xcode (for development devices)"
else
    echo "❌ Error: IPA file not found after export"
    exit 1
fi

echo "🎉 Build completed successfully!"