NixOS environment
=================

This folder contains configuration files for my [NixOS](http://www.nixos.org) systems as well as 
nixrc script containing some usefull functions for NixOS development.

Deploying
---------

Deploying is not fully automatic so you probably will have to watch inside ./nixrc to find out
the details.

    $ git clone https://github.com/ierton/nixrc && cd nixrc

    $ git clone https://github.com/NixOS/nixpkgs

    $ git clone https://github.com/NixOS/nixos
    
    $ echo export NIX_DEV_ROOT=`pwd` >> ~/.bash_profile

    $ . ./nixrc
    
    [ierton@greyblade:~]$ nix-dev-
    nix-dev-asroot           nix-dev-pfetch           nix-dev-rebuild-dryrun
    nix-dev-attr-by-name     nix-dev-pfetch-by-attr   nix-dev-rebuild-switch
    nix-dev-fetch            nix-dev-rebase           nix-dev-revision
    nix-dev-follow           nix-dev-rebase-check     nix-dev-revision-latest
    nix-dev-patch            nix-dev-rebuild          nix-dev-unpack
    nix-dev-penv             nix-dev-rebuild-build    nix-dev-update

nixrc
=====

nix-dev-penv
------------
Usage
nix-dev-penv -A ATTR
nix-dev-penv PACKAGE

Sets up package build environment in a new shell.

nix-dev-revision-latest
-----------------------
Determines latest commits for which the system was built by Hydra successfully.
