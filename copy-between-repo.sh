#!/bin/bash

if [ "$1z" == "z" ] || [ "$2z" == "z" ]; then
    echo "Please provide a source and destination" 1>&2
    exit 1
elif [ ! -e "$1" ] || [ ! -e "$2" ]; then
    echo "Please provide files / directories that exist" 1>&2
    exit 2
fi

# This script will copy a file from one repository to another, preserving
# commit history.
PATCH="/tmp/git-history.$$"

# Get absolute path for the file/dir and destination
FILE=`readlink -f $1`
DEST=`readlink -f $2`

REPO=`dirname $FILE`
SRC=`basename $FILE`

# Change to the repository directory (so git commands will work)
pushd $REPO

# Dump a patch file that contains all the history of the file
# or directory we are interested in.
git log --pretty=email --patch-with-stat --reverse -- $SRC > $PATCH

# Check for error, display warning and exit on failure
if [ $? -ne 0 ]; then
    echo "Failed to create email patch for $FILE" >&2
    exit 1
fi

# Leave first git repository then move to the destination
popd
pushd $DEST

# Use git-am (apply from email) to apply the patch to the new repository
git am < $PATCH

patch_rv=$?
popd
if [ $patch_rv -ne 0 ]; then
    echo "Failed to apply email patch to $DEST" >&2
    echo >&2
    echo "Attempted patch not deleted: $PATCH" >&2
    exit 2
else
    # Clean up
    rm $PATCH
fi
