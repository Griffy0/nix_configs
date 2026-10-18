{ ... }:
{
  # The Bash Killer
  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    initContent = ''
      if [ "$TMUX" = "" ]; then tmux; fi
      hyfetch
      echo
    '';    
  };
}
