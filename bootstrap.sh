#!/usr/bin/env bash
set -e

echo "🔧 Installing environment for axe..."

# ─── Определяем ОС ────────────────────────────────
OS=""
if [ -f /etc/arch-release ]; then
  OS="arch"
elif [ -f /etc/debian_version ]; then
  OS="debian"
else
  echo "❌ Unsupported OS"
  exit 1
fi

# ─── Устанавливаем зависимости ────────────────────
install_packages() {
  echo "📦 Installing base packages..."
  if [[ "$OS" == "arch" ]]; then
    sudo pacman -Sy --noconfirm zsh git curl wget neofetch figlet lolcat \
      python-pip vnstat inetutils
  elif [[ "$OS" == "debian" ]]; then
    sudo apt update && sudo apt install -y zsh git curl wget neofetch figlet lolcat \
      python3-pip vnstat inetutils-ping net-tools
  fi
}

# ─── Oh My Zsh ─────────────────────────────────────
install_oh_my_zsh() {
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📥 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi
}

# ─── Spaceship Theme ───────────────────────────────
install_spaceship() {
  local THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
  if [ ! -d "$THEME_DIR/spaceship-prompt" ]; then
    echo "✨ Installing Spaceship theme..."
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$THEME_DIR/spaceship-prompt" --depth=1
    ln -sf "$THEME_DIR/spaceship-prompt/spaceship.zsh-theme" "$THEME_DIR/spaceship.zsh-theme"
  fi
}

# ─── Плагины ───────────────────────────────────────
install_plugins() {
  local PLUGINS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

  git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions" 2>/dev/null || true
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting" 2>/dev/null || true
}

# ─── speedtest-cli (безопасная установка) ─────────
install_speedtest_cli() {
  echo "🌐 Installing speedtest-cli..."
  if command -v pip &>/dev/null; then
    pip install --break-system-packages speedtest-cli || true
  else
    echo "⚠️ pip not found — skipping speedtest-cli"
  fi
}

# ─── Копирование dotfiles ──────────────────────────
install_dotfiles() {
  echo "📄 Installing dotfiles..."

  cp -f ./zshrc-unified ~/.zshrc
  cp -f ./welcome.sh ~/.welcome.sh
  chmod +x ~/.welcome.sh

  for file in .eza-aliases.zsh .update.sh .system-cleanup.sh; do
    if [[ -f "$file" ]]; then
      echo "➡️  Installing $file"
      cp -f "$file" ~/
      chmod +x ~/"$file"
    fi
  done
}

# ─── Запуск всех шагов ─────────────────────────────
install_packages
install_oh_my_zsh
install_spaceship
install_plugins
install_speedtest_cli
install_dotfiles

# === eza aliases ===
EZA_ALIASES_URL_RAW="https://raw.githubusercontent.com/AxeKatyshkin/dotfiles/main/eza-aliases.zsh"
EZA_ALIASES_URL_CDN="https://cdn.jsdelivr.net/gh/AxeKatyshkin/dotfiles/eza-aliases.zsh"
EZA_TARGET="$HOME/.eza-aliases.zsh"

echo "📁 Installing eza-aliases.zsh..."
if curl -fsSL "$EZA_ALIASES_URL_RAW" -o "$EZA_TARGET"; then
  echo "✅ eza-aliases.zsh downloaded from raw.githubusercontent.com"
elif curl -fsSL "$EZA_ALIASES_URL_CDN" -o "$EZA_TARGET"; then
  echo "⚠️  raw.githubusercontent.com failed, used jsDelivr CDN"
else
  echo "❌ Failed to download eza-aliases.zsh from both sources"
fi

# Ensure .zshrc sources the alias file
if ! grep -q "eza-aliases.zsh" "$HOME/.zshrc"; then
  echo '[ -f ~/.eza-aliases.zsh ] && source ~/.eza-aliases.zsh' >> "$HOME/.zshrc"
fi

echo "✅ Done! Launch Zsh with:"
echo "   zsh"
