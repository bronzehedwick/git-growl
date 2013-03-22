#!bin/bash
# Installs git-growl notifications to current git repo
# @author Chris DeLuca (bronzehedwick)

TARGET=${PWD##}
GIT_GROWL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
UNAME=$( uname )

# Determine operating system
platform ()
{
  if [ "$UNAME" == 'Darwin' ]
  then
      OS="osx"
  elif [ "$UNAME" == 'Linux' ]
  then
      OS="linux"
  else
      echo "\033[0;31mError:\033[39m You're using an OS that's too exotic for this script! Please install something else and try again."
      exit 1
  fi

  # Check what notification system is installed
  if [ $OS == "linux" ] ; then
    which libnotify > /dev/null
    if [ $? != 0 ] ; then
      NOTIF="libnotify"
    fi
    which kdialog > /dev/null
    if [ $? == 0 ] ; then
      OS=$OS/kde
    else
      echo "\033[0;31mError:\033[39m You don't have a supported notification system installed. Please install either libnotify or knotify4 to continue."
    fi
  elif [ $OS = "Darwin" ] ; then
    which growlnotify > /dev/null
    if [ $? == 0 ] ; then
      NOTIF="growlnotify"
    else
      echo "\033[0;31mError:\033[39m growlnotify is not installed. Please install it from the following URL: http://growl.info/downloads#generaldownloads"
    fi
  fi

  FILES=$GIT_GROWL_DIR/$OS/*
  find_git
}

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
find_git ()
{
  if [ $(git rev-parse --show-toplevel) != "fatal: Not a git repository (or any of the parent directories): .git" ] ; then
      TARGET=$(git rev-parse --show-toplevel)
      TARGET=$TARGET"/.git/hooks/"
      setup
  else
      echo "\033[0;31mError:\033[39m You're not in a git repository!\nPlease navigate to one and run this script again"
      exit 1
  fi
}

platform

