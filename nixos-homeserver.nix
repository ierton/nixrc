# the system.  Help is available in the configuration.nix(5) man page
# or the NixOS manual available on virtual console 8 (Alt+F8).

{ config, pkgs, ... }:

{
  require = [
      /etc/nixos/hardware-configuration.nix
      ./inc/haskell_7_6.nix
      ./inc/devenv.nix
    ];

  hardware.firmware = [ "/root/firmware" ];

  boot.initrd.kernelModules = [ ];

  boot.blacklistedKernelModules = [ "fbcon" ];

  # boot.kernelPackages = pkgs.linuxPackages_3_5;
  boot.kernelPackages = pkgs.linuxPackages;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  # Europe/Moscow
  time.timeZone = "Etc/GMT-4";

  networking = {
    hostName = "goodfellow";
    interfaceMonitor.enable = false;
    useDHCP = true;
    #interfaces = {
    #  enp0s7 = {
    #    ipAddress = "192.168.1.20";
    #    subnetMask = "255.255.255.0";
    #  };
    #};

    #firewall = {
    #  allowedTCPPorts = [ 80 22 2222 ];
    #  allowPing = true;
    #};
  };

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/disk/by-label/ROOT_NIXOS";
      options = "defaults,relatime";
    }
    { mountPoint = "/boot";
      device = "/dev/sdb5";
      options = "defaults,relatime";
    }
    { mountPoint = "/home";
      device = "/dev/sdb7";
      options = "defaults,relatime";
    }
  ];

  swapDevices = [
    { device = "/dev/sdb1"; }
  ];

  powerManagement = {
    enable = true;
  };

  security = {
    sudo.configFile =
      ''
        # Don't edit this file. Set nixos option security.sudo.configFile instead
        # env vars to keep for root and %wheel also if not explicitly set
        Defaults:root,%wheel env_keep+=LOCALE_ARCHIVE
        Defaults:root,%wheel env_keep+=NIX_PATH
        Defaults:root,%wheel env_keep+=TERMINFO_DIRS

        # "root" is allowed to do anything.
        root        ALL=(ALL) SETENV: ALL

        # Users in the "wheel" group can do anything.
        %wheel      ALL=(ALL) SETENV: NOPASSWD: ALL
      '';
  };

  # services.cron = {
  #   systemCronJobs = [
  #     "* * * * * test ls -l / > /tmp/cronout 2>&1"
  #   ];
  # };

  services.ntp = {
    enable = true;
    servers = [ "server.local" "0.pool.ntp.org" "1.pool.ntp.org" "2.pool.ntp.org" ];
  };

  services.openssh = {
    enable = true;
    ports = [22 2222];
    permitRootLogin = "yes";
  };

  services.xserver = {
    enable = false;
  };

  # services.postfix = {
  #   enable = true;
  #   setSendmail = true;
  #   # Thanks to http://rs20.mine.nu/w/2011/07/gmail-as-relay-host-in-postfix/
  #   extraConfig = ''
  #     relayhost=[smtp.gmail.com]:587
  #     smtp_use_tls=yes */
  #     smtp_tls_CAfile=/etc/ssl/certs/ca-bundle.crt
  #     smtp_sasl_auth_enable=yes
  #     smtp_sasl_password_maps=hash:/etc/postfix.local/sasl_passwd
  #     smtp_sasl_security_options=noanonymous
  #   '';
  # };

  # services.acpid = {
  #   enable = true;
  # };

  users.extraUsers = {
    grwlf = {
      uid = 1000;
      group = "users";
      extraGroups = ["wheel"];
      home = "/home/ierton";
      isSystemUser = false;
      useDefaultShell = true;
    };
  };

  #environment.pathsToLink = ["/"];

  environment.systemPackages = with pkgs ; [
    # Basic tools
    psmisc
    iptables
    nmap
    tcpdump
    pmutils
    file
    cpufrequtils
    zip
    unzip
    unrar
    p7zip
    openssl
    cacert
    w3m
    wget
    screen
    fuse
    bashCompletion
    tftp_hpa
    rpm
    atool
    vim
    gitFull

    # Custom stuff
    haskell_7_6
    (devenv {})
  ];
}


