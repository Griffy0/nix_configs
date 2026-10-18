{ pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;
  };
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "bisexual";
      mode = "rgb";
      auto_detect_light_dark = true;
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "custom";
        custom_colors = {
          "1" = 0;
          "2" = 0;
          "3" = 1;
          "4" = 2;
          "5" = 2;
          "6" = 1;
        };
      };
      backend = "fastfetch";
      args = null;
      distro = "nixos_colorful";
      pride_month_disable = false;
    };
  };
}
