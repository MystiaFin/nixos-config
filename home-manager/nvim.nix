{ pkgs, ... }:

{
  xdg.configFile."nvim".source = ./config/nvim;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    
    extraPackages = with pkgs; [
      lua-language-server
      intelephense
      vscode-langservers-extracted
      tailwindcss-language-server
      ripgrep
      fd
      gcc
			kdePackages.qtdeclarative
			nixd
			nixpkgs-fmt
    ];
  };
}
