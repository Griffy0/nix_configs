# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,  ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/desktop_envs/hyprland/common/hyprland_nixos.nix   # Load Hyprland
  ];

  home-manager.users.anon.imports = [
    ../../modules/desktop_envs/hyprland/common/hyprland_home.nix  # Load Hyprland
    ../../modules/desktop_envs/hyprland/desktop_hypr_home.nix
    ../../hosts/common/home.nix
  ]

  # Add Win partition to systemd
  boot.loader.systemd-boot.extraEntries = {
    "windows.conf" = ''
        title Windows 11
        efi /EFI/Microsoft/Boot/bootmgfw.efi
        options root=UUID=1E30-F9BE
    '';
  };
  
  # Init hostname
  networking.hostName = "desktop";

  # Boot hyprland on startup
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "anon";
      };
    };
  };

  # Waste less power
  #services.power-profiles-daemon.enable = true;

  environment.systemPackages = [
    pkgs.efibootmgr
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  }; 
}
