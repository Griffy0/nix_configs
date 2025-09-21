# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,  ... }:

{
  imports = [ 
    ../../modules/nixos/nvidia.nix
  ];

  # Don't keep more than the last 5 nix builds
  boot.loader.systemd-boot.configurationLimit = 5;

  # Disable auto OS selection
  boot.loader.timeout = 900;

  # Add Win partition to systemd
  boot.loader.systemd-boot.extraEntries = {
    "windows.conf" = ''
        title Windows 11
        efi /EFI/Microsoft/Boot/bootmgfw.efi
        options root=UUID=1E30-F9BE
    '';
  };
  
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
