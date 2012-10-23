#!/usr/bin/env sh

endpath="$HOME/.git-growl"


echo "Thanks for installing git-growl\n"


if [ ! -e $endpath/.git ]; then
    echo "cloning git-growl\n"
    git clone --recursive -b alpha-1 http://github.com/bronzehedwick/git-growl.git $endpath
else
    echo "updating git-growl\n"
    cd $endpath && git pull
fi

