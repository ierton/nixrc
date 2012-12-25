{ config, pkgs, ... } :

let 

  haskbase = self : [
    self.haskellPlatform
    self.cabalInstall
  ];

in {

  nixpkgs.config = {

    packageOverrides = pkgs: {

      haskell_7_6 = (pkgs.haskellPackages_ghc761.ghcWithPackages haskbase);

    };
  };
}

