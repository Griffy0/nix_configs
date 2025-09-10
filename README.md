# Griffy's Nix Configs

## Disclaimer

These are personal configs. They likely will not work well on any other machines without some tinkering.

## Build Commands

### Desktop
`sudo nixos-rebuild switch --flake .#desktop --specialisation=hyprland`

### Laptop
`sudo nixos-rebuild switch --flake .#laptop --specialisation=hyprland`

## General Config Structure
### Tree
```
.
├── flake.lock
├── flake.nix
├── hosts
│   ├── common
│   │   ├── configuration.nix
│   │   └── home.nix
│   ├── desktop
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── home.nix
│   └── laptop
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── home.nix
├── modules
│   ├── desktop_envs
│   │   ├── gnome
│   │   │   └── common
│   │   │       ├── gnome_home.nix
│   │   │       └── gnome_nixos.nix
│   │   └── hyprland
│   │       ├── common
│   │       │   ├── hyprland_home.nix
│   │       │   └── hyprland_nixos.nix
│   │       ├── desktop_hypr_home.nix
│   │       ├── hypr_wallpaper.png
│   │       └── laptop_hypr_home.nix
│   ├── home-manager
│   │   ├── dunst.nix
│   │   ├── flameshot.nix
│   │   ├── hyfetch.nix
│   │   ├── kitty.nix
│   │   ├── nvf.nix
│   │   └── vesktop.nix
│   └── nixos
│       ├── boilerplate.nix
│       ├── pipewire.nix
│       └── tlp.nix
└── README.md

13 directories, 27 files
```
### What's going on?
`flake.nix` runs `hosts/<device>/configuration.nix`, which in turn runs `hosts/<device>/home.nix`.
