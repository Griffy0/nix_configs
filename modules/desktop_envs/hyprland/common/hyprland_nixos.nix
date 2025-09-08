{ pkgs, ... }:
{
  # Icons for HyprPanel, managed in hyprland_home.nix
  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];

  # Enable Hyprland
  programs.hyprland.enable = true;  
  
  # Enable Hyprcursor
  environment.systemPackages = [
    pkgs.hyprcursor
  ];  

  # Catppuccin theme for stylix
  stylix = {
    enable = true;
    autoEnable = true;
    homeManagerIntegration.autoImport = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
  };
}
