{ pkgs, lib, ... }:

let
  # amane links these, both when the cli is built and when it builds a shell
  amaneLibraries = with pkgs; [
    fontconfig
    freetype
    expat
    wayland
    libxkbcommon
    vulkan-loader
    libpulseaudio
    linux-pam
  ];
in
{
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
    pandoc
    rust-analyzer
    rustfmt
    rustc
    cargo
    pkg-config
    kdePackages.qtdeclarative
    clang
    clang-tools
  ];

  # binaries from `cargo install`
  home.sessionPath = [ "$HOME/.cargo/bin" ];

  # lets `cargo install amane-cli` (and the shells it builds) find amane's native libraries
  home.sessionVariables = {
    PKG_CONFIG_PATH = lib.makeSearchPathOutput "dev" "lib/pkgconfig" amaneLibraries;
    LIBRARY_PATH = lib.makeLibraryPath [ pkgs.linux-pam ];
    LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.vulkan-loader pkgs.wayland ];
  };
}
