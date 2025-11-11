#!/bin/bash
# build.sh - Create deployment package with ONLY built artifacts
# ENSURES NO SOURCE CODE is included in deployment
set -e

echo "🔨 Creating deployment package..."
echo "🔍 DEBUG: Current directory: $(pwd)"
echo "🔍 DEBUG: Available files: $(ls -la)"

DEPLOY_DIR="deployment-package"

# Clean or create deployment directory
if [ -d "$DEPLOY_DIR" ]; then
    echo "📁 Directory $DEPLOY_DIR exists. Cleaning it..."
    rm -rf "$DEPLOY_DIR"/*
else
    echo "📁 Directory $DEPLOY_DIR doesn't exist. Creating it..."
    mkdir -p "$DEPLOY_DIR"
fi

echo "📦 Copying ONLY built artifacts..."
echo "🔍 DEBUG: Checking for dist directory: $(ls -la dist/ 2>/dev/null || echo 'dist not found')"

# Copy ONLY the essential built files
cp -r dist/* "$DEPLOY_DIR"/ 2>/dev/null || echo "⚠️ No dist files to copy"
cp package.json "$DEPLOY_DIR"/ 2>/dev/null || echo "⚠️ No package.json to copy"
cp package-lock.json "$DEPLOY_DIR"/ 2>/dev/null || echo "⚠️ No package-lock.json to copy"

echo "🔍 DEBUG: Files copied to $DEPLOY_DIR: $(ls -la $DEPLOY_DIR/ 2>/dev/null || echo 'empty')"

# REMOVE ANY POTENTIAL SOURCE CODE FILES
echo "🧹 STRICT CLEANING - Removing ALL source files..."
# Remove TypeScript/JSX/TSX source files
find "$DEPLOY_DIR" -name "*.ts" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "*.tsx" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "*.jsx" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "*.mjs" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "*.cjs" -delete 2>/dev/null || true

# Remove source directories
find "$DEPLOY_DIR" -name "src" -type d -exec rm -rf {} + 2>/dev/null || true
find "$DEPLOY_DIR" -name "source" -type d -exec rm -rf {} + 2>/dev/null || true
find "$DEPLOY_DIR" -name "sources" -type d -exec rm -rf {} + 2>/dev/null || true

# Remove configuration files that might contain source info
find "$DEPLOY_DIR" -name "tsconfig.json" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "jsconfig.json" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "webpack.config.js" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "vite.config.js" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "vite.config.ts" -delete 2>/dev/null || true

# Remove source maps and debug files
find "$DEPLOY_DIR" -name "*.map" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "*.d.ts" -delete 2>/dev/null || true

# Remove development configuration files
find "$DEPLOY_DIR" -name ".eslintrc*" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name ".prettierrc*" -delete 2>/dev/null || true
find "$DEPLOY_DIR" -name "babel.config.js" -delete 2>/dev/null || true

# Remove any hidden files that might contain source
find "$DEPLOY_DIR" -name ".*" -type f -delete 2>/dev/null || true

# Final verification - check for any remaining source files
echo "🔍 VERIFICATION - Checking for any remaining source files..."
REMAINING_SOURCE=$(find "$DEPLOY_DIR" \( -name "*.ts" -o -name "*.tsx" -o -name "*.jsx" -o -name "src" \) 2>/dev/null | wc -l)

if [ "$REMAINING_SOURCE" -gt 0 ]; then
    echo "❌ CRITICAL: Source files detected in deployment package!"
    find "$DEPLOY_DIR" \( -name "*.ts" -o -name "*.tsx" -o -name "*.jsx" -o -name "src" \) 2>/dev/null
    exit 1
fi

echo "📁 Deployment package contents:"
ls -la "$DEPLOY_DIR"/
echo "✅ DEPLOYMENT PACKAGE CREATED - 100% SOURCE CODE FREE - Only built artifacts!"
echo "🔍 DEBUG: This will be stored as artifact with run number and as latest version"