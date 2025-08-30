#!/bin/bash
# deploy-hugo.sh
# Usage: ./deploy-hugo.sh
# Requires the following environment variables:
#   HUGO_PUBLIC   → local Hugo public folder (default ./public/)
#   REMOTE_USER   → SSH user on VPS
#   REMOTE_HOST   → VPS IP or hostname
#   REMOTE_PATH   → path on VPS to deploy Hugo files

: "${HUGO_PUBLIC:=./public/}"
: "${REMOTE_USER:?Need to set REMOTE_USER}"
: "${REMOTE_HOST:?Need to set REMOTE_HOST}"
: "${REMOTE_PATH:?Need to set REMOTE_PATH}"

echo "Building Hugo site..."
hugo --minify
if [ $? -ne 0 ]; then
    echo "Hugo build failed. Aborting."
    exit 1
fi

echo "Copying files to VPS..."
scp -r "$HUGO_PUBLIC"* "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"
if [ $? -ne 0 ]; then
    echo "File transfer failed. Aborting."
    exit 1
fi

echo "Setting permissions..."
ssh "$REMOTE_USER@$REMOTE_HOST" "sudo chown -R www-data:www-data $REMOTE_PATH && sudo chmod -R 755 $REMOTE_PATH"
if [ $? -ne 0 ]; then
    echo "Failed to set permissions. Aborting."
    exit 1
fi

echo "Reloading Nginx..."
ssh "$REMOTE_USER@$REMOTE_HOST" "sudo nginx -t && sudo systemctl reload nginx"
if [ $? -ne 0 ]; then
    echo "Nginx reload failed. Aborting."
    exit 1
fi

echo "Deployment complete! Site should be live."
