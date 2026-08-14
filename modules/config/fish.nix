{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ll = "lsd -l";
      ls = "lsd";
      la = "lsd -a";
      lla = "lsd -la";
      vim = "nvim";
      vi = "nvim";
      nrs = "sudo nixos-rebuild switch --flake .#(hostname)";
      hms = "home-manager switch --flake .#(hostname)";
			project = "wl-mirror --scaling fit eDP-1";
    };

    interactiveShellInit = ''
      set -g fish_greeting ""
      set fish_color_command yellow --bold
    '';

    functions = {
      fish_prompt = ''
        set -l last_status $status
        set -l b (set_color --bold)
        set -l d (set_color brblack)
        set -l n (set_color normal)
        set -l r (set_color red)
        set -l w (set_color --bold white)
        set -l y (set_color yellow)

        echo -n $d"╭─ "$d"["$w(prompt_pwd)$d"]"$n

        if command -sq git; and command git rev-parse --is-inside-work-tree >/dev/null 2>&1
            set -l branch (command git branch --show-current 2>/dev/null)
            if test -z "$branch"
                set branch (command git rev-parse --short HEAD 2>/dev/null)
            end

            if test -n "$branch"
                echo -n $d"("$y$branch$d")"$n
                if not command git diff --no-ext-diff --quiet --ignore-submodules 2>/dev/null
                   or not command git diff --cached --no-ext-diff --quiet --ignore-submodules 2>/dev/null
                    echo -n $r"*"$n
                end
            end
        end

        echo
        echo -n $d"╰─ "
        if test $last_status -eq 0
            echo -n $b"λ "$n
        else
            echo -n $r"λ "$n
        end
      '';
    };
  };

  home.packages = with pkgs; [
    lsd
    git
  ];
}
