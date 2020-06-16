{ config, options, pkgs, lib, prelude, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./vlan.nix
      # <musnix>
    ];

  boot = {
    cleanTmpDir = true;
    consoleLogLevel = 0;
    initrd.luks.devices = [
      {
        name = "root";
        device = "/dev/disk/by-uuid/10108aab-5301-459a-9786-256d4c59489a";
        preLVM = true;
      }
    ];
    kernel.sysctl = { "vm.swappiness" = 0;};
    kernelParams = [ "quiet" ];
    loader.grub.device = "/dev/disk/by-uuid/418E-F9C6";
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = false;
    plymouth.enable = true;
    tmpOnTmpfs = true;
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "30   1-22/3  * * *     x     . /etc/profile; /home/x/bin/flexcron"
      "0    2       * * *     root  . /etc/profile; /root/backup-root.sh"
    ];
  };

  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  fileSystems."/media/backup_sd" =
    { device = "/dev/disk/by-uuid/933847c8-38a4-4333-aa83-2e2a54d15b39"	;
      fsType = "btrfs";
      options = [ "nofail" "rw" "user" "exec" ];
    };

  fileSystems."/media/warez.stix" = # this should be automated :<
    { device = "stix.symbolics.local:/mnt/storage/share";
      fsType = "nfs";
      options = [ "udp" "noauto" "ro" "hard" "x-systemd.automount" ];
    };

  fileSystems."/media/wd_dymaxion" =
    { device = "/dev/disk/by-uuid/b0a25592-234b-4bf4-bead-080ca309ba88"	;
      fsType = "ext4";
      options = [ "nofail" "rw" "user" "exec" ];
    };

  fonts.fonts = with pkgs; [
    dejavu_fonts
    font-awesome
    ibm-plex
    lato
    liberation_ttf
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    symbola
    terminus_font
  ];

  hardware.acpilight.enable = true;
  hardware.brightnessctl.enable = true;
  hardware.enableAllFirmware = true;

  hardware.opengl = {
    driSupport32Bit = true;
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
    ];
  };

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # musnix = {
  #   enable = false;
  #   kernel.optimize = false;
  # };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  networking = {
    enableIPv6 = false;
    firewall.trustedInterfaces = [ "wg-toad" ];
    hostName = "nixxy";
    interfaces.wlo1.useDHCP = true;
    nameservers = [ "208.67.222.222" "1.1.1.1" "208.67.220.220" "8.8.8.8" ];
    networkmanager.enable = true;
    proxy.default = "http://127.0.0.1:8118/";
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    useDHCP = false;
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      mpv-with-scripts = pkgs.mpv-with-scripts.override {
        scripts = [ pkgs.mpvScripts.mpris ];
      };
      pidgin-with-plugins = pkgs.pidgin-with-plugins.override {
        plugins = [ pkgs.pidginotr pkgs.telegram-purple pkgs.toxprpl pkgs.pidgin-window-merge ];
      };
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true;
      };
    };
  };

  nixpkgs.overlays = [(self: super: {
    gobby = super.gobby5.override { avahiSupport = true; };
  })];

  programs.dconf.enable = true;

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = [
    (lib.stringAsChars
     (c: if c == ":" then "#" else c)
      config.services.tor.client.dns.listenAddress)];
  services.dnsmasq.extraConfig = ''
    no-resolv
    domain-needed
    bogus-priv
    cache-size=1000
    conf-file=${pkgs.dnsmasq}/share/dnsmasq/trust-anchors.conf
    proxy-dnssec
    listen-address=127.0.0.1
    bind-interfaces
    server=/toad.invalid/10.23.23.1#53
    server=/23.23.10.in-addr.arpa/10.23.23.1#53
  '';

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  programs = {
    firejail.enable = false;
    gnupg.agent = { enable = true; enableSSHSupport = true; };
    qt5ct.enable = true;
    xss-lock.enable = true;
    xss-lock.lockerCommand = "${pkgs.i3lock}/bin/i3lock -c 000000";
  };

  qt5 = {
    style = "gtk2";
    platformTheme = "gtk2";
  };

  sound.enable = true;

  security.pam.enableEcryptfs = true;

  # services.btrfs.autoScrub.enable = true;
  # services.btrfs.autoScrub.interval = "monthly";

  services.clamav.daemon.enable = false;
  services.clamav.updater.enable = true;
  services.freenet.enable = false;
  services.gnome3.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.i2p.enable = false;

  # services.jack = {
  #   jackd.enable = true;
  #   # support ALSA only programs via ALSA JACK PCM plugin
  #   alsa.enable = false;
  #   # support ALSA only programs via loopback device (supports programs like Steam)
  #   loopback = {
  #     enable = true;
  #     # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
  #     dmixConfig = ''
  #       period_size 2048
  #     '';
  #   };
  # };

  services.journald.extraConfig = ''
    Storage=none
    '';
  services.nixosManual.showManual = false;
  services.openssh.enable = false;
  services.printing.enable = false;
  services.privoxy.extraConfig =  ''
    forward-socks4 / ${config.services.tor.client.socksListenAddressFaster} .
    forward-socks4a / ${config.services.tor.client.socksListenAddressFaster} .
    forward-socks5 / ${config.services.tor.client.socksListenAddressFaster} .
    forward-socks5t / ${config.services.tor.client.socksListenAddressFaster} .
    '';
  services.syncthing.enable = true;
  services.syncthing.systemService = false;
  services.syncthing.user = "x";
  services.tlp.enable = true;
  services.tor.client.dns.enable = true;
  services.tor.client.dns.listenAddress = "127.0.0.1:5354";
  services.tor.client.enable = true;
  services.tor.enable = true;
  services.xserver.autorun = true;
  services.xserver.enable = true;
  services.xserver.displayManager.auto.enable = true;
  services.xserver.displayManager.auto.user = "x";
  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.layout = "us";
  services.xserver.libinput.disableWhileTyping = true;
  services.xserver.libinput.enable = true;
  services.xserver.libinput.naturalScrolling = true;
  services.xserver.windowManager.default = "i3";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.xautolock.enable = true;
  services.xserver.xautolock.locker = "${pkgs.i3lock}/bin/i3lock";
  services.xserver.xkbOptions = "eurosign:e";
  services.zeronet.enable = false;
  services.zeronet.tor = true;
  services.zeronet.torAlways = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09";

  time.timeZone = "Asia/Bangkok";

  users.users.x = {
    name = "x";
    extraGroups = [ "audio" "video" "wheel" ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  virtualisation.anbox.enable = false;
  virtualisation.virtualbox.host.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    priority = 10;
  };

}
