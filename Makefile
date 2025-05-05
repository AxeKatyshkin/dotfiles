# 📦 Makefile — команды для работы с dotfiles

# Установка окружения (zsh, тема, welcome)
install:
	bash bootstrap.sh

# Перезапуск Zsh
zsh:
	zsh

# Проверка welcome-экрана вручную
test:
	bash welcome.sh

# Обновить dotfiles из GitHub
update:
	git pull origin main
