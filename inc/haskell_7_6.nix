{ config, pkgs, ... } :

let 

  haskbase = self : [
    self.haskellPlatform
    self.cabalInstall
  ];

in {

  nixpkgs.config = {

    packageOverrides = pkgs: {

      haskell_7_6 = (pkgs.haskellPackages_ghc762.ghcWithPackages haskbase);

    };
  };
}

