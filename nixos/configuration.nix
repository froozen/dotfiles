{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      # ./machines/machine.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  i18n = { consoleKeyMap = "de"; };

  environment.systemPackages = with pkgs; [
    # Generally useful packcges
    git
    vimHugeX
    python2
    python3
    stow

    # WM and stuff used in its config
    dmenu
    haskellPackages.xmobar
    alock
    mpc_cli
    scrot
    libnotify
    acpi

    # Unfortunately, dust wont find my config file unless I do this
    (lib.overrideDerivation dunst (attrs: {
      name = "${attrs.name}-force-config";
      postInstall = ''
        sed -i "s/\\/dunst/\\/dunst -config \\/home\\/brotknust\\/.config\\/dunst\\/dunstrc/" $out/share/dbus-1/services/org.knopwob.dunst.service
      '';
    }))

    # Misc programs with a GUI
    firefoxWrapper

    # ncurses programs
    weechat

    # Terminal emulator
    rxvt_unicode
    urxvt_perls

    # Packages needed for haskell + vim fanciness
    haskellPackages.hdevtools
    haskellPackages.ghcMod
    haskellPackages.cabal2nix
    haskellPackages.hlint
  ];

  services.xserver.enable = true;
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "neo";

  services.xserver.windowManager.default = "xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.desktopManager.xterm.enable = false;

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
