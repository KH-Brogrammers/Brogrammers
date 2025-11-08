#!/bin/bash

# nginx.sh - Configure nginx for kh-brogrammers.com (HTTP only)
set -e

echo "🔧 Configuring nginx for kh-brogrammers.com (HTTP only)..."

# Define variables
DOMAIN="kh-brogrammers.com"
APP_DIR="/var/www/html/brogrammers-app"
NGINX_AVAILABLE="/etc/nginx/sites-available"
NGINX_ENABLED="/etc/nginx/sites-enabled"
CONFIG_NAME="brogrammers"

# Check if nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "📦 Installing nginx..."
    sudo apt update
    sudo apt install -y nginx
fi

# Create nginx configuration directory if it doesn't exist
sudo mkdir -p "$NGINX_AVAILABLE"
sudo mkdir -p "$NGINX_ENABLED"

# Create nginx configuration
echo "📁 Creating nginx configuration for $DOMAIN..."

sudo tee "$NGINX_AVAILABLE/$CONFIG_NAME" > /dev/null <<EOF
server {
    listen 80;
    listen [::]:80;
    
    server_name $DOMAIN www.$DOMAIN;
    
    # Root directory
    root $APP_DIR;
    index index.html index.htm;
    
    # Handle React Router or SPA (if applicable)
    location / {
        try_files \$uri \$uri/ /index.html;
    }
    
    # API proxy (if you have a backend API)
    # location /api/ {
    #     proxy_pass http://localhost:3001;
    #     proxy_http_version 1.1;
    #     proxy_set_header Upgrade \$http_upgrade;
    #     proxy_set_header Connection 'upgrade';
    #     proxy_set_header Host \$host;
    #     proxy_set_header X-Real-IP \$remote_addr;
    #     proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    #     proxy_set_header X-Forwarded-Proto \$scheme;
    #     proxy_cache_bypass \$http_upgrade;
    # }
    
    # Static assets caching
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
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

echo "✅ nginx configuration created at $NGINX_AVAILABLE/$CONFIG_NAME"

# Enable the site
echo "🔗 Enabling nginx site..."
if [ -f "$NGINX_ENABLED/$CONFIG_NAME" ]; then
    echo "⚠️  Site already enabled in $NGINX_ENABLED/$CONFIG_NAME, reloading configuration..."
    sudo rm -f "$NGINX_ENABLED/default" 2>/dev/null || true
else
    echo "🔗 Creating symlink from $NGINX_AVAILABLE/$CONFIG_NAME to $NGINX_ENABLED/$CONFIG_NAME"
    sudo ln -sf "$NGINX_AVAILABLE/$CONFIG_NAME" "$NGINX_ENABLED/$CONFIG_NAME"
    sudo rm -f "$NGINX_ENABLED/default" 2>/dev/null || true
fi

# Test nginx configuration
echo "🧪 Testing nginx configuration..."
sudo nginx -t

# Restart nginx
echo "🔄 Restarting nginx..."
sudo systemctl restart nginx
sudo systemctl enable nginx

# Check nginx status
echo "📊 nginx status:"
sudo systemctl status nginx --no-pager

echo "🎉 nginx configuration completed!"
echo ""
echo "📁 Configuration Files:"
echo "   Available: $NGINX_AVAILABLE/$CONFIG_NAME"
echo "   Enabled:   $NGINX_ENABLED/$CONFIG_NAME"
echo ""
echo "🌐 Your app will be available at: http://$DOMAIN"
echo ""
echo "✅ nginx is now configured for $DOMAIN with config name: $CONFIG_NAME (HTTP only)"