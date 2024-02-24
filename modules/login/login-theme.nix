{ pkgs }:

let
  image = pkgs.fetchurl {
    url = "https://wallhalla.com/wallpaper/61/variant/desktop/2560x1440?dl=true";
    sha256 = "sha256-MsplpBrgJRNnX7rh6NdwZnVtED5/yP5D073GlMrjdig=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
    rm theme.conf
    cp -r ${./theme.conf} $out/theme.conf
   '';
}