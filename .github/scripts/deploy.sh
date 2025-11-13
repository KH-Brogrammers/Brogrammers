#!/bin/bash
# deploy.sh - Simple deployment script with SSH authentication
set -e

echo "🚀 Starting server deployment process..."

# Verify required environment variables
if [ -z "$PUBLIC_IP" ] || [ -z "$USERNAME" ]; then
    echo "❌ Error: Required environment variables not set!"
    echo "Required: PUBLIC_IP, USERNAME"
    exit 1
fi

echo "🔍 DEBUG: Target server: $PUBLIC_IP"
echo "🔍 DEBUG: Username: $USERNAME"

# Install sshpass if needed
if [ -n "$SSH_LOGIN_PASSWORD" ] && ! command -v sshpass &> /dev/null; then
    echo "📦 Installing sshpass..."
    sudo apt-get update -qq
    sudo apt-get install -y sshpass
fi

# Function to copy files with SSH key
copy_with_key() {
    scp -i ~/.ssh/id_ed25519 -o StrictHostKeyChecking=no -o ConnectTimeout=10 deployment.tar.gz $USERNAME@$PUBLIC_IP:/tmp/ &&
    scp -i ~/.ssh/id_ed25519 -o StrictHostKeyChecking=no $0 $USERNAME@$PUBLIC_IP:/tmp/deploy.sh
}

# Function to copy files with password
copy_with_password() {
    sshpass -p "$SSH_LOGIN_PASSWORD" scp -o StrictHostKeyChecking=no deployment.tar.gz $USERNAME@$PUBLIC_IP:/tmp/ &&
    sshpass -p "$SSH_LOGIN_PASSWORD" scp -o StrictHostKeyChecking=no $0 $USERNAME@$PUBLIC_IP:/tmp/deploy.sh
}

# Function to execute remote deployment with SSH key
execute_with_key() {
    ssh -i ~/.ssh/id_ed25519 -o StrictHostKeyChecking=no $USERNAME@$PUBLIC_IP "PUBLIC_IP='$PUBLIC_IP' USERNAME='$USERNAME' /tmp/deploy.sh remote"
}

# Function to execute remote deployment with password
execute_with_password() {
    sshpass -p "$SSH_LOGIN_PASSWORD" ssh -o StrictHostKeyChecking=no $USERNAME@$PUBLIC_IP "PUBLIC_IP='$PUBLIC_IP' USERNAME='$USERNAME' /tmp/deploy.sh remote"
}

# Check if this is remote execution
if [ "$1" = "remote" ]; then
    echo "🔍 DEBUG: Executing on remote server..."
    
    # Use home/brogrammers directory for deployment
    DEPLOY_DIR="$HOME/brogrammers"
    
    # Clean up old deployment files first
    echo "🧹 Cleaning up old deployment files..."
    rm -f /tmp/deployment.tar.gz 2>/dev/null || true
    
    # Create backup of current deployment
    echo "🔍 DEBUG: Creating backup of current deployment..."
    if [ -d "$DEPLOY_DIR" ]; then
        BACKUP_DIR="${DEPLOY_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
        cp -r "$DEPLOY_DIR" "$BACKUP_DIR"
        echo "🔍 DEBUG: Backup created at $BACKUP_DIR"
        
        # Remove old deployment directory for fresh start
        echo "🧹 Removing old deployment directory for fresh deployment..."
        rm -rf "$DEPLOY_DIR"
    fi

    # Create fresh deployment directory
    mkdir -p "$DEPLOY_DIR"
    cd "$DEPLOY_DIR"

    # Extract new deployment
    echo "🔍 DEBUG: Extracting new deployment..."
    tar -xzf /tmp/deployment.tar.gz
    
    echo "🔍 DEBUG: Deployment files extracted to $DEPLOY_DIR"
    echo "🔍 DEBUG: Deployment contents:"
    ls -la .

    # Cleanup unnecessary files
    echo "🧹 Cleaning up unnecessary files..."
    find . -name "*.map" -delete 2>/dev/null || true
    find . -name "*.d.ts" -delete 2>/dev/null || true
    find . -name ".DS_Store" -delete 2>/dev/null || true
    find . -name "Thumbs.db" -delete 2>/dev/null || true

    # Remove temporary files and credentials
    echo "🧹 Cleaning up temporary files and credentials..."
    rm -f /tmp/deployment.tar.gz
    rm -f /tmp/deploy.sh
    
    # Clean old backups (keep only last 1)
    echo "🧹 Cleaning old backups..."
    ls -dt ${DEPLOY_DIR}.backup.* 2>/dev/null | tail -n +2 | xargs rm -rf 2>/dev/null || true

    echo "🔍 DEBUG: Final deployment contents:"
    ls -la .
    echo "🔍 DEBUG: Directory size: $(du -sh . 2>/dev/null || echo 'Unknown')"

    echo "✅ Server deployment completed successfully!"
    
else
    # Local execution - copy files and execute remotely
    echo "🚀 Starting deployment to server..."
    
    # Clean up any old local deployment files
    echo "🧹 Cleaning up old local deployment files..."
    rm -f deployment.tar.gz 2>/dev/null || true
    
    # Copy important credentials for deployment
    echo "🔑 Using existing SSH keys for deployment..."
    
    # Create deployment package
    echo "📦 Creating deployment package..."
    tar -czf deployment.tar.gz -C ./deployment-package .
    
    # Try SSH key first, fallback to password
    if [ -f ~/.ssh/id_ed25519 ] && copy_with_key 2>/dev/null; then
        echo "✅ SSH key authentication successful"
        execute_with_key
    elif [ -n "$SSH_LOGIN_PASSWORD" ]; then
        echo "🔑 Using password authentication..."
        copy_with_password
        execute_with_password
    else
        echo "❌ No valid authentication method available!"
        exit 1
    fi
    
    # Cleanup local files and credentials properly
    echo "🧹 Cleaning up local files..."
    rm -f deployment.tar.gz
    
    # Clear any temporary credential variables
    unset SSH_PRIVATE_KEY SSH_PUBLIC_KEY SSH_LOGIN_PASSWORD
    
    echo "✅ Deployment completed successfully!"
    echo "🧹 All temporary files cleaned up!"
fi
