# PaymentApp Makefile for building IPA

PROJECT_NAME = PaymentApp
SCHEME_NAME = PaymentApp
CONFIGURATION = Release
BUILD_DIR = build
ARCHIVE_PATH = $(BUILD_DIR)/$(PROJECT_NAME).xcarchive
EXPORT_PATH = $(BUILD_DIR)/ipa
IPA_PATH = $(BUILD_DIR)/$(PROJECT_NAME).ipa

.PHONY: clean archive export ipa install help

help: ## Show this help message
	@echo "PaymentApp Build Commands:"
	@echo "========================="
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

clean: ## Clean build directory
	@echo "🧹 Cleaning build directory..."
	@rm -rf $(BUILD_DIR)
	@mkdir -p $(BUILD_DIR)

archive: clean ## Archive the project
	@echo "📦 Archiving $(PROJECT_NAME)..."
	@xcodebuild archive \
		-project $(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME_NAME) \
		-configuration $(CONFIGURATION) \
		-archivePath $(ARCHIVE_PATH) \
		-destination "generic/platform=iOS"

export: archive ## Export archive to IPA
	@echo "📱 Exporting to IPA..."
	@xcodebuild -exportArchive \
		-archivePath $(ARCHIVE_PATH) \
		-exportPath $(EXPORT_PATH) \
		-exportOptionsPlist ExportOptions.plist
	@cp $(EXPORT_PATH)/$(PROJECT_NAME).ipa $(IPA_PATH)
	@echo "✅ IPA created: $(IPA_PATH)"

ipa: export ## Build complete IPA (same as export)

install: ipa ## Build IPA and open Sideloadly instructions
	@echo "🎉 IPA ready for sideloading!"
	@echo "📱 Next steps:"
	@echo "  1. Open Sideloadly"
	@echo "  2. Connect your iOS device"
	@echo "  3. Drag $(IPA_PATH) to Sideloadly"
	@echo "  4. Enter your Apple ID"
	@echo "  5. Click Start"
	@ls -la $(IPA_PATH)

# Quick commands
build: ipa ## Alias for 'ipa'

.DEFAULT_GOAL := help