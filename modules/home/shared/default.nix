{
  config,
  pkgs,
  lib,
  inputs,
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
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./fish.nix
    ./niri.nix
    ./quickshell.nix
    ./fontconfig.nix
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      adblock
    ];
  };

  home.stateVersion = stateVersion;

  home.packages = with pkgs; [
    tree-sitter
    wl-clipboard
    htop
    fastfetch
    unzip

    lua-language-server
    intelephense
    vscode-langservers-extracted
    tailwindcss-language-server
    svelte-language-server
    typescript-language-server
    nil
    gopls

    tmux
    blesh

    kdePackages.dolphin
    yazi
    vesktop
    ungoogled-chromium
    zed-editor
    onlyoffice-desktopeditors
    qalculate-gtk
    obs-studio
    inkscape-with-extensions
    localsend
    qbittorrent-enhanced
    aerc

    playerctl
    cava
    cmatrix

    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    material-design-icons
    vista-fonts
    google-fonts
    corefonts
    inter

    libnotify
    gtk3
    bluez-tools
    microfetch
    btop
    p7zip
    unrar
    wineWow64Packages.stable
    winetricks
    typst
    texliveFull
    xdg-desktop-portal-gtk

    cloudflare-warp
    cloudflare-cli

    quickshell
    wlogout
    qt6.qt5compat
    qt6.qtsvg
    qt6Packages.qt6ct
    catppuccin-qt5ct
    catppuccin-cursors.mochaDark
  ];

  gtk = {
    enable = true;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };

  xdg.configFile."qt6ct/qt6ct.conf" = {
    force = true;
    text = ''
      [Appearance]
      custom_palette=true
      color_scheme_path=${pkgs.catppuccin-qt5ct}/share/qt6ct/colors/catppuccin-mocha-mauve.conf
      icon_theme=Papirus
      style=Fusion
    '';
  };

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
