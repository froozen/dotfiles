{ config, pkgs, ... }:

{

  networking.hostName = "reisekoffer";
  networking.hostId = "50754a4a";

  networking.wireless.enable = true;
  networking.wireless.interfaces = [ "wlp18s0" ];
  networking.wireless.userControlled.enable = true;

  services.xserver.synaptics.enable = true;

}
