#!/bin/bash

VOLUME_NAME="my_volume"
TIMESTAMP=$(date +%F-%H-%M)
ARCHIVE_NAME="${VOLUME_NAME}_backup_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="/tmp/${ARCHIVE_NAME}"
S3_BUCKET="s3://my-devops-backupplan"

# Backup using Docker (mount volume and save to /tmp)
docker run --rm -v ${VOLUME_NAME}:/data -v /tmp:/backup alpine \
  tar czf "/backup/${ARCHIVE_NAME}" -C /data .

# Upload to S3
aws s3 cp "$ARCHIVE_PATH" "$S3_BUCKET/"

# Cleanup (optional)
rm "$ARCHIVE_PATH"

echo "✅ Backup complete: ${ARCHIVE_NAME} uploaded to ${S3_BUCKET}"
