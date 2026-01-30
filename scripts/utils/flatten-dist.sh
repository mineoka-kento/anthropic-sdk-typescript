#!/usr/bin/env bash
# Flatten the dist directory contents to the root directory.
# This script:
# 1. Removes all files/directories in root except dist
# 2. Moves all contents from dist to root
# 3. Removes the empty dist directory

set -e

ROOT_DIR="$PWD"
DIST_DIR="$ROOT_DIR/dist"

if [ ! -d "$DIST_DIR" ]; then
  echo "Error: dist directory does not exist"
  exit 1
fi

# Step 1: Remove all files and directories in root except dist
for item in "$ROOT_DIR"/*; do
  if [ "$(basename "$item")" != "dist" ]; then
    rm -rf "$item"
  fi
done

# Also remove hidden files/directories (except . and ..)
for item in "$ROOT_DIR"/.[!.]*; do
  if [ -e "$item" ]; then
    rm -rf "$item"
  fi
done

# Step 2: Move all contents from dist to root
for item in "$DIST_DIR"/*; do
  if [ -e "$item" ]; then
    mv "$item" "$ROOT_DIR/"
  fi
done

# Also move hidden files from dist
for item in "$DIST_DIR"/.[!.]*; do
  if [ -e "$item" ]; then
    mv "$item" "$ROOT_DIR/"
  fi
done

# Step 3: Remove the empty dist directory
rmdir "$DIST_DIR"

echo "Successfully flattened dist directory to root"
