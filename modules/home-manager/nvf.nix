{ pkgs, inputs, ... }:
{
  imports = [ inputs.nvf.homeManagerModules.default ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        languages = {
          nix.enable = true;
          python.enable = true;
          clang.enable = true;
        };
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        extraPlugins = with pkgs.vimPlugins; {
          leetcode = {
            package = leetcode-nvim;
            setup = "require('leetcode').setup {}";
          };
        }; 
        #utility.leetcode-nvim.enable = true; 
      };
    };
  };
}
