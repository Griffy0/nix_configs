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

  # Don't keep more than the last 3 nix builds
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

  networking.hostName = "nixos"; # Define your hostname.

  # Disable the X11 windowing system (Wayland FTW)
  services.xserver.enable = false;

  # Enable the GDM display manager
#  services.displayManager.gdm.enable = true;
  
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

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1"; # Fixes cursor issues with some setups
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    WLR_DRM_NO_ATOMIC = "1"; # If you get DRM errors (optional)
    NIXOS_OZONE_WL= "1";
  };

  # Display fix for hyprland
  boot.kernelParams = [
    "initcall_blacklist=simpledrm_platform_driver_init"
    "nvidia-drm.modeset=1"
  ];

  # Waste less power
  services.power-profiles-daemon.enable = true;

  # zsh goog
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = [
    pkgs.efibootmgr
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  }; 
  
  # Add self
  users.users.anon = {
    isNormalUser = true;
    description = "anon";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
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
