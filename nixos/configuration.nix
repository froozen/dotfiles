{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      # ./machines/machine.nix
      ./neo.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  nix.trustedBinaryCaches = [
    "http://hydra.nixos.org"
    "http://hydra.cryp.to"
  ];

  environment.systemPackages = with pkgs; [
    # Generally useful packcges
    git
    vimHugeX
    python2
    python3
    stow
    mpd
    tmux

    # Stuff for e-mail
    mutt
    isync
    msmtp
    gnupg
    gpgme
    pass

    # WM and stuff used in its config
    dmenu
    haskellPackages.xmobar
    alock
    mpc_cli
    scrot
    libnotify
    acpi
    redshift

    # Unfortunately, dust wont find my config file unless I do this
    (lib.overrideDerivation dunst (attrs: {
      name = "${attrs.name}-force-config";
      postInstall = ''
        sed -i "s/\\/dunst/\\/dunst -config \\/home\\/brotknust\\/.config\\/dunst\\/dunstrc/" $out/share/dbus-1/services/org.knopwob.dunst.service
      '';
    }))

    # Misc programs with a GUI
    firefoxWrapper
    thunderbird
    mpv
    termite
    pond

    # ncurses programs
    weechat


    # Packages needed for haskell + vim fanciness
    haskellPackages.hdevtools
    haskellPackages.cabal2nix
    haskellPackages.hlint

    # Custom avant-garde packages
    (import custom-pkgs/rofi.nix pkgs)
    ];

  time.timeZone = "Europe/Berlin";

  services.xserver.enable = true;
  services.xserver.windowManager.default = "xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.desktopManager.xterm.enable = false;

  services.tor.enable = true;
  services.tor.client.enable = true;
  services.tor.controlPort = 9051;

  services.redshift.enable = true;
  services.redshift.latitude = "48.1374";
  services.redshift.longitude = "11.5754";

  services.xserver.displayManager.sessionCommands = ''
    feh --bg-fill ~/.wallpaper &
    '';

  users.extraGroups.brotknust = {};
  users.extraUsers.brotknust = {
    isNormalUser = true;
    createHome = true;
    home = "/home/brotknust";
    group = "brotknust";
    extraGroups = [ "wheel" ];
  };

}
