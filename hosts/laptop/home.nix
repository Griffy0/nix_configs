{ config, pkgs, ... }:

{
  # Boiler-plate
  home.username = "anon";
  home.homeDirectory = "/home/anon";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Install stuff without GNU
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Bring in apps and desktop environments
  imports = [
    ../../modules/home-manager/hyfetch.nix
    ../../modules/home-manager/vesktop.nix
    ../../modules/home-manager/nvf.nix
  ];

  # These don't have any better way to import
  home.packages = [
    pkgs.signal-desktop
    pkgs.spotify
    pkgs.spotify-cli-linux
    pkgs.brightnessctl  # Allow monitor brightness ctrl
  ];

  # Custom arguments for when launched with wofi, force Spotify and Signal to use Wayland
  xdg.desktopEntries = {
    spotify = {
      name = "Spotify";
      type = "Application";
      exec = "spotify --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
    signal = {
      name = "Signal";
      type = "Application";
      exec = "signal-desktop --password-store=\"gnome-libsecret\" --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
  };

  # Enable firefox
  programs.firefox = {
    enable = true;
  };

  # Enable kitty, with transperancy
  programs.kitty = {
    enable = true;
    extraConfig = ''
      background_opacity 0.1
      window_padding_width 6
    '';
  };
  
  # Disable bash, keep in case of issues with zsh
  programs.bash = {
    enable = false;
    initExtra = ''
      hyfetch
    '';
  };

  # The Bash Killer
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    initContent = "hyfetch";
  };

  # Git
  programs.git.enable = true;

  # Enable the other half of Bluetooth
  services.blueman-applet.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
