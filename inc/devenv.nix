{ config, pkgs, ... } :

{

  nixpkgs.config = {

    packageOverrides = pkgs: {

      devenv = { enableCross ? false , enableX11 ? false } : let

        common = with pkgs; [
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
          m4
          perlPackages.LWP
        ];

        x11 = with pkgs ; [
          freetype
          fontconfig
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
        ];

        cross = with pkgs; [
          i386_toolchain.gcc
          i386_toolchain.binutils
          i386_toolchain.gdb
          arm_toolchain.gcc
          arm_toolchain.binutils
          arm_toolchain.gdb
        ];

        in pkgs.myEnvFun {
          name = "dev";

          buildInputs = with pkgs.stdenv.lib; common
            ++ optionals enableX11 x11
            ++ optionals enableCross cross;

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
