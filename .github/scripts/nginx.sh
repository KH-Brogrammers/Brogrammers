#!/bin/bash

# nginx.sh - Configure nginx for brogrammers deployment
set -e

echo "🔧 Configuring nginx for brogrammers deployment..."

# Define variables
DOMAIN="www.brogrammers.local.com"  # Change this to your domain
APP_DIR="/home/$(whoami)/brogrammers"
NGINX_AVAILABLE="/etc/nginx/sites-available"
NGINX_ENABLED="/etc/nginx/sites-enabled"
CONFIG_NAME="brogrammers"

# Check if nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "📦 Installing nginx..."
    sudo apt update
    sudo apt install -y nginx
    echo "✅ Nginx installed successfully"
else
    echo "✅ Nginx already installed"
fi

# Create nginx configuration directory if it doesn't exist
sudo mkdir -p "$NGINX_AVAILABLE"
sudo mkdir -p "$NGINX_ENABLED"

# Check if configuration already exists
if [ -f "$NGINX_AVAILABLE/$CONFIG_NAME" ]; then
    echo "⚠️ Nginx configuration already exists, updating..."
else
    echo "📁 Creating new nginx configuration..."
fi

# Create nginx configuration
echo "📝 Writing nginx configuration for $DOMAIN..."

sudo tee "$NGINX_AVAILABLE/$CONFIG_NAME" > /dev/null <<EOF
server {
    listen 80;
    listen [::]:80;
    
    server_name $DOMAIN localhost;
    
    # Root directory
    root $APP_DIR;
    index index.html index.htm;
    
    # Handle React Router or SPA
    location / {
        try_files \$uri \$uri/ /index.html;
    }
    

    
    # Security - deny access to sensitive files
    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }
    
    location ~ /\.ht {
        deny all;
    }
    
    # Security headers
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    
    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types
        application/atom+xml
        application/geo+json
        application/javascript
        application/x-javascript
        application/json
        application/ld+json
        application/manifest+json
        application/rdf+xml
        application/rss+xml
        application/xhtml+xml
        application/xml
        font/eot
        font/otf
        font/ttf
        image/svg+xml
        text/css
        text/javascript
        text/plain
        text/xml;
}
EOF

echo "✅ Nginx configuration created at $NGINX_AVAILABLE/$CONFIG_NAME"

# Enable the site
echo "🔗 Enabling nginx site..."
if [ -f "$NGINX_ENABLED/$CONFIG_NAME" ]; then
    echo "⚠️ Site already enabled, reloading configuration..."
else
    echo "🔗 Creating symlink from $NGINX_AVAILABLE/$CONFIG_NAME to $NGINX_ENABLED/$CONFIG_NAME"
    sudo ln -sf "$NGINX_AVAILABLE/$CONFIG_NAME" "$NGINX_ENABLED/$CONFIG_NAME"
fi

# Remove default site if it exists
sudo rm -f "$NGINX_ENABLED/default" 2>/dev/null || true

# Test nginx configuration
echo "🧪 Testing nginx configuration..."
if sudo nginx -t; then
    echo "✅ Nginx configuration test passed"
else
    echo "❌ Nginx configuration test failed"
    exit 1
fi

# Restart nginx
echo "🔄 Restarting nginx..."
sudo systemctl restart nginx
sudo systemctl enable nginx

# Check nginx status
echo "📊 Nginx status:"
sudo systemctl status nginx --no-pager --lines=5

echo "🎉 Nginx configuration completed!"
echo ""
echo "📁 Configuration Files:"
echo "   Available: $NGINX_AVAILABLE/$CONFIG_NAME"
echo "   Enabled:   $NGINX_ENABLED/$CONFIG_NAME"
echo ""
echo "🌐 Your app is available at:"
echo "   http://$DOMAIN"
echo "   http://localhost"
echo ""
echo "✅ Nginx is now configured for brogrammers deployment"

# Cleanup
rm -f /tmp/nginx.sh