# Dotfiles

This is my dotfiles repository. There are many like it, but this one is mine.

* The `/bin` directory contains executables and is added to the path.

* The `/config` directory contains application configuration files.

* The `/lib` directory contains libraries.

* The `/link` directory contains files that are symlinked into `~/` on
  initialization.

* The `/mac` directory contains OSX-specific system administration commands.

* The `/source` directory contains files that are sourced whenever a new shell
  is opened.

A `backups` directory is automatically created if necessary to store copies of any files overwritten by the initialization script.

The `dot` command provides an interface to the installation's utility functions:

    Usage: dot <command>

      Management utility for the dotfiles installation.

    Commands:
      update    Update the local dotfiles repository.
      init      Initialize/reinitialize the installation.
      src       Source all files in ~/.dotfiles/source.
      link      Link all files in ~/.dotfiles/link into ~/.
      log       Print the log file to stdout.


## Installation

    git clone https://github.com/dmulholl/dotfiles.git ~/.dotfiles
    source ~/.dotfiles/admin/init.sh

The installation can be reinitialized at any time using the `dot init` command.


## License

Public domain, unless specified otherwise. Third-party libraries and utilities are subject to their own specific licenses. See the individual files for details.
