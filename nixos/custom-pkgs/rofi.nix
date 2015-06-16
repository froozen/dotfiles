{ pkgs, ... }:
# Thanks @shak-mar for writing this expression
pkgs.stdenv.mkDerivation rec {
  version = "0.15.5";
  name = "rofi-${version}";
  src = pkgs.fetchurl {
    url = "https://github.com/DaveDavenport/rofi/releases/download/${version}/rofi-${version}.tar.gz";
    sha256 = "79f3dee627f3b1a602638988d2e200be805ff326f9e4d592d7d01585b214fc3a";
  };
  buildInputs = with pkgs; [
    xlibs.libXinerama
    xlibs.libXft
    gnome.pango
    xlibs.libX11
    pkgconfig
  ];
}
