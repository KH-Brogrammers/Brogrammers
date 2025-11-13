#!/bin/bash
# deploy.sh - Complete deployment script with SSH authentication fallback
set -e

echo "🚀 Starting server deployment process..."

# Verify required environment variables
if [ -z "$WORK_FOLDER" ] || [ -z "$BROGRAMMERS_VPN" ] || [ -z "$USERNAME" ]; then
    echo "❌ Error: Required environment variables not set!"
    echo "Required: WORK_FOLDER, BROGRAMMERS_VPN, USERNAME"
    exit 1
fi

echo "🔍 DEBUG: Work folder: $WORK_FOLDER"
echo "🔍 DEBUG: Target server: $BROGRAMMERS_VPN"
echo "🔍 DEBUG: Username: $USERNAME"

# Setup SSH keys if provided
if [ -n "$SSH_PRIVATE_KEY" ] && [ -n "$SSH_KEY" ]; then
    echo "🔑 Setting up SSH keys..."
    mkdir -p ~/.ssh
    echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
    echo "$SSH_KEY" > ~/.ssh/id_rsa.pub
    chmod 600 ~/.ssh/id_rsa
    chmod 644 ~/.ssh/id_rsa.pub
fi

# Install sshpass if needed
if [ -n "$SSH_PASSWORD" ] && ! command -v sshpass &> /dev/null; then
    echo "📦 Installing sshpass..."
    sudo apt-get update -qq
    sudo apt-get install -y sshpass
fi

# Create deployment package
echo "📦 Creating deployment package..."
tar -czf deployment.tar.gz -C ./deployment-package .

# Function to copy files with SSH key
copy_with_key() {
    scp -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no -o ConnectTimeout=10 deployment.tar.gz $USERNAME@$BROGRAMMERS_VPN:/tmp/ &&
    scp -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no $0 $USERNAME@$BROGRAMMERS_VPN:/tmp/deploy.sh
}

# Function to copy files with password
copy_with_password() {
    sshpass -p "$SSH_PASSWORD" scp -o StrictHostKeyChecking=no deployment.tar.gz $USERNAME@$BROGRAMMERS_VPN:/tmp/ &&
    sshpass -p "$SSH_PASSWORD" scp -o StrictHostKeyChecking=no $0 $USERNAME@$BROGRAMMERS_VPN:/tmp/deploy.sh
}

# Function to execute remote deployment with SSH key
execute_with_key() {
    ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no $USERNAME@$BROGRAMMERS_VPN "chmod +x /tmp/deploy.sh && WORK_FOLDER='$WORK_FOLDER' /tmp/deploy.sh remote"
}

# Function to execute remote deployment with password
execute_with_password() {
    sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no $USERNAME@$BROGRAMMERS_VPN "chmod +x /tmp/deploy.sh && WORK_FOLDER='$WORK_FOLDER' /tmp/deploy.sh remote"
}

# Check if this is remote execution
if [ "$1" = "remote" ]; then
    echo "🔍 DEBUG: Executing on remote server..."
    
    # Create backup of current deployment
    echo "🔍 DEBUG: Creating backup of current deployment..."
    if [ -d "$WORK_FOLDER" ]; then
        BACKUP_DIR="${WORK_FOLDER}.backup.$(date +%Y%m%d_%H%M%S)"
        cp -r "$WORK_FOLDER" "$BACKUP_DIR"
        echo "🔍 DEBUG: Backup created at $BACKUP_DIR"
    else
        echo "🔍 DEBUG: No existing deployment to backup"
    fi

    # Create work directory if it doesn't exist
    mkdir -p "$WORK_FOLDER"

    # Extract new deployment
    echo "🔍 DEBUG: Extracting new deployment..."
    cd "$WORK_FOLDER"
    tar -xzf /tmp/deployment.tar.gz

    echo "🔍 DEBUG: Deployment files extracted to $WORK_FOLDER"
    echo "🔍 DEBUG: Deployment contents:"
    ls -la "$WORK_FOLDER"

    # Cleanup unnecessary files from server
    echo "🧹 Cleaning up unnecessary files..."
    find "$WORK_FOLDER" -name "*.map" -delete 2>/dev/null || true
    find "$WORK_FOLDER" -name "*.d.ts" -delete 2>/dev/null || true
    find "$WORK_FOLDER" -name ".DS_Store" -delete 2>/dev/null || true
    find "$WORK_FOLDER" -name "Thumbs.db" -delete 2>/dev/null || true

    # Remove temporary files
    rm -f /tmp/deployment.tar.gz
    rm -f /tmp/deploy.sh

    # Clean old backups (keep only last 2)
    echo "🧹 Cleaning old backups..."
    ls -dt ${WORK_FOLDER}.backup.* 2>/dev/null | tail -n +3 | xargs rm -rf 2>/dev/null || true

    echo "🔍 DEBUG: Final deployment contents:"
    ls -la "$WORK_FOLDER"

    echo "✅ Server deployment completed successfully!"
    echo "🧹 All unnecessary files cleaned up!"
    
else
    # Local execution - copy files and execute remotely
    echo "🚀 Starting deployment to server..."
    
    # Try SSH key first, fallback to password
    if [ -f ~/.ssh/id_rsa ] && copy_with_key 2>/dev/null; then
        echo "✅ SSH key authentication successful"
        execute_with_key
    elif [ -n "$SSH_PASSWORD" ]; then
        echo "🔑 Using password authentication..."
        copy_with_password
        execute_with_password
    else
        echo "❌ No valid authentication method available!"
        exit 1
    fi
    
    # Cleanup local files
    echo "🧹 Cleaning up local files..."
    rm -f deployment.tar.gz
    rm -f ~/.ssh/id_rsa ~/.ssh/id_rsa.pub 2>/dev/null || true
    
    echo "✅ Deployment completed successfully!"
fi