init-mini:
	mkdir -p ~/bin
	mkdir -p ~/.config/nvim
	mkdir -p ~/.tmux/plugins/tmp

init: init-mini
	mkdir -p ~/gopaths/global
	mkdir -p ~/.ipython/profile_default

install: init
	installer/bootstrap.sh

install-mini: init-mini
	installer/bootstrap-mini.sh

update-links:
	installer/linkfiles.sh

update-vim-plugins:
	vim +PlugInstall +UpdateRemotePlugins +qall

clean:
	rm -rf ~/bin
	rm -rf ~/gopaths/global
	rm -rf ~/.config/nvim
	rm -rf ~/.zprezto
	rm -rf ~/.tmux
	rm -rf ~/.emacs.d
	rm -rf ~/.doom.d
