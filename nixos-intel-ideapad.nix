## FIXME: this file is quite old and not supported

{config, pkgs, ...}:

{
  require = [
    # Include the configuration for part of your system which have been
    # detected automatically.
    /etc/nixos/hardware-configuration.nix
  ];

  #boot.kernelPackages = pkgs.linuxPackages_3_0;

  boot.blacklistedKernelModules = [
    "pcspkr"
    "wimax"
    "i2400m"
    "i2400m_usb"
    ];

  boot.initrd.kernelModules = [
    # Specify all kernel modules that are necessary for mounting the root
    # file system.
    "uhci_hcd" "ehci_hcd" "ahci"
  ];

  boot.kernelModules = [
    "acpi-cpufreq" "configs"
  ];

  boot.extraModprobeConfig = ''
    options snd-hda-intel model="ideapad"
  '';

  boot.extraKernelParams = ["nohpet"];

  boot.loader.grub = {
    # Use grub 2 as boot loader.
    enable = true;
    version = 2;
    configurationLimit = 10;

    # Define on which hard drive you want to install Grub.
    device = "/dev/sda";

    extraEntries = ''
      menuentry "Gentoo Linux 3.0.0" {
        linux /boot/vmlinuz-3.0.0-gentoo-hm20
      }
      '';
  };

  # Europe/Moscow
  time.timeZone = "Etc/GMT-4";

  networking = {
    hostName = "pokemon";
    interfaceMonitor.enable = false;
    wireless.enable = false;
    useDHCP = false;
    wicd.enable = true;
  };

  security = {
    #sudo.configFile = "root ALL=(ALL) SETENV: ALL\n%wheel ALL=(ALL) SETENV: NOPASSWD: ALL\n";
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

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/sda7";
    }

    { mountPoint = "/boot";
      device = "/dev/sda2";
    }

    { mountPoint = "/home";
      device = "/dev/sda6";
    }

    { mountPoint = "/mnt/gentoo";
      device = "/dev/sda5";
    }
  ];

  swapDevices = [
    # List swap partitions that are mounted at boot time.
    { device = "/dev/sda1"; }
  ];

  powerManagement = {
    enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  services.nixosManual.showManual = false;

  # Add an OpenSSH daemon.
  services.openssh.enable = true;

  # Add CUPS to print documents.
  services.printing.enable = true;

  services.ntp = {
    enable = true;
    servers = [ "server.local" "0.pool.ntp.org" "1.pool.ntp.org" "2.pool.ntp.org" ];
  };

  # Add XServer (default if you have used a graphical iso)
  services.xserver = {
    enable = true;
    layout = "us,ru";
    xkbOptions = "eurosign:e, grp:alt_space_toggle, ctrl:swapcaps, grp_led:caps, ctrl:nocaps";
    # windowManager.xmonad.enable = true;
    # windowManager.default = "xmonad";
    exportConfiguration = true;
    # multitouch.enable = true; Doesn't work
    startOpenSSHAgent = true;
    synaptics = {
      enable = true;
      twoFingerScroll = false;
      additionalOptions = ''
        Option "LBCornerButton" "2"
        Option "LTCornerButton" "3"
        '';
    };

    desktopManager.xfce.enable = true;

    displayManager = {

      slim = {
        enable = true;
        defaultUser = "ierton";
      };

      #job.logsXsession = true; Doesn't work

    };

    videoDrivers = [ "intel" "vesa" ];
  };

  services.postfix = {
    enable = true;
    setSendmail = true;
    # Thanks to http://rs20.mine.nu/w/2011/07/gmail-as-relay-host-in-postfix/
    extraConfig = ''
      relayhost=[smtp.gmail.com]:587
      smtp_use_tls=yes
      smtp_tls_CAfile=/etc/ssl/certs/ca-bundle.crt
      smtp_sasl_auth_enable=yes
      smtp_sasl_password_maps=hash:/etc/postfix.local/sasl_passwd
      smtp_sasl_security_options=noanonymous
    '';
  };

  fonts = {
    enableFontDir = true;
    enableCoreFonts = true;
    enableGhostscriptFonts = true;
    extraFonts = with pkgs ; [
      liberation_ttf
      ttf_bitstream_vera
      dejavu_fonts
      terminus_font
      bakoma_ttf
      clearlyU
      cm_unicode
      andagii
      bakoma_ttf
    ];
  };

  environment.pathsToLink = ["/"];

  environment.systemPackages = with pkgs ; [
    # Basic tools
    psmisc
    iptables
    dhcp
    nmap
    tcpdump
    pmutils
    acpid
    acpitool
    cpufrequtils
    zip
    unzip
    unrar
    openssl
    cacert
    w3m
    wget
    screen
    mutt
    fuse
    bashCompletion
    irssi
    mpg321
    catdoc
    graphviz
    tig
    enca
    #apcupsd
    tftp_hpa
    unetbootin

    # X11 apps
    gitAndTools.gitFull
    subversion
    ctags
    mc
    rxvt_unicode
    vimHugeX
    #chromeWrapper
    firefoxWrapper
    glxinfo
    feh
    xcompmgr
    zathura
    evince
    xneur
    MPlayer
    unclutter
    trayer
    xorg.xdpyinfo
    xlibs.xev
    xfontsel
    xlsfonts
    djvulibre
    ghostscript
    djview4
    #conky
    #dzen2
    #dmenu
    hicolor_icon_theme
    oxygen_gtk
    skype_linux
    cairoclock
    tightvnc
    thunderbird
    wine
    xfce.xarchiver
    vlc
    easytag
    gqview
    #gimp_2_8
    libreoffice
    #gimpPlugins
    #gnome_mplayer
    #abiword
    #linuxPackages.virtualbox
    #linuxPackages.virtualboxGuestAdditions
    #impressive
    #pianobooster
    pidgin
    vimprobable2Wrapper

    devenv

    (pkgs.haskellPackages.ghcWithPackages (self : [
        self.haskellPlatform
        self.happstackServer
        self.happstackHamlet
        self.happstackUtil
        self.cabalInstall
    ]))
  ];

  nixpkgs.config = {
    chrome.enableRealPlayer = true;
    chrome.jre = true;
    firefox.enableRealPlayer = true;
    firefox.jre = true;
    #subversion.saslSupport = false; #true;
    #freetype.useEncumberedCode = false; # true;
    packageOverrides = pkgs: {
      libass = pkgs.libass.override {
        enca = null;
      };

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
          zlib
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
      };
    };
  };
}

# vim: expandtab : tabstop=2 : autoindent :
