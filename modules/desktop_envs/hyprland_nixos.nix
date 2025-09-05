{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  
  stylix = {
    enable = true;
    autoEnable = true;
    homeManagerIntegration.autoImport = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    #targets.hyprland.enable = true;
  };
}
