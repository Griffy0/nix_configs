{ inputs, pkgs, ... }:
{
  home.packages = [
    pkgs.spotify
    pkgs.spotify-cli-linux
    pkgs.spotify-player
  ];
  /*xdg.desktopEntries = {
    spotify = {
      name = "Spotify";
      type = "Application";
      exec = "spotify --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
  };

  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
  };*/
}
