{ pkgs, ... }:
{
  environment.systemPackages = [
#    pkgs.hyprpaper
  ];
  programs.hyprland.enable = true;  
  stylix = {
    enable = true;
    autoEnable = true;
    homeManagerIntegration.autoImport = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
#    opacity.terminal = 0.2;
    #targets.vesktop.enable = false;
    #targets.hyprland.enable = true;
  };
}
