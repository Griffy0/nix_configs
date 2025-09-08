{ pkgs, ... }:
{
  # Icons for HyprPanel
  fonts.packages = [ pkgs.nerd-fonts.symbols-only ];

  # Enable Hyprland
  programs.hyprland.enable = true;  

  # Catppuccin theme for stylix
  stylix = {
    enable = true;
    autoEnable = true;
    homeManagerIntegration.autoImport = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
  };
}
