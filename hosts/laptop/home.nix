{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "anon";
  home.homeDirectory = "/home/anon";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  imports = [
    ../../modules/home-manager/hyfetch.nix
    ../../modules/home-manager/vesktop.nix
#    ../../modules/home-manager/kitty.nix
#    ../../modules/home-manager/dunst.nix
    #../../modules/home-manager/flameshot.nix
    ../../modules/desktop_envs/gnome_home.nix
    ../../modules/desktop_envs/hyprland_home.nix
  ];
  home.packages = [
    pkgs.signal-desktop
    pkgs.spotify
    pkgs.spotify-cli-linux
    pkgs.brightnessctl  # Allow monitor brightness ctrl
  ];

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


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  programs.firefox = {
    enable = true;
  };

  programs.kitty = {
    enable = true;
    extraConfig = "background_opacity 0.1";
  };
  
  programs.bash = {
    enable = true;
    initExtra = ''
      alias spotify="spotify --enable-features=UseOzonePlatform --ozone-platform=wayland"
      hyfetch
    '';
  };
  programs.git.enable = true;
  services.blueman-applet.enable = true;
#  programs.nvf.enable = true;
  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/anon/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
