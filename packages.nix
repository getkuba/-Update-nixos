{ pkgs, ... }:

{
  config.environment.systemPackages = with pkgs; [
    #(import (fetchTarball "channel:nixos-unstable") {}).neomutt
    # acetoneiso
    acpilight
    appimage-run
    arc-theme
    aria2
    autossh
    beets
    bibletime
    xiphos
    flexget
    blender
    bluez
    borgbackup
    cdrdao
    gnome3.cheese
    gnome3.adwaita-icon-theme
    chromaprint
    clamav
    claws-mail
    curl
    curlftpfs
    dia
    docker
    dhex
    dnsutils
    dunst

    ## AUDIO PRODUCTION
    ardour
    audacity
    # goattracker
    helm
    lmms
    milkytracker
    reaper
    # renoise
    schismtracker
    # sunvox
    timidity

    ## BROWSERS
    brave
    browsh
    (import (fetchTarball "channel:nixos-unstable") {}).ungoogled-chromium
    firefox
    netsurf.browser
    palemoon
    torbrowser
    w3m

    ## CRYPTOCURRENCY 
    cointop
    cryptop
    electron-cash
    go-ethereum
    wasabiwallet

    ## DESIGN
    grafx2
    krita
    inkscape

    ## DEV
    gnumake
    gcc

    ## DEV/PYTHON
    python3Full

    ## DEV/SHADERS
    bonzomatic
    kodelife

    ## DEV/SMALLTALK
    pharo
    pharo-launcher
    squeak

    ## DICTIONARIES
    aspellDicts.en 
    aspellDicts.en-computers
    aspellDicts.en-science
    goldendict
    hunspell
    hunspellDicts.en_US-large
    hunspellDicts.en_GB-large 
    wordnet

    ## EMULATORS
    # basilisk2
    dosbox
    fsuae
    hatari
    munt
    openmsx
    qemu
    retroarch
    stella
    vice

    ## FILESHARING
    amule
    eiskaltdcpp
    ipfs
    magic-wormhole
    nicotine-plus
    # onionshare
    # retroshare
    transmission-gtk
    tribler

    ## FILESYSTEM
    btrfs-progs
    dosfstools
    hfsprogs

    ## GAMES
    armagetronad
    cataclysm-dda
    devilutionx
    dwarf-fortress
    exult
    frotz
    ioquake3
    minetest
    mudlet
    nxengine-evo
    openrct2
    openttd
    scummvm

    ## i3
    i3lock
    i3status
    i3status-rust

    ## LAUNCHERS
    kupfer
    rofi

    ## MEDIA PLAYERS / VIEWERS
    clementine
    cmus
    deadbeef
    kodi
    mcomix
    mpg123
    python37Packages.mps-youtube
    moc
    mpv-with-scripts
    mupdf
    pianobar
    uade123
    viewnior
    xmp

    ## SOCIAL
    irssi
    mumble
    neomutt
    patchwork-classic
    pidgin-with-plugins
    qtox
    rtv
    tdesktop
    thunderbird
    weechat
    (import (fetchTarball "channel:nixos-unstable") {}).wire-desktop

    exfat
    f2fs-tools
    f3
    fbreader
    feedreader
    filezilla
    ffmpeg
    figlet
    flac
    flexget
    fuseiso
    ghostwriter
    git
    (import (fetchTarball "channel:nixos-unstable") {}).go
    gobby
    godot
    googleearth
    gparted
    gsettings-desktop-schemas
    guvcview
    handbrake
    htop
    imagemagick
    iotop
    # jotmuch
    keepassx
    khal
    khard
    killall
    lame
    less
    lftp
    libreoffice
    liferea
    # lrzsc
    lsof
    lxappearance
    mailcap
    meson
    mosh
    mudlet
    multibootusb
    neofetch
    networkmanagerapplet
    newsboat
    nfs-utils
    ninja
    nmap
    ntp
    numix-icon-theme
    numix-icon-theme-square
    obfs4
    onioncircuits
    p7zip
    parcellite
    picard
    pinentry
    pirate-get
    playerctl
    proxychains
    puredata
    pv
    qalculate-gtk
    qtchan
    ranger
    rsync
    rxvt_unicode
    screen
    scrot
    socat
    sox
    sshfs
    stellarium
    # tcpser
    telnet
    tig
    torsocks
    traceroute
    tree
    unrar
    vifm
    vim
    vlc
    wget
    wineWowPackages.full
    winetricks
    wireshark
    # wondershaper
    xboxdrv
    xorg.xinit
    xss-lock
    (import (fetchTarball "channel:nixos-unstable") {}).youtube-dl
    zsh
  ];
}
