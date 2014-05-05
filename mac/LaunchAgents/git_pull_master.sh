#!/bin/sh
# cd $@ && git checkout master && git pull
cd ~/.emacs.d/&& git fetch origin  && git push origin master:master
# if [ -d ~/repos/proj_golang/src/zerogame.info/thserver/ ]; then
#     cd ~/repos/proj_golang/src/zerogame.info/thserver/&& git fetch origin 
# fi
if [ -d ~/repos/proj_golang/src/zerogame.info/thconf/ ]; then
    cd ~/repos/proj_golang/src/zerogame.info/thconf/&& git fetch origin 
fi

cd ~/repos/proj_golang/src/zerogame.info/thtools/ && git fetch origin 
if [ -d ~/repos/godlike  ] ; then
    svn cleanup ~/repos/godlike
    svn up ~/repos/godlike
fi

if [ -d ~/repos/dotfiles/ ]; then
    cd ~/repos/dotfiles/ && git fetch origin 
fi


echo "git_pull_master agent launched at " `date`
