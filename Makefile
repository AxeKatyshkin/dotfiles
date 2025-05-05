REPO = AxeKatyshkin/dotfiles
BRANCH = main
INSTALL_URL = https://cdn.jsdelivr.net/gh/$(REPO)/install.sh

.PHONY: all install bootstrap sync check-raw

all: install

install:
	@echo "🚀 Installing dotfiles via install.sh..."
	@bash <(curl -sL $(INSTALL_URL))

bootstrap:
	@echo "🔧 Running local bootstrap.sh..."
	@chmod +x bootstrap.sh && ./bootstrap.sh

sync:
	@echo "📤 Syncing and pushing dotfiles to GitHub..."
	@git add -A
	@git commit -m "Sync dotfiles"
	@git push

check-raw:
	@echo "🔍 Checking raw.githubusercontent and jsDelivr availability..."
	@for file in bootstrap.sh zshrc-unified welcome-final.sh; do \
	  echo "🔗 Checking $$file..."; \
	  curl -sfI https://raw.githubusercontent.com/$(REPO)/$(BRANCH)/$$file && echo "✅ raw.githubusercontent: $$file OK" || echo "❌ raw.githubusercontent: $$file NOT FOUND"; \
	  curl -sfI https://cdn.jsdelivr.net/gh/$(REPO)/$$file && echo "✅ jsDelivr: $$file OK" || echo "❌ jsDelivr: $$file NOT FOUND"; \
	  echo ""; \
	done
