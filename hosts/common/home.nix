{ config, pkgs, ... }:
{
  # Boiler-plate
  home.username = "anon";
  home.homeDirectory = "/home/anon";
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # Install stuff without GNU
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Bring in apps and desktop environments
  imports = [
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/nvf.nix
    ../../modules/home-manager/hyfetch.nix
    ../../modules/home-manager/tmux.nix
  ];

  # These don't have any better way to import
  home.packages = with pkgs; [
  #  wineWowPackages.waylandFull # Windows compatibility stuff
    htop # Performance viewer
  ];

  
  # Disable bash, keep in case of issues with zsh
  programs.bash = {
    enable = true;
    initExtra = ''
      hyfetch
    '';
  };

  # Git
  programs.git = {
    enable = true;
    userEmail = "jagriff007@gmail.com";
    userName = "Griffy0";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
