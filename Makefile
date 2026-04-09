LN := ln -sfT
CONFIG_DIR := $(HOME)/.config
MODULES := alacritty dunst i3 kanshi keepassxc newsboat nvim rofi swaylock waybar wireplumber

.PHONY: all $(MODULES) bin git zsh

PKG_FILES := packages/*

# "Function" that expands to a shell pipeline
define collect_files
cat $(PKG_FILES) | \
grep -vhE '^\s*#|^\s*$$' | \
sed 's|^[^/]*/||' | \
sort -u
endef


all: $(MODULES) bin git zsh nobeep pacman-nopasswd

$(MODULES):
	$(LN) $(PWD)/$@ $(CONFIG_DIR)/$@

bin:
	$(LN) $(PWD)/bin $(HOME)/.bin

git:
	$(LN) $(PWD)/git/.gitconfig $(HOME)/.gitconfig

zsh:
	$(LN) $(PWD)/zsh/.zshrc $(HOME)/.zshrc
	$(LN) $(PWD)/zsh/.zprofile $(HOME)/.zprofile

nobeep:
	@if grep -qxF "blacklist pcspkr" /etc/modprobe.d/nobeep.conf 2>/dev/null; then \
		echo "nobeep: already configured"; \
	else \
		echo "blacklist pcspkr" | sudo tee -a /etc/modprobe.d/nobeep.conf >/dev/null; \
		echo "nobeep: added"; \
	fi

pacman-nopasswd:
	@echo "%wheel ALL=(ALL) NOPASSWD: /usr/bin/pacman" | \
	sudo tee /etc/sudoers.d/pacman-nopasswd >/dev/null
	@sudo chmod 0440 /etc/sudoers.d/pacman-nopasswd
	@sudo visudo -cf /etc/sudoers >/dev/null && \
		echo "pacman-nopasswd: configured" || \
		echo "pacman-nopasswd: WARNING invalid sudoers!"

provision:
	@echo "Installing packages..."
	@pkgs="$$( $(collect_files) )"; \
	yay --needed -S $$pkgs

check:
	@echo "Not installed:"
	@comm -23 \
		<( $(collect_files) ) \
		<( yay -Qq | sort )
	@echo
	@echo "Explicitly installed but not declared:"
	@comm -13 \
		<( $(collect_files) ) \
		<( pacman -Qqe | sort )
