#!/bin/bash

# ─── Цвета ────────────────────────────────────────────
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RED="\033[1;31m"
RESET="\033[0m"

# ─── Проверка команд ──────────────────────────────────
has_cmd() { command -v "$1" >/dev/null 2>&1; }

# ─── Заголовок ────────────────────────────────────────
if has_cmd figlet && has_cmd lolcat; then
  figlet "Welcome, axe" | lolcat
else
  echo -e "${CYAN}Welcome, axe${RESET}"
fi

# ─── neofetch ─────────────────────────────────────────
if has_cmd neofetch; then
  neofetch
fi

# ─── Аптайм и дата ────────────────────────────────────
echo -e "${YELLOW}Uptime: ${RESET}$(uptime -p)"
echo -e "${YELLOW}Date:   ${RESET}$(date)"

# ─── Системная информация ─────────────────────────────
if has_cmd hostname; then
  echo -e "${GREEN}Hostname:${RESET} $(hostname)"
fi

if has_cmd uname; then
  echo -e "${GREEN}Kernel:  ${RESET}$(uname -r)"
fi

if has_cmd free; then
  echo -e "${GREEN}Memory:  ${RESET}$(free -h | awk '/Mem:/ {print $3 "/" $2}')"
fi

# ─── Сеть ─────────────────────────────────────────────
if has_cmd ip; then
  ip_addr=$(ip addr show | awk '/inet / && !/127.0.0.1/ {print $2}' | head -n1)
  echo -e "${GREEN}IP:      ${RESET}${ip_addr}"
fi

# ─── WireGuard статус (если установлен) ───────────────
if has_cmd wg; then
  echo -e "${CYAN}WireGuard status:${RESET}"
  wg show
fi

# ─── Доступные обновления (Arch / apt) ────────────────
if [[ -f /etc/arch-release ]] && has_cmd checkupdates; then
  updates=$(checkupdates | wc -l)
  echo -e "${YELLOW}Arch updates: ${RESET}${updates}"
elif has_cmd apt && has_cmd apt-get; then
  updates=$(apt list --upgradable 2>/dev/null | grep -v "Listing" | wc -l)
  echo -e "${YELLOW}Apt updates:  ${RESET}${updates}"
fi
# Final version, fix CDN bug
