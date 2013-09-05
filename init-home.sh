#!/bin/sh

USER='cpbills'
#REPO="http://github.com/${USER}/dot-files.git"
REPO="/home/${USER}/projects/repos/dot-files"
TEMP="/tmp/${USER}-dot-files.$$"

if [ -d "$HOME/.git" ]; then
    echo "Home directory already checked out?" >&2
    echo " $HOME/.git found, do you need to prep $HOME/ ?" >&2
    exit 1
fi

/usr/bin/git clone $REPO $TEMP > /dev/null
mv $TEMP/.git $HOME/

# change to $HOME since git commands don't accept directory args
pushd $HOME > /dev/null 2>&1

# 'stash' the changes.
# Because all the files tracked are missing, stashing the changes 'magically'
# recreates and places all the tracked files where they belong.
git stash
git stash drop

# return to whatever directory the script was called from
popd > /dev/null 2>&1

# clean up
rm -rf $TEMP
