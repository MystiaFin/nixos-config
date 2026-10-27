{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    autocd = true;

    shellAliases = {
      ll = "lsd -l";
      ls = "lsd";
      la = "lsd -a";
      lla = "lsd -la";
      vim = "nvim";
      vi = "nvim";
      nrs = "sudo nixos-rebuild switch --flake \".#$(hostname)\"";
      hms = "home-manager switch --flake \".#$(hostname)\"";
      project = "wl-mirror --scaling fit eDP-1";
      amane-ex = "env AMANE_CONFIG=$HOME/Projects/amane/cli/template/example amane";
      amane-update = "cargo install --locked --path ~/Projects/amane/cli";
    };

    # fish: grey suggestion from history, then from completions
    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
    };

    # fish's default theme, with yellow bold commands
    syntaxHighlighting = {
      enable = true;
      styles = {
        command = "fg=yellow,bold";
        builtin = "fg=yellow,bold";
        alias = "fg=yellow,bold";
        suffix-alias = "fg=yellow,bold";
        global-alias = "fg=yellow,bold";
        function = "fg=yellow,bold";
        precommand = "fg=yellow,bold";
        hashed-command = "fg=yellow,bold";
        reserved-word = "fg=yellow,bold";
        arg0 = "fg=yellow,bold";
        unknown-token = "fg=red,bold";
        default = "fg=cyan";
        single-hyphen-option = "fg=cyan";
        double-hyphen-option = "fg=cyan";
        path = "fg=cyan,underline";
        globbing = "fg=cyan";
        single-quoted-argument = "fg=yellow";
        double-quoted-argument = "fg=yellow";
        dollar-quoted-argument = "fg=yellow";
        back-quoted-argument = "fg=cyan";
        commandseparator = "fg=green";
        redirection = "fg=cyan,bold";
        comment = "fg=red";
      };
    };

    # fish: up arrow searches history for what's already typed
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[[A" "^[OA" ];
      searchDownKey = [ "^[[B" "^[OB" ];
    };

    history = {
      size = 100000;
      save = 100000;
      share = true;
      ignoreSpace = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
    };

    setOptions = [
      "INTERACTIVE_COMMENTS"
      "AUTO_PUSHD"
      "PUSHD_IGNORE_DUPS"
      "PUSHD_SILENT"
      "NO_BEEP"
    ];

    initContent = builtins.readFile ./zsh/init.zsh;
  };

  home.packages = with pkgs; [
    lsd
    git
  ];
}
