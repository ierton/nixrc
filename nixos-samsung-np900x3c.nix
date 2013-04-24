# the system.  Help is available in the configuration.nix(5) man page
# or the NixOS manual available on virtual console 8 (Alt+F8).

{ config, pkgs, ... }:

rec {
  require = [
      /etc/nixos/hardware-configuration.nix
      ./inc/devenv.nix
      ./inc/subpixel.nix
      ./inc/haskell_7_6.nix
    ];

  hardware.firmware = [ "/root/firmware" ];

  hardware.bluetooth.enable = false;

  # Specify all kernel modules that are necessary for mounting the root
  # filesystem.
  boot.initrd.kernelModules = [ ];

  boot.blacklistedKernelModules = [
    "fbcon"
    ];

  boot.extraKernelParams = [
    # Use better scheduler for SSD drive
    "elevator=noop"
    ];

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
    hostName = "greyblade";

    interfaceMonitor.enable = false;
    wireless.enable = false;
    useDHCP = false;
    wicd.enable = true;
    # networkmanager.enable = true;
  };

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/disk/by-label/ROOT";
      options = "defaults,relatime,discard";
    }
    { mountPoint = "/boot";
      device = "/dev/disk/by-label/BOOT";
      options = "defaults,relatime";
    }
    { mountPoint = "/home";
      device = "/dev/disk/by-label/HOME";
      options = "defaults,relatime,discard";
    }
  ];

  swapDevices = [
    # { device = "/dev/disk/by-label/SWAP"; }
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
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  
  services.dbus.packages = [ pkgs.gnome.GConf ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    videoDrivers = [ "intel" ];

    layout = "us,ru";

    xkbOptions = "eurosign:e, grp:alt_space_toggle, ctrl:swapcaps, grp_led:caps, ctrl:nocaps";

    desktopManager.xfce.enable = true;

    displayManager = {
      # job.logsXsession = true;
      slim = {
        enable = true;
        defaultUser = "ierton";
      };
    };

    multitouch.enable = false;

    synaptics = {
      enable = true;
      accelFactor = "0.05";
      maxSpeed = "10";
      twoFingerScroll = true;
      additionalOptions =
        ''
        MatchProduct "ETPS"
        Option "FingerLow"                 "3"
        Option "FingerHigh"                "5"
        Option "FingerPress"               "30"
        Option "MaxTapTime"                "100"
        Option "MaxDoubleTapTime"          "150"
        Option "FastTaps"                  "0"
        Option "VertTwoFingerScroll"       "1"
        Option "HorizTwoFingerScroll"      "1"
        Option "TrackstickSpeed"           "0"
        Option "LTCornerButton"            "3"
        Option "LBCornerButton"            "2"
        Option "CoastingFriction"          "20"
        '';
      };
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

  fonts = {
    enableFontConfig = true;
    enableFontDir = true;
    enableCoreFonts = true;
    enableGhostscriptFonts = true;
    extraFonts = with pkgs ; [
      liberation_ttf
      ttf_bitstream_vera
      dejavu_fonts
      terminus_font
      bakoma_ttf
      bakoma_ttf
      ubuntu_font_family
      vistafonts
      unifont
      freefont_ttf
    ];
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
    mpg321
    catdoc
    # graphviz
    tftp_hpa
    # unetbootin
    rpm
    atool

    # X11 apps
    xorg.xdpyinfo
    xorg.xinput
    gitAndTools.gitFull
    subversion
    ctags
    mc
    rxvt_unicode
    vimHugeX
    firefoxWrapper
    glxinfo
    feh
    xcompmgr
    zathura
    evince
    xneur
    gxneur
    mplayer
    xlibs.xev
    xfontsel
    xlsfonts
    djvulibre
    ghostscript
    djview4
    tightvnc
    wine
    xfce.xfce4_cpufreq_plugin
    xfce.xfce4_systemload_plugin
    xfce.gigolo
    xfce.xfce4taskmanager
    vlc
    easytag
    libreoffice
    pidgin
    gimp_2_8
    skype
    dosbox

    # Custom stuff
    haskell_7_6
    (devenv {
      enableCross = true;
      enableX11 = services.xserver.enable;
    })
    freetype_subpixel

  ];

  nixpkgs.config = {
    chrome.jre = true;
    firefox.jre = true;
  };
}

