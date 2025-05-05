#!/usr/bin/env bash
set -e

REPO="AxeKatyshkin/dotfiles"
BRANCH="main"

fetch_with_fallback() {
  local file="$1"
  local target="$2"

  echo "📦 Fetching $file..."

  RAW_URL="https://raw.githubusercontent.com/$REPO/$BRANCH/$file"
  CDN_URL="https://cdn.jsdelivr.net/gh/$REPO/$file"

  # Проверяем доступность raw
  if curl -sfI "$RAW_URL" | grep -q "200"; then
    curl -sL "$RAW_URL" -o "$target"
    echo "✅ Downloaded from GitHub raw"
  elif curl -sfI "$CDN_URL" | grep -q "200"; then
    curl -sL "$CDN_URL" -o "$target"
    echo "✅ Downloaded from jsDelivr fallback"
  else
    echo "❌ Failed to fetch $file from both raw.githubusercontent and jsDelivr"
    exit 1
  fi

  chmod +x "$target"
}

echo "🔧 Installing dotfiles from $REPO..."

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

fetch_with_fallback "bootstrap.sh" "bootstrap.sh"
fetch_with_fallback "zshrc-unified" "zshrc-unified"
fetch_with_fallback "welcome-final.sh" "welcome.sh"

echo "🚀 Running bootstrap.sh..."
bash bootstrap.sh

echo "✅ Dotfiles installation complete!"
