# 🛠️ axe's Dotfiles

> Personal terminal setup for Arch, Ubuntu, macOS, and Docker.  
> Includes Zsh, Oh My Zsh, Spaceship Prompt, welcome screen, aliases, and plugins.

---

## ✨ Features

- ⚙️ Universal `.zshrc` — works across macOS, Arch, Ubuntu, and containers
- 🚀 Automatic setup via `bootstrap.sh`
- 🛰️ Spaceship prompt (git-aware, clean, fast)
- 🤖 Plugins:
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
- 🎨 Welcome screen with:
  - `figlet`, `lolcat`, `neofetch`, `uptime`, `ip`, memory info
- 🧠 Intelligent checks (commands, OS, Docker, VSCode Remote)

---

## 📦 Installation

Clone and run the bootstrap script:

```bash
git clone git@github.com:AxeKatyshkin/dotfiles.git
cd dotfiles
bash bootstrap.sh

---
---

## ☝️ Установка одной командой

```bash
curl -sL https://raw.githubusercontent.com/AxeKatyshkin/dotfiles/main/install.sh | bash


## 📦 Makefile команды

После клонирования можно использовать `make`:

| Команда         | Что делает                                  |
|------------------|---------------------------------------------|
| `make install`   | Запускает `bootstrap.sh` и устанавливает всё |
| `make zsh`       | Открывает Zsh оболочку вручную              |
| `make test`      | Тестирует `welcome.sh`                      |
| `make update`    | Подтягивает обновления из GitHub            |

 __        __   _
 \ \      / /__| | ___ ___  _ __ ___   ___
  \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \
   \ V  V /  __/ | (_| (_) | | | | | |  __/
    \_/\_/ \___|_|\___\___/|_| |_| |_|\___|

 Welcome, axe

 OS: Arch Linux x86_64
 Uptime: 2h 13m
 Memory: 1.2Gi / 7.7Gi
 IP: 10.13.13.50
 Kernel: 6.12.5-linuxkit
