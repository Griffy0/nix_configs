{ pkgs, ... }:
{
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "bisexual";
      mode = "rgb";
      auto_detect_light_dark = true;
      light_dark = "dark";
      lightness = 0.65;
      color_align = {
        mode = "horizontal";
      };
      backend = "neofetch";
      args = null;
      distro = null;
      pride_month_disable = false;
    };
  };
}
