{ config, pkgs, ... }:

let
  # Main terminal of the host (same one the niri keybind uses).
  terminal = config.custom.niri.terminal;

  # Terminal-specific arguments. `class` is the window class/app-id, `title`
  # the window title, and "$VAULT" the shell var holding the working directory.
  openArgs = class: title:
    if terminal == "foot" then
      "--working-directory \"$VAULT\" --app-id ${class} --title \"${title}\""
    else
      "--directory \"$VAULT\" --class ${class} -T \"${title}\" -o background_opacity=0.9";

  mkScript = name: { class, title, inputs }: pkgs.writeShellApplication {
    inherit name;
    runtimeInputs = with pkgs; [ fish neovim ] ++ inputs ++ [ pkgs.${terminal} ];
    text = pkgs.lib.replaceStrings
      [ "@TERMINAL@" "@TERMINAL_FLAGS@" ]
      [ terminal (openArgs class title) ]
      (builtins.readFile ../../scripts/${name}.sh);
  };
in {
  home.packages = [
    (mkScript "journal" {
      class = "obsidian-journal";
      title = "Journal";
      inputs = [ pkgs.coreutils pkgs.gnused pkgs.findutils ];
    })
    (mkScript "obsidian-todo" {
      class = "obsidian-todo";
      title = "Obsidian TODO";
      inputs = [ ];
    })
    (pkgs.writeShellApplication {
      name = "project-launcher";
      runtimeInputs = with pkgs; [ foot rofi tmux libnotify gawk ];
      text = builtins.readFile ../../scripts/project-launcher.sh;
    })
    (pkgs.writeShellApplication {
      name = "tmux-boot";
      runtimeInputs = with pkgs; [ tmux coreutils gnused ];
      text = builtins.readFile ../../scripts/tmux-boot.sh;
    })
  ];

  home.file.".config/scripts/project-launcher-theme.rasi".source =
    ../../scripts/project-launcher-theme.rasi;
}
