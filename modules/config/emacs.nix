{
  config,
  pkgs,
  lib,
  ...
}:

let
  emacsDir = "${config.xdg.configHome}/emacs";
  doomBin = "${emacsDir}/bin/doom";
in
{
  programs.emacs = {
    enable = true;
    # native wayland build, the X11 one runs through xwayland under niri
    package = pkgs.emacs-pgtk;
    # doom can't compile vterm's native module on nixos, so ship it prebuilt (see doom/packages.el)
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  # git/ripgrep and the nerd fonts already come from elsewhere in this repo
  home.packages = with pkgs; [
    fd
    shellcheck
    nixfmt
    editorconfig-core-c
    (aspellWithDicts (d: [ d.en ]))
  ];

  home.sessionPath = [ "${emacsDir}/bin" ];

  # out of store so editing ~/.config/doom from emacs edits this repo, no rebuild needed
  xdg.configFile."doom".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/config/doom";

  # first run only: fetch doom and build its packages. after that, run `doom sync` yourself
  # whenever doom/init.el or doom/packages.el change
  home.activation.installDoomEmacs = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    export PATH="${
      lib.makeBinPath [
        config.programs.emacs.finalPackage
        pkgs.git
        pkgs.ripgrep
        pkgs.fd
      ]
    }:$PATH"
    if [ ! -d "${emacsDir}" ]; then
      run git clone --depth 1 https://github.com/doomemacs/doomemacs "${emacsDir}"
    fi
    if [ ! -d "${emacsDir}/.local/straight" ]; then
      run ${doomBin} install --force --no-config --no-env \
        || warnEcho "doom install failed, rerun it with: doom install --no-config --no-env"
    fi
  '';
}
