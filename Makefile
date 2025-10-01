.PHONY: install uninstall

install:
	@mkdir -p $(HOME)/.local/bin
	@ln -sf $(CURDIR)/noted $(HOME)/.local/bin/noted
	@echo "Installed noted to $(HOME)/.local/bin/noted"

uninstall:
	@rm -f $(HOME)/.local/bin/noted
	@echo "Uninstalled noted from $(HOME)/.local/bin/noted"
