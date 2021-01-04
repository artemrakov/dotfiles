macos-prepare:
	brew install the_silver_searcher fzf bat htop fd ncdu tldr httpie

deps-pip:
	# pip2 install --upgrade pynvim
	pip3 install --upgrade pynvim

install-ruby:
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
	rbenv install 2.7.2
	rbenv global 2.7.2

install-node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | zsh
	nvm install 14.15.0

deps-gem:
	gem install rake neovim mdl haml-lint sqlint rubocop rubocop-rspec solargraph fastri slim_lint brakeman rails_best_practices reek rspec pry pry-byebug colored http bunlder

deps-npm:
	npm install -g neovim
	npm install -g prettier eslint babel-eslint eslint-plugin-import eslint-plugin-node
	npx install-peerdeps -g eslint-config-airbnb
	npm install -g stylelint stylelint-config-recommended stylelint-config-standard
