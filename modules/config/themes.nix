{
  config,
  pkgs,
  inputs,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  quickshellThemeExtension = {
    src = pkgs.writeTextDir "spicetify-quickshell-theme.js" ''
      (function quickshellTheme() {
          const endpoint = "http://127.0.0.1:17384/spotify.css";
          const styleId = "quickshell-dynamic-theme";
          let currentCss = "";

          async function refreshTheme() {
              try {
                  const response = await fetch(endpoint, { cache: "no-store" });
                  if (!response.ok)
                      return;

                  const css = await response.text();
                  if (css === currentCss)
                      return;

                  currentCss = css;
                  let style = document.getElementById(styleId);
                  if (!style) {
                      style = document.createElement("style");
                      style.id = styleId;
                      document.documentElement.appendChild(style);
                  }
                  style.textContent = css;
              } catch (_) {
                  // The local bridge may not be ready yet; the next poll retries.
              }
          }

          refreshTheme();
          setInterval(refreshTheme, 1500);
      })();
    '';
    name = "spicetify-quickshell-theme.js";
  };
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    catppuccin-qt5ct
    catppuccin-cursors.mochaDark
    dconf
    papirus-icon-theme
    kdePackages.qt6ct
    kdePackages.qtsvg
    (catppuccin-kde.override {
      flavour = [
        "mocha"
        "macchiato"
        "frappe"
        "latte"
      ];
      accents = [ "blue" ];
    })
  ];

  xdg.configFile."kdeglobals".text = ''
    [Icons]
    Theme=Papirus-Dark
  '';

  programs.spicetify = {
    enable = true;
    enabledExtensions = (with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      adblock
    ]) ++ [ quickshellThemeExtension ];
  };

  systemd.user.services.quickshell-theme-server = {
    Unit = {
      Description = "Serve Quickshell application theme CSS";
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = "${pkgs.darkhttpd}/bin/darkhttpd %h/.cache/quickshell-theme --addr 127.0.0.1 --port 17384 --header \"Access-Control-Allow-Origin: *\" --no-listing";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install.WantedBy = [ "default.target" ];
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "catppuccin-mocha-dark-cursors";
    size = 14;
    gtk.enable = true;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };
}
