NixOS environment
=================

This folder contains configuration files for my [NixOS](http://www.nixos.org) systems.

Deploying
---------

    $ git clone https://github.com/ierton/nixrc && cd nixrc

    $ git clone https://github.com/NixOS/nixpkgs

    $ git clone https://github.com/NixOS/nixos

    $ ./env

    $ help
    ttest            Runs nixos-rebuil dry-run
    tswitch          Runs nixos-rebuild switch
    trev             Pulls revision from nixos channel
    tgitpull                 Pulls git trees and the Manifest
    pfetch           Fetches a package by name (as written in all-packages.nix)
    punpack          Unpacks the tarball to the current dir
    penv             Sets up build environment (needs aunpack package)


