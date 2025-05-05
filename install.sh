#!/usr/bin/env bash
set -e

echo "📦 Cloning dotfiles repo..."
git clone https://github.com/AxeKatyshkin/dotfiles.git ~/dotfiles

cd ~/dotfiles

echo "🚀 Running bootstrap.sh..."
bash bootstrap.sh

echo "✅ Done! Launch zsh:"
echo "   zsh"
