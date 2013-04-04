{ config, pkgs, ... } :
{
  nixpkgs.config = {

    packageOverrides = pkgs: {
      stdenv = pkgs.stdenv // {
        platform = pkgs.stdenv.platform // {
          kernelExtraConfig = "PPP_FILTER y" ;
        };
      }; 
    };
  };
}
