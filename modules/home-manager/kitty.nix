{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "DejaVu Sans Mono";
      font_size = 12;
      shell_integration = "no-rc";
      background_opacity = "0.8";
    };
  };
}
