macos-prepare:
	brew install the_silver_searcher fzf bat htop fd ncdu tldr httpie

deps-pip:
	python3 -m pip install --user --upgrade pynvim
	python2 -m pip install --user --upgrade pynvim

install-asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

install-ruby:
	asdf install ruby 2.7.2
	asdf global ruby 2.7.2

install-node:
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
	asdf install nodejs 15.5.0
	asdf global nodejs 15.5.0

install-python:
	asdf install python latest
	asdf install python 2.7.13
	asdf global python 3.9.1 2.7.13

deps-gem:
	gem install rake neovim mdl haml-lint sqlint rubocop rubocop-rspec solargraph fastri slim_lint brakeman rails_best_practices reek rspec pry pry-byebug colored http

deps-npm:
	npm install -g neovim
	npm install -g prettier eslint babel-eslint eslint-plugin-import eslint-plugin-node
	npx install-peerdeps -g eslint-config-airbnb
	npm install -g stylelint stylelint-config-recommended stylelint-config-standard
