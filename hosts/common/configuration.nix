# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, host, ... }:

{
  imports =
    [ 
      ../laptop/configuration.nix
      ../laptop/hardware-configuration.nix
      ../../modules/nixos/boilerplate.nix
      ../../modules/nixos/pipewire.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "nixos"; # Define your hostname.

  # Enable AsusCtl
  services.asusd.enable = true;
  services.asusd.enableUserService = true;

  # Enable bluetooth
  services.blueman.enable = true;

  # Disable the X11 windowing system (Wayland FTW)
  services.xserver.enable = false;

  # Enable the GDM display manager
  services.displayManager.gdm.enable = true;

  # Add a video driver to please the Hypr gods
  services.xserver.videoDrivers = [ "intel" ];

  # zsh goog
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Add self
  users.users.anon = {
    isNormalUser = true;
    description = "anon";
    extraGroups = [ "networkmanager" "wheel" ];
    useDefaultShell = true;
  };

  home-manager = {
    # also pass inputs to home-manager modules
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users = {
      "anon" = import ../laptop/home.nix;
    };
  };
  
  # If we're booting hyprland
  specialisation.hyprland.configuration = {
    imports = [ 
      ../../modules/desktop_envs/hyprland/common/hyprland_nixos.nix 
    ];
    home-manager.users.anon.imports = [
      ../../modules/desktop_envs/hyprland/common/hyprland_home.nix
      ../../modules/desktop_envs/hyprland/laptop_hypr_home.nix
    ];
  };

  # If we're booting gnome instead
  specialisation.gnome.configuration = {
    imports = [ 
      ../../modules/desktop_envs/gnome/common/gnome_nixos.nix 
    ];
    home-manager.users.anon.imports = [
      ../../modules/desktop_envs/gnome/common/gnome_home.nix
    ];
  };

  system.stateVersion = "25.05";
}
