#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Check if the download URL is provided as an environment variable
if [ -z "$OSRM_DATA_DOWNLOAD_URL" ]; then
  echo "Error: OSRM_DATA_DOWNLOAD_URL environment variable is not set."
  exit 1
fi

echo "Downloading OSRM data from $OSRM_DATA_DOWNLOAD_URL..."
# Download the data file
curl -L "$OSRM_DATA_DOWNLOAD_URL" -o osrm-data.tar.gz

echo "Extracting data..."
# Extract the tarball
tar -xzf osrm-data.tar.gz

echo "Starting OSRM server..."
# Find the .osrm file and run the server. This is more robust than a fixed name.
OSRM_FILE=$(find . -name "*.osrm" -print -quit)
./osrm-routed --algorithm mld "$OSRM_FILE"