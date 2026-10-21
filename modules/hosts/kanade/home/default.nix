{ config, pkgs, inputs, ... }:

let
  zenPkgs = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system};
  # upstream re-uploaded the 1.23.3b tarball; pin the new hash until zen-browser-flake catches up
  zen-browser = zenPkgs.default.override {
    zen-browser-unwrapped = zenPkgs.zen-browser-unwrapped.overrideAttrs (old: {
      src = pkgs.fetchurl {
        inherit (old.src) urls;
        hash = "sha256-uyBF0+IWVNQP6EElAJLurf0sH8gx7vtQkiJ3PIvcoUk=";
      };
    });
  };
in
{
  imports = [
    ./kitty.nix
    ./niri.nix
  ];

  home.packages = with pkgs; [
    kitty
    prismlauncher
    osu-lazer-bin
    kdePackages.kdenlive
    zen-browser
    ungoogled-chromium
    teams-for-linux
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };
}
