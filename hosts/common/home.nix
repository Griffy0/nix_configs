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
    ../../modules/home-manager/spotify.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/dev.nix
  ];

  # These don't have any better way to import
  home.packages = with pkgs; [
    signal-desktop # Signal messager
    wineWowPackages.waylandFull # Windows compatibility stuff
    htop # Performance viewer
  ];

  # Custom arguments for when launched with wofi, force Spotify and Signal to use Wayland
  xdg.desktopEntries = {
    signal = {
      name = "Signal";
      type = "Application";
      exec = "signal-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
    firefox = {
      name = "Firefox";
      type = "Application";
      exec = "firefox --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
    librewolf = {
      name = "Librewolf";
      type = "Application";
      exec = "librewolf --enable-features=UseOzonePlatform --ozone-platform=wayland";
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
    enable = true;
    initExtra = ''
      hyfetch
    '';
  };

  # The Bash Killer
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    initContent = ''
      alias nix-shell='nix-shell --run $SHELL'
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
