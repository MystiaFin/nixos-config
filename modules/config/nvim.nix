{
  pkgs,
  config,
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
  dadbod-grip-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "dadbod-grip.nvim";
    nvimSkipModules = [
      "dadbod-grip.pickers.snacks"
      "dadbod-grip.pickers.telescope"
    ];
    src = pkgs.fetchFromGitHub {
      owner = "joryeugene";
      repo = "dadbod-grip.nvim";
      rev = "v3.9.0";
      hash = "sha256-IsFxyoqGScs5epu1f2H1CoVeauVBb/aezW8Mrk+C2a4=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    initLua = builtins.readFile ./nvim/init.lua;
    extraPackages = [
      pkgs.imagemagick
      pkgs.python3Packages.jupytext
      pkgs.ueberzugpp
    ];
    extraPython3Packages = python: with python; [
      cairosvg
      ipykernel
      jupyter-client
      nbformat
      pillow
      pynvim
    ];
    plugins = with pkgs.vimPlugins; [
      tree-sitter-manager-nvim
      jupytext-nvim
      molten-nvim
      dadbod-grip-nvim
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
  home.activation.updateNeovimRemotePlugins = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run ${config.programs.neovim.finalPackage}/bin/nvim --headless -u NONE \
      --cmd "let g:python3_host_prog='${config.programs.neovim.finalPackage.python3Env}/bin/pynvim-python'" \
      --cmd "set loadplugins" \
      --cmd "set runtimepath+=${pkgs.vimPlugins.molten-nvim}" \
      --cmd "runtime plugin/rplugin.vim" \
      +UpdateRemotePlugins +qa
  '';
  xdg.configFile."nvim/lua".source = ./nvim/lua;
}
