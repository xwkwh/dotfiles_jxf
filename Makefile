.PHONY: all emacs-compile elisp-compile deploy

PWD := `pwd`
LINK_CMD := ln -s -f
LINK_CMD_HARD := ln -f
NORMAL_FILES_COMMON := `echo gitconfig gitattributes gitignore  vimrc   zshenv zshrc tmux.conf  axelrc ctags`
NORMAL_FILES_LINUX := `echo pentadactylrc  gtkrc-2.0   Xdefaults  xinitrc  Xmodmaprc`
echo:
	@echo "run:"
	@echo "    make deploy"
	@echo "    sudo make sudo"

deploy:
	@for file in $(NORMAL_FILES_COMMON); do $(LINK_CMD) $(PWD)/$$file ~/.$$file; done
	@mkdir -p ~/.ssh
	-$(LINK_CMD_HARD) $(PWD)/ssh_config ~/.ssh/config
	@if [ ! -d ~/bin ]; then\
		mkdir ~/bin;\
	fi
	cp proxy/go-http ~/bin/httpgo;
	cp get ~/bin/get;
	@if [ ! -d ~/.vimbackup ]; then\
		mkdir ~/.vimbackup;\
	fi
	-$(LINK_CMD) $(PWD)/git-remote-hg ~/bin
# @$(LINK_CMD) $(PWD)/ipy_user_conf.py ~/.ipython/ipy_user_conf.py

	@if [ `uname -s` = "Linux" ] ; then \
		mkdir -p ~/.config/; \
		for file in $(NORMAL_FILES_LINUX); do $(LINK_CMD) $(PWD)/$$file ~/.$$file; done; \
	fi

	@if [ `uname -s` = "Darwin" ] ; then \
	  cd mac && $(MAKE) ; \
	fi
sudo:
	@-mv /etc/hosts /tmp/hosts
	-$(LINK_CMD_HARD) $(PWD)/hosts /etc/hosts

	@if [ `uname -s` = "Linux" ] ; then \
	  $(LINK_CMD) $(PWD)/crontab /etc/crontab; \
	fi
	@if [ `uname -s` = "Darwin" ] ; then \
	  cd mac && $(MAKE)  sudo; \
	fi
