init:
	mkdir ~/bin
	mkdir -p ~/gopaths/global
	mkdir -p ~/.config/nvim
	mkdir -p ~/.tmux/plugins
	mkdir -p ~/.ipython/profile_default

install: init
	installer/bootstrap.sh

clean:
	rm -rf ~/bin
	rm -rf ~/gopaths/global
	rm -rf ~/.config/nvim
	rm -rf ~/.zprezto
	rm -rf ~/.tmux
