install:
	ansible-galaxy collection install -r requirements.yml
	ansible-galaxy role install -r requirements.yml

playbook:
	ansible-playbook -i inventory.yml playbooks/main.yml -v

linking-files:
	ansible-playbook -i inventory.yml playbooks/linking-files.yml -v

PACKER_PATH=~/.local/share/nvim/site/pack/packer/start

nvim-install:
	rm -rf nvim/plugin || exit 0
	rm -rf ~/.local/share/nvim || exit 0
	rm -rf ~/.config/nvim || exit 0
	rm -rf $(PACKER_PATH) || exit 0
	mkdir -p $(PACKER_PATH)
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $(PACKER_PATH)/packer.nvim
	ln -snf $(PWD)/nvim ~/.config/nvim

macos-prepare:
	brew install neovim git the_silver_searcher fzf bat htop fd ncdu tldr httpie git-delta ripgrep gnu-sed tmux asdf

deps-pip:
	python3 -m pip install --user --upgrade pynvim
	python2 -m pip install --user --upgrade pynvim

install-ruby:
	asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
	asdf install ruby 3.1.0
	asdf global ruby 3.1.0

install-node:
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf install nodejs 17.4.0
	asdf global nodejs 17.4.0

install-python:
	asdf plugin-add python
	asdf install python 3.9.1
	asdf install python 2.7.13
	asdf global python 3.9.1 2.7.13

update-vim-plugins:
	nvim --headless +PlugUpdate +qall
	nvim --headless +CocUpdate +qall

deps-gem:
	gem install solargraph rubocop neovim
	gem install rubocop-rspec rubocop-rails rubocop-performance rubocop-rake
	gem install sorbet sorbet-runtime
	gem install haml_lint slim_lint
	gem install brakeman reek

deps-npm:
	npm install -g neovim
	npm install -g prettier eslint @babel/eslint-parser eslint-plugin-import eslint-plugin-node
	npx install-peerdeps -g eslint-config-airbnb
	npm install -g stylelint stylelint-config-recommended stylelint-config-standard
	npm install -g yaml-language-server markdownlint bash-language-server
	npm install -g dockerfile-language-server-nodejs
