init:
	mkdir -p ~/bin
	mkdir -p ~/.config
	mkdir -p ~/.tmux/plugins/tmp
	mkdir -p ~/gopaths/global
	mkdir -p ~/.ipython/profile_default

install: init
	installer/bootstrap.sh

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
