{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "journal";
      runtimeInputs = with pkgs; [ kitty fish neovim coreutils gnused findutils ];
      text = builtins.readFile ../../scripts/journal.sh;
    })
    (pkgs.writeShellApplication {
      name = "obsidian-todo";
      runtimeInputs = with pkgs; [ kitty fish neovim ];
      text = builtins.readFile ../../scripts/obsidian-todo.sh;
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
