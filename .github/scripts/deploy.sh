#!/bin/bash
# deploy.sh - Deploy application to server with cleanup
set -e

echo "🚀 Starting server deployment process..."
echo "🔍 DEBUG: Work folder: $WORK_FOLDER"

# Verify required environment variables
if [ -z "$WORK_FOLDER" ]; then
    echo "❌ Error: WORK_FOLDER environment variable not set!"
    exit 1
fi

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

# Remove development files if they exist
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