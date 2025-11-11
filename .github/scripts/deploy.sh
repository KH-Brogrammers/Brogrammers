#!/bin/bash
# deploy.sh - Deploy application to Raspberry Pi
# ENSURES NO SOURCE CODE is stored on target machine
set -e

APP_DIR="/var/www/my-app"
echo "🚀 Starting deployment process..."

# Verify downloaded artifact contains NO source code
echo "🔍 Verifying artifact contains NO source code..."
if find "/opt/app-deployment" \( -name "*.ts" -o -name "*.tsx" -o -name "*.jsx" -o -name "src" \) 2>/dev/null | grep -q .; then
    echo "❌ Source code detected in artifact!"
    exit 1
fi

echo "✅ Artifact verification passed"

if [ ! -d "$APP_DIR" ]; then
    echo "📁 Creating application directory: $APP_DIR"
    sudo mkdir -p "$APP_DIR"
fi

echo "🧹 Cleaning previous deployment..."
sudo find "$APP_DIR" -maxdepth 1 ! -name 'node_modules' ! -path "$APP_DIR" -exec rm -rf {} + 2>/dev/null || true

echo "📦 Copying new deployment..."
sudo cp -r /opt/app-deployment/* "$APP_DIR"/

# Final security check
echo "🔍 Final security check..."
if find "$APP_DIR" \( -name "*.ts" -o -name "*.tsx" -o -name "*.jsx" -o -name "src" \) 2>/dev/null | grep -q .; then
    echo "❌ Source code detected on target!"
    exit 1
fi

sudo chown -R pi:pi "$APP_DIR"
echo "✅ Application deployed to $APP_DIR"

# Configure nginx
echo "🌐 Configuring nginx..."
if [ ! -f "/etc/nginx/sites-available/brogrammers" ]; then
    echo "📁 Setting up nginx..."
    if [ -f "./nginx/nginx.sh" ]; then
        sudo chmod +x ./nginx/nginx.sh
        ./nginx/nginx.sh
    else
        echo "⚠️ nginx script not found"
    fi
else
    echo "✅ nginx configured, reloading..."
    sudo systemctl reload nginx
fi

echo "🎉 Deployment completed!"
echo "✅ Only built artifacts on Raspberry Pi"
echo "✅ Source code remains on GitHub"