{ config, lib, pkgs, inputs, ... }:
{
  imports =  [
    ./hardware-configuration.nix
    ../common/configuration.nix
  ];

  home-manager = {
    # also pass inputs to home-manager modules
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users = {
      "anon".imports = [ 
        ./home.nix
        ../common/home.nix 
      ];
    };
  };

  # Disable the X11 windowing system
  #services.xserver.enable = false;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;
  networking.hostName = "wsl";

#  boot.loader.systemd-boot.enable = false;

  virtualisation.docker.enable = true;
  users.users.anon.extraGroups = [ "docker" ];

  system.stateVersion = "26.05"; # Did you read the comment?
}

