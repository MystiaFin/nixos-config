{ device, pkgs, ... }:
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
      nrs = "sudo nixos-rebuild switch --flake .#${if device == "thinkpad" then "thinkpad" else "desktop"}";
    };

    interactiveShellInit = ''
      set -g fish_greeting ""
      
      printf '\e[2 q'
      function force_cursor_block --on-event fish_prompt
          printf '\e[2 q'
      end

      set -g fish_color_normal cdd6f4
      set -g fish_color_command f9e2af --bold
      set -g fish_color_keyword f9e2af
      set -g fish_color_quote a6e3a1
      set -g fish_color_redirection 94e2d5
      set -g fish_color_end f5c2e7
      set -g fish_color_error f38ba8
      set -g fish_color_param f2cdcd
      set -g fish_color_comment 6c7086
      set -g fish_color_autosuggestion 6c7086
    '';

    functions = {
      fish_prompt = ''
        set -l last_status $status

        # Colors
        set -l path_blue (set_color --bold 89b4fa)
        set -l git_red (set_color f38ba8)
        set -l green (set_color a6e3a1)
        set -l text (set_color cdd6f4)
        set -l normal (set_color normal)
        echo -n $text"╭─  "
        echo -n $path_blue"["(prompt_pwd)"]"

        if type -q git
            set -l git_branch (git branch --show-current 2>/dev/null)
            
            if test -n "$git_branch"
                echo -n $text"("$git_red$git_branch$text")"
                set -l dirty (git status --porcelain --ignore-submodules=dirty 2>/dev/null)
                if test -n "$dirty"
                   echo -n $git_red"*"$normal
                end
            end
        end
        echo # New line
        echo -n $text"╰─ "

        if test $last_status -eq 0
            echo -n $green"λ "$normal
        else
            echo -n $git_red"λ "$normal
        end
      '';

      fish_right_prompt = "";
    };
  };
}
