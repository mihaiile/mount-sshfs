#!/bin/bash

# Config ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

USERNAME=theusername        # for example : root

HOST=thehost                # your host, eg: ansolas.de

REMOTEDIR=/                 # remote dir, /srv/users/daslicht/apps/homepage/public

VOLUMENAME=thevolumename    # this sets the name the mounted folder 

# –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

MOUNTROOT=~/volumes/
MOUNT=$MOUNTROOT/$VOLUMENAME

# Execute the SSHFS Mount command
MountVolume() {
  echo "mounting the volume..."
  sshfs -o volname=$VOLUMENAME -o local $USERNAME@$HOST:$REMOTEDIR $MOUNT
}

# Check if Mount  Folder exists, if not create it
# when done call Mount()
CheckIfMountFolderExists() {
  if [ -d "$MOUNT" ]; then
    MountVolume
  else
    echo "creating mount folder..."
    mkdir $MOUNT
  fi
}


# Check if Mount Root Folder exists, if not create and hide it
CheckIfMountROOTFolderExists() {
  if [ -d "$MOUNTROOT" ]; then
    CheckIfMountFolderExists
  else
    echo "creating mount root folder..."
    mkdir $MOUNTROOT
    chflags hidden $MOUNTROOT # Hide folder
    CheckIfMountFolderExists
  fi
}
CheckIfMountROOTFolderExists


# guess what :)
echo "done"
