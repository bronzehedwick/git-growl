#!bin/bash
# Installs git-growl notifications to current git repo
# @author Chris DeLuca (bronzehedwick)

TARGET=${PWD##}
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Determine operating system
if ($(uname) == "Darwin")
then
    FILES="osx/*"
else
    FILES="linux/*"
fi

# Install function
setup ()
{
    for f in $FILES
    do
      if [ -f $f ]
      then
        echo "Linking $DIR/$f to $TARGET/$f"
        ln -s $DIR/$f $TARGET/$f
      fi
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

