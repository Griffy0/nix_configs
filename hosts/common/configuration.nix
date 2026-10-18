# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, host, lib, ... }:

{
  imports =
    [ 
      ../../modules/nixos/boilerplate.nix
#      ../../modules/nixos/pipewire.nix
      inputs.home-manager.nixosModules.default
    ];

  # Don't save more than past 5 generations
#  boot.loader.systemd-boot.configurationLimit = 5;

  # Increase systemd wait time
#  boot.loader.timeout = 900;

  # zsh goog
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Add self
  users.users.anon = {
    isNormalUser = true;
    description = "anon";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    useDefaultShell = true;
    packages = [ pkgs.tree ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
  ];
   
  /*# If we're booting hyprland
  specialisation.hyprland.configuration = {
    imports = [ 
      ../../modules/desktop_envs/hyprland/common/hyprland_nixos.nix 
    ];
    home-manager.users.anon.imports = lib.optionals (builtins.pathExists ../../modules/desktop_envs/hyprland/${host}_hypr_home.nix) [
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
  };*/
}

