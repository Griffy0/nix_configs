{ config, pkgs, ... }:
{
  # These don't have any better way to import
  home.packages = [
    pkgs.brightnessctl  # Allow monitor brightness ctrl
    pkgs.wvkbd 
  ];

  imports = [
    ../../modules/home-manager/common_apps.nix
  ]

  # Enable the other half of Bluetooth
  services.blueman-applet.enable = true;
}
