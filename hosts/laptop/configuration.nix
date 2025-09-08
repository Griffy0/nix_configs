# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,  ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/nixos/boilerplate.nix
      ../../modules/desktop_envs/gnome/gnome_nixos.nix
      ../../modules/desktop_envs/hyprland/common/hyprland_nixos.nix
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
      "anon" = import ./home.nix;
    };
  };

  system.stateVersion = "25.05";
}
