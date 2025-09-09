# Griffy's Nix Configs

## Disclaimer

These are personal configs. They likely will not work well on any other machines without some tinkering.

## Build Commands

### Desktop
`sudo nixos-rebuild switch --flake .#desktop`

### Laptop
`sudo nixos-rebuild switch --flake .#laptop`

## General Config Structure
### Tree
```
.
├── flake.nix
├── hosts
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
│   │   │   ├── gnome_home.nix
│   │   │   └── gnome_nixos.nix
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
│       └── pipewire.nix
└── README.md

11 directories, 23 files
```
### What's going on?
`flake.nix` runs `hosts/<device>/configuration.nix`, which in turn runs `hosts/<device>/home.nix`.
