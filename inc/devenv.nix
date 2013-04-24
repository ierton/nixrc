{ config, pkgs, ... } :

{

  nixpkgs.config = {

    packageOverrides = pkgs: {

      devenv = pkgs.myEnvFun {
        name = "dev";

        buildInputs = with pkgs; [
          autoconf
          automake
          gettext
          intltool
          libtool
          pkgconfig
          perl
          curl
          sqlite
          cmake
          python
          ncurses
          curl
          zlib
          patchelf
        ];

        # myEnv sets this variables to unreal values to prevent wget
        # from installing anything. I often need cabal to install this or that
        # from within devenv, so let's help wget
        extraCmds = ''
          unset http_proxy
          unset https_proxy
        '';
      };
    };
  };

}
