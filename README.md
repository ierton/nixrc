NixOS Configurations
====================
This folder contains configuration files for my [NixOS](http://www.nixos.org) systems as well as 
nixrc script containing some usefull functions for NixOS development.

* nixos-homeserver.nix
* nixos-intel-ideapad.nix
* nixos-samsung-np900x3c.nix

Nix-Dev helpers
===============

Nixrc is a plain bash script carefully written to assist in NixOS development.

Deploying
---------

Deploying is not fully automatic so you probably will have to watch inside ./nixrc to find out
the details.

    $ git clone https://github.com/ierton/nixrc && cd nixrc

    $ git clone https://github.com/NixOS/nixpkgs

    $ git clone https://github.com/NixOS/nixos
    
    $ echo export NIX_DEV_ROOT=`pwd` >> ~/.bash_profile

    $ . ./nixrc
    
    $ nix-dev-
    nix-dev-asroot           nix-dev-pfetch           nix-dev-rebuild-dryrun
    nix-dev-attr-by-name     nix-dev-pfetch-by-attr   nix-dev-rebuild-switch
    nix-dev-fetch            nix-dev-rebase           nix-dev-revision
    nix-dev-follow           nix-dev-rebase-check     nix-dev-revision-latest
    nix-dev-patch            nix-dev-rebuild          nix-dev-unpack
    nix-dev-penv             nix-dev-rebuild-build    nix-dev-update


nix-dev-penv
------------
Usage:

    nix-dev-penv -A ATTR
    nix-dev-penv PACKAGE

Sets up package build environment in a new shell. nix-dev-patch can be used from that shell to generate
a patch showing the difference between original sources and modified ones.

nix-dev-revision-latest
-----------------------
Example:

    $ nix-dev-revision-latest 
    usage: nix-dev-revision-latest nixos|nixpkgs
    revision string: 1def5ba-48a4e91

    $ nix-dev-revision-latest  nixpkgs
    48a4e91

Shows latest stable commit, i.e. commit wich has a Hydra build associated.

nix-dev-update
--------------
Does many things:
* Updates nixos and nixpkgs from the origin/master
* Determines right commits in both repos to base upon
* Rebases 'local' branches in both repos upon new bases, saving current 'local' as 'local-$oldbase'

