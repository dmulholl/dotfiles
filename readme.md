
Dotfiles
========

This is my dotfiles repository. There are many like it, but this one is mine.

This repository isn't suitable for public use *as is*, but, as usual with these things, you may find useful snippets of code in it that you can repurpose to suit your own needs.


Structure
---------

* The `/bin` directory is added to the path.

* The `/link` directory contains files that are symlinked into `~/` on
  initialization.

* The `/os` directory contains OS-specific initialization scripts.

* The `/source` directory contains files that are sourced whenever a new shell
  is opened. The files in this directory can be re-sourced at any time using the
  `src` command.


Installation
------------

    $ git clone https://github.com/dmulholland/dotfiles.git ~/.dotfiles && source ~/.dotfiles/init.sh

The installation can be reinitialized at any time using the `dotfiles` command.


License
-------

This work has been placed in the public domain.
