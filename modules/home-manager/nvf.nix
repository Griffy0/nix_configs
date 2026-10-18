{ pkgs, inputs, ... }:
{
  imports = [ inputs.nvf.homeManagerModules.default ];
  home.packages = [ pkgs.glsl_analyzer ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true; 
          servers.clangd.package = [
              "${pkgs.clang-tools}/bin/clangd"
              "--header-insertion=never"
              "--query-driver=${pkgs.gcc}/bin/g++"
              "--background-index"
          ];
        };
        languages = {
          nix.enable = true;
          python.enable = true;
          clang = {
            enable = true;
            lsp.enable = true;
          };
          zig.enable = true;
        };
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
#        notify.nvim-notify.enable = true;
        extraPlugins = with pkgs.vimPlugins; {
          leetcode = {
            package = leetcode-nvim;
            setup = "require('leetcode').setup {}";
          };
        };
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };
        options = {
          tabstop = 4;
          shiftwidth = 4;
        };
        luaConfigRC = {
          indent = ''
            vim.api.nvim_create_autocmd("FileType", {
              pattern = "nix",
              callback = function()
              vim.opt_local.shiftwidth = 2
              vim.opt_local.tabstop = 2
              end,
            })
          '';
          glsl = ''
            vim.lsp.config('glsl_analyzer', {
              cmd = { '${pkgs.glsl_analyzer}/bin/glsl_analyzer' },
              filetypes = { 'glsl', 'vert', 'frag', 'comp' },
            })
            vim.lsp.enable('glsl_analyzer')
          '';
        };
      };
    };
  };
  xdg.configFile."clangd/config.yaml".text = ''
    Diagnostics:
      UnusedIncludes: None
      MissingIncludes: None
  '';
}
