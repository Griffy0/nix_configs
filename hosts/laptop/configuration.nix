# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,  ... }:

{
  # Enable AsusCtl
  services.asusd.enable = true;
  services.asusd.enableUserService = true;

  # Enable bluetooth
  services.blueman.enable = true;

  # Enable battery tracking for hyprpanel
  services.upower.enable = true;

  # Prevent Intel overheating
  services.thermald.enable = true;

  # Enable the GDM display manager
  services.displayManager.gdm.enable = true;

  # Add a video driver to please the Hypr gods
  services.xserver.videoDrivers = [ "intel" ];
}
