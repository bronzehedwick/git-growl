#!bin/bash
# Installs git-growl notifications to current git repo
# @author Chris DeLuca (bronzehedwick)

TARGET=${PWD##}
GIT_GROWL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UNAME=$( uname )

# Determine operating system
if [ "$UNAME" == 'Darwin' ]
then
    OS="osx"
elif [ "$UNAME" == 'Linux' ]
then
    OS="linux"
else
    OS='unknown'
    echo "You're on an OS that's too exotic for this script! Please install something else and try again."
    exit 0
fi

FILES=$GIT_GROWL_DIR/$OS/*

# Install function
setup ()
{
    for f in $FILES
    do
        echo "Linking $DIR/"$f" to $TARGET"
        ln -s $DIR/"$f" $TARGET
    done
    echo "Done"
    exit 0
}

# Check if we're in a git repo, then if we are determine the top level directory
if [ $(git rev-parse --show-toplevel) != "fatal: Not a git repository (or any of the parent directories): .git" ]
then
    TARGET=$(git rev-parse --show-toplevel)
    TARGET=$TARGET"/.git/hooks/"
    setup
else
    echo "\033[0;31mError:\033[39m You're not in a git repository!\nPlease navigate to one and run this script again"
    exit 1
fi

