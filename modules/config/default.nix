{
  config,
  pkgs,
  lib,
  stateVersion,
  ...
}:

let
  tree-sitter-manager-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "tree-sitter-manager";
    src = pkgs.fetchFromGitHub {
      owner = "romus204";
      repo = "tree-sitter-manager.nvim";
      rev = "09e3a321eea8100cacd2e759c3a6c9d350295fab";
      hash = "sha256-IOLjwLX1zJCYMu42ygEtwzhugIWa3UDujOuqwHkBg88=";
    };
  };
in
{
  imports = [
    ./fish.nix
    ./niri.nix
    ./quickshell.nix
    ./fontconfig.nix
    ./themes.nix
  ];

  home.stateVersion = stateVersion;

  programs.git = {
    enable = true;
    settings = {
      user.name = "mystiafin";
      user.email = "cytrsx01@gmail.com";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    initLua = builtins.readFile ./nvim/init.lua;
    plugins = with pkgs.vimPlugins; [
      tree-sitter-manager-nvim
      nvim-web-devicons
      plenary-nvim
      nvim-notify
      nui-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      luasnip
      catppuccin-nvim
      gruvbox-nvim
      gruvbox-baby
      oil-nvim
      nvim-lspconfig
      telescope-nvim
      lualine-nvim
      presence-nvim
      nvim-autopairs
      nvim-ts-autotag
      indent-blankline-nvim
      harpoon2
      neoscroll-nvim
      gitsigns-nvim
      dashboard-nvim
      vimtex
      typst-preview-nvim
      themery-nvim
      obsidian-nvim
      render-markdown-nvim
      snacks-nvim
      copilot-vim
      CopilotChat-nvim
      avante-nvim
      image-nvim
      noice-nvim
      which-key-nvim
    ];
  };

  xdg.configFile."nvim/lua".source = ./nvim/lua;
}
