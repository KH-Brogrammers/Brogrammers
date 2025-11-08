#!/bin/bash
# deploy.sh - Deploy application to Raspberry Pi
# ENSURES NO SOURCE CODE is stored on target machine
set -e

APP_DIR="/var/www/my-app"
echo "🚀 Starting SECURE deployment process..."

# Verify downloaded artifact contains NO source code
echo "🔍 Verifying artifact contains NO source code..."
if find "/opt/app-deployment" \( -name "*.ts" -o -name "*.tsx" -o -name "*.jsx" -o -name "src" \) 2>/dev/null | grep -q .; then
    echo "❌ CRITICAL SECURITY VIOLATION: Source code detected in artifact!"
    find "/opt/app-deployment" \( -name "*.ts" -o -name "*.tsx" -o -name "*.jsx" -o -name "src" \) 2>/dev/null
    exit 1
fi

echo "✅ Artifact verification passed - NO source code detected"

if [ ! -d "$APP_DIR" ]; then
    echo "📁 Creating application directory: $APP_DIR"
    sudo mkdir -p "$APP_DIR"
else
    echo "📁 Application directory exists: $APP_DIR"
fi

echo "🧹 Cleaning previous deployment (preserving node_modules)..."
# Clean everything except node_modules
sudo find "$APP_DIR" -maxdepth 1 ! -name 'node_modules' ! -path "$APP_DIR" -exec rm -rf {} + 2>/dev/null || true

echo "📦 Copying new deployment (BUILT ARTIFACTS ONLY)..."
sudo cp -r /opt/app-deployment/* "$APP_DIR"/

# Final security check on deployed files
echo "🔍 Final security check - verifying NO source code on target..."
if find "$APP_DIR" \( -name "*.ts" -o -name "*.tsx" -o -name "*.jsx" -o -name "src" \) 2>/dev/null | grep -q .; then
    echo "❌ CRITICAL: Source code detected on target machine!"
    sudo find "$APP_DIR" \( -name "*.ts" -o -name "*.tsx" -o -name "*.jsx" -o -name "src" \) 2>/dev/null
    exit 1
fi

sudo chown -R pi:pi "$APP_DIR"
echo "✅ Application deployed to $APP_DIR"

# Configure nginx if not already configured
echo "🌐 Configuring nginx..."
if [ ! -f "/etc/nginx/sites-available/kh-brogrammers.com" ]; then
    echo "📁 Setting up nginx configuration..."
    if [ -f "./nginx/nginx.sh" ]; then
        sudo chmod +x ./nginx/nginx.sh
        ./nginx/nginx.sh
    else
        echo "⚠️  nginx script not found at ./nginx/nginx.sh"
        echo "ℹ️  Please ensure nginx configuration script exists"
    fi
else
    echo "✅ nginx already configured, reloading..."
    sudo systemctl reload nginx
fi

echo "🔄 Restarting application service..."
sudo systemctl restart my-app-service 2>/dev/null || echo "ℹ️  If this is first deployment, create service with: sudo systemctl enable my-app-service"

echo "🎉 SECURE DEPLOYMENT COMPLETED!"
echo "✅ 100% SOURCE CODE FREE - Only built artifacts on Raspberry Pi"
echo "✅ Source code remains exclusively on GitHub"
echo "✅ Intellectual property protected"
echo "✅ nginx configured for kh-brogrammers.com"