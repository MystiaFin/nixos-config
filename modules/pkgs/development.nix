{ pkgs, ... }: {
  home.packages = with pkgs; [
    lua-language-server
    intelephense
    vscode-langservers-extracted
    tailwindcss-language-server
    svelte-language-server
    typescript-language-server
    nil
    gopls
    typst
    texliveFull
  ];
}
