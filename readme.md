
# Dotfiles #

This is my dotfiles repository. There are many like it, but this one is mine.

This repository isn't suitable for public use *as is*, but, as usual with these things, you may find useful snippets of code in it that you can repurpose to suit your own needs.


## Structure ##

* The `/bin` directory contains executables and is added to the path.

* The `/lib` directory contains third-party code.

* The `/link` directory contains files that are symlinked into `~/` on
  initialization.

* The `/os` directory contains OS-specific initialization scripts.

* The `/source` directory contains files that are sourced whenever a new shell
  is opened.

A `backups` directory is automatically created if necessary to store copies of any files overwritten by the initialization script.

The `dot` command acts as an interface to the installation's utility functions:

    Usage: dot <command>

      Interface to the dotfiles utility functions.

    Commands:
      update    update the local repository
      init      reinitialize the installation
      source    source all files in /source
      link      link all files in /link into ~/
      log       print the log file


## Installation ##

    $ git clone https://github.com/dmulholland/dotfiles.git ~/.dotfiles && source ~/.dotfiles/init.sh

The installation can be reinitialized at any time using the `dot init` command.


## License ##

All my own code in this repository has been placed in the public domain.

The `/lib` directory contains third-party libraries and utilities which are subject to their own individual licenses.

The `/link/vim` directory contains third-party plugins which are subject to their own individual licenses.
