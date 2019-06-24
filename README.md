Alex's Public Dotfiles
=======================
................................................................................

This repository contains a subset of my various config files that is suitable
for anybody to pick up and use. You can cherry pick from these files or run the
script below to install all of them.

Feel free to fork this repo if you want to start syncronizing your own dotfiles
with Git!


Setup
------
Running this script will save a backup of your existing configs, and then
install this set of configurations. If you want to restore any of your old
files you can find them in the `.dots-backup` folder.

```sh
#! /usr/bin/env sh
# dot-setup.sh

# usage: ./dot-setup.sh [OPTIONS]
#       OPTIONS:
#         -f    -   Overwrite existing files.

# ---------------------------------------------------------------------------- #

# Feel free to replace these paths:

## Path to `git` executable
GIT="${$(which git):-/usr/bin/env git}"

## Path to clone to.
DOTS_DIR="${HOME}/.dots"

## The user's home directory, be sure `.config/` is a subdirectory here.
HOME_DIR="${HOME}"

## Whether to perform backups or not. ( 0 --> No backup,  1 --> Do backup )
## `-f` flag overrwrites this option!
DO_BACKUP=1

## Path to store backed up files.
BACKUP_DIR="${HOME}/.dots-backup"

## Repo to pull from, you can optionally replace this with your own fork.
DOTS_REPO="https://github.com/BadDecisionsAlex/dots-public.git"

# ---------------------------------------------------------------------------- #

DO_BACKUP="${$( [ ${1} = '-f' ] && echo 0 ):-${DO_BACKUP}}"

# Clone/download dotfiles.
"${GIT}" clone --bare "${DOTS_REPO}" "${DOTS_DIR}";

# Make a shorthand for the repo.
function dots {
   "${GIT}" --git-dir="${DOTS_DIR}"/ --work-tree="${HOME_DIR}" ${@};
}

# Try to checkout. (This will probably fail)
dots checkout;

# Save backups if required.
if [ $? = 0 ]; then
  echo "Checked out 'dot-files' successfully!";
else
  if [ ${DO_BACKUP} == 1  ]
    echo "Backing up pre-existing dot files.";
    
    # Move conflicting files so that they aren't overwritten.
    mkdir -p "${BACKUP_DIR}";
    
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
      xargs -I{} mv {} "${BACKUP_DIR}"/{};
    
    # Checkout again.
    dots checkout;
    
    # If we fail again we have an issue...
    if [ $? != 0 ];
      RET=${?}
      echo "There are still issues with 'git checkout'!";
      echo "You might need to manually move some files.";
      echo "If issues persist confirm that path vars are correct.";
      exit ${RET};
    fi
fi

# Stop `git` from listing everything under "Home" as "untracked".
dots config status.showUntrackedFiles no;

# ---------------------------------------------------------------------------- #

# vim: set filetype=sh :
```
