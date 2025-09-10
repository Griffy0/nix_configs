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
<!-- TREE_START -->
```
/etc/nixos
├── flake.lock
├── flake.nix
├── .git
│   ├── COMMIT_EDITMSG
│   ├── config
│   ├── description
│   ├── FETCH_HEAD
│   ├── HEAD
│   ├── hooks
│   ├── index
│   ├── info
│   ├── logs
│   ├── objects
│   ├── ORIG_HEAD
│   └── refs
├── git_push.sh
├── hosts
│   ├── common
│   ├── desktop
│   └── laptop
├── modules
│   ├── desktop_envs
│   ├── home-manager
│   └── nixos
└── README.md

15 directories, 11 files
```
<!-- TREE_END -->

### What's going on?
`flake.nix` runs `hosts/<device>/configuration.nix`, which in turn runs `hosts/<device>/home.nix`.
