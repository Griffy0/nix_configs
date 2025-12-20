{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = "set -g default-command ${pkgs.zsh}/bin/zsh";
  };
}
