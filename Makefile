# Makefile for Tylex
#
# This Makefile handles the installation and uninstallation of Tylex scripts.

PREFIX?=/usr
BINDIR?=$(PREFIX)/bin
DOCDIR?=$(PREFIX)/share/doc/tylex

# List of scripts to be installed as executables
SCRIPTS=tylex-expand tylex-add tylex-reset

# Default target
all:
	@echo "Run 'sudo make install' to install system-wide."
	@echo "Run 'make config' as a regular user to create a local config file."
	@echo "Run 'sudo make uninstall' to remove the installation."

# System-wide installation of executable scripts and documentation. Requires root.
install:
	@echo "Installing Tylex scripts to $(DESTDIR)$(BINDIR)..."
	@install -Dm755 $(SCRIPTS) -t "$(DESTDIR)$(BINDIR)"
	@echo "Installing documentation and config template to $(DESTDIR)$(DOCDIR)..."
	@install -Dm644 README.md -t "$(DESTDIR)$(DOCDIR)"
	@install -Dm644 config.sh -t "$(DESTDIR)$(DOCDIR)"
	@echo "Installation complete."
	@echo ""
	@echo "For manual installs, you can now run 'make config' as a regular user."

# User-specific configuration setup. Does NOT require root.
config:
	@if [ "$$(id -u)" = "0" ]; then \
		echo "Error: 'make config' must be run as a regular user, not as root."; \
		echo "Please run this command again without 'sudo'."; \
		exit 1; \
	fi
	@echo "Creating user configuration directory at ~/.config/tylex..."
	@mkdir -p "$(HOME)/.config/tylex"
	@echo "Copying default config.sh to ~/.config/tylex/config.sh..."
	@install -b -m644 config.sh "$(HOME)/.config/tylex/config.sh"
	@echo "Configuration setup complete. You can now edit the file to customize Tylex."

# System-wide uninstallation. Requires root.
uninstall:
	@echo "Removing Tylex scripts from $(DESTDIR)$(BINDIR)..."
	@rm -f $(addprefix $(DESTDIR)$(BINDIR)/,$(SCRIPTS))
	@echo "Removing documentation from $(DESTDIR)$(DOCDIR)..."
	@rm -rf "$(DESTDIR)$(DOCDIR)"
	@echo "Uninstallation complete."
	@echo "Note: User configuration and data files are not removed."

.PHONY: all install config uninstall

