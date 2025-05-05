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
  if [[ "$OS" == "arch" ]]; then
    sudo pacman -Syu --noconfirm zsh git curl wget neofetch figlet lolcat \
      python-pip vnstat ifstat inetutils
    pip install speedtest-cli
  elif [[ "$OS" == "debian" ]]; then
    sudo apt update && sudo apt install -y zsh git curl wget neofetch figlet lolcat \
      python3-pip vnstat ifstat inetutils-ping net-tools
    pip3 install speedtest-cli
  fi
}

# ─── Устанавливаем Oh My Zsh ──────────────────────
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

  if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_DIR/zsh-autosuggestions"
  fi
  if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$PLUGINS_DIR/zsh-syntax-highlighting"
  fi
}

# ─── Копируем конфиги ──────────────────────────────
install_dotfiles() {
  echo "📄 Installing dotfiles..."
  cp ./zshrc-unified ~/.zshrc
  cp ./welcome.sh ~/.welcome.sh
  chmod +x ~/.welcome.sh
}

# ─── Всё запускаем ─────────────────────────────────
install_packages
install_oh_my_zsh
install_spaceship
install_plugins
install_dotfiles

echo "✅ Done! Запусти zsh чтобы протестировать:"
echo "   zsh"
