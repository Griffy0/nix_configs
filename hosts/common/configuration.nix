# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, host, ... }:

{
  imports =
    [ 
      ../${host}/configuration.nix
      ../${host}/hardware-configuration.nix
      ../../modules/nixos/boilerplate.nix
      ../../modules/nixos/pipewire.nix
      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "${host}"; # Define your hostname.

  # Disable the X11 windowing system (Wayland FTW)
  services.xserver.enable = false;

  # zsh goog
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Add self
  users.users.anon = {
    isNormalUser = true;
    description = "anon";
    extraGroups = [ "networkmanager" "wheel" ];
    useDefaultShell = true;
    packages = [ pkgs.tree ];
  };

  home-manager = {
    # also pass inputs to home-manager modules
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users = {
      "anon".imports = [ 
        ./home.nix
        ../${host}/home.nix 
      ];
    };
  };
  
  # If we're booting hyprland
  specialisation.hyprland.configuration = {
    imports = [ 
      ../../modules/desktop_envs/hyprland/common/hyprland_nixos.nix 
    ];
    home-manager.users.anon.imports = [
      ../../modules/desktop_envs/hyprland/common/hyprland_home.nix
      ../../modules/desktop_envs/hyprland/${host}_hypr_home.nix
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
