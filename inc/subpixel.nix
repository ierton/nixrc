{ config, pkgs, ... } :
{

  nixpkgs.config = {

    packageOverrides = pkgs: {
      freetype_subpixel = pkgs.freetype.override {
        useEncumberedCode = true;
      };

    };
  };

}
