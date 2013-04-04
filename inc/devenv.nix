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
          qt4
          python
          glew
          mesa
          freetype
          fontconfig
          ncurses
          curl
          zlib
          opencv
          xlibs.xproto
          xlibs.libX11
          xlibs.libXt
          xlibs.libXft
          xlibs.libXext
          xlibs.libSM
          xlibs.libICE
          xlibs.xextproto
          xlibs.libXrender
          xlibs.renderproto
          xlibs.libxkbfile
          xlibs.kbproto
          xlibs.libXrandr
          xlibs.randrproto
          patchelf
          i386_toolchain.gcc
          i386_toolchain.binutils
          arm_toolchain.gcc
          arm_toolchain.binutils
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
