{ config, pkgs, ... }:
{
  # These don't have any better way to import
  home.packages = [
    pkgs.brightnessctl  # Allow monitor brightness ctrl
  ];

  # Enable the other half of Bluetooth
  services.blueman-applet.enable = true;
}
