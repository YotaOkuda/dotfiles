DOTFILES_DIR := $(shell cd $(dir $(abspath $(lastword $(MAKEFILE_LIST)))) && pwd)
CONFIG_DIR   := $(DOTFILES_DIR)/.config
TPM_DIR      := $(CONFIG_DIR)/tmux/plugins/tpm

APPS := tmux nvim aerospace sketchybar fastfetch gh borders karabiner ghostty

.PHONY: setup brew link submodule sketchybar neovim tmux services

setup: brew link submodule sketchybar neovim tmux services
	@echo "--- setup complete ---"

# ---------------------------------------------------------------------------
# brew: install Homebrew if missing, then bundle install
# ---------------------------------------------------------------------------
brew:
	@if ! command -v brew >/dev/null 2>&1; then \
		echo "Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		eval "$$(/opt/homebrew/bin/brew shellenv)"; \
	fi
	brew bundle --file=$(DOTFILES_DIR)/Brewfile

# ---------------------------------------------------------------------------
# link: create symlinks for .config apps and zsh dotfiles
# ---------------------------------------------------------------------------
link:
	@mkdir -p $(HOME)/.config
	@for app in $(APPS); do \
		if [ -d "$(HOME)/.config/$$app" ] && [ ! -L "$(HOME)/.config/$$app" ]; then \
			echo "Warning: $(HOME)/.config/$$app is a real directory. Moving to .bak"; \
			mv "$(HOME)/.config/$$app" "$(HOME)/.config/$${app}.bak"; \
		fi; \
		ln -snfv "$(CONFIG_DIR)/$$app" "$(HOME)/.config/$$app"; \
	done
	ln -sfv "$(CONFIG_DIR)/zsh/.zshrc"    "$(HOME)/.zshrc"
	ln -sfv "$(CONFIG_DIR)/zsh/.zprofile" "$(HOME)/.zprofile"

# ---------------------------------------------------------------------------
# submodule: init powerlevel10k etc.
# ---------------------------------------------------------------------------
submodule:
	git -C $(DOTFILES_DIR) submodule update --init --recursive

# ---------------------------------------------------------------------------
# sketchybar: build SbarLua + download sketchybar fonts
# ---------------------------------------------------------------------------
sketchybar:
	@( [ -d /tmp/SbarLua ] || git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua ) \
		&& $(MAKE) -C /tmp/SbarLua install \
		&& rm -rf /tmp/SbarLua
	@curl -fLo $(HOME)/Library/Fonts/sketchybar-app-font.ttf \
		--create-dirs \
		https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.54/sketchybar-app-font.ttf
	@( [ -d /tmp/sketchybar-app-font-bg ] || git clone https://github.com/SoichiroYamane/sketchybar-app-font-bg.git /tmp/sketchybar-app-font-bg ) \
		&& cd /tmp/sketchybar-app-font-bg && pnpm install && pnpm run build:install \
		&& rm -rf /tmp/sketchybar-app-font-bg

# ---------------------------------------------------------------------------
# neovim: sync Lazy plugins headlessly
# ---------------------------------------------------------------------------
neovim:
	nvim --headless "+Lazy! sync" +qa

# ---------------------------------------------------------------------------
# tmux: install tpm if missing, then install plugins
# ---------------------------------------------------------------------------
tmux:
	@if [ ! -d "$(TPM_DIR)" ]; then \
		git clone https://github.com/tmux-plugins/tpm "$(TPM_DIR)"; \
	fi
	$(TPM_DIR)/bin/install_plugins

# ---------------------------------------------------------------------------
# services: start brew services
# ---------------------------------------------------------------------------
services:
	brew services start sketchybar
	brew services start borders
	open -a AeroSpace
