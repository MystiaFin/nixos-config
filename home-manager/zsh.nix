{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      vim = "nvim";
      vi = "nvim";
      nrs-thinkpad = "sudo nixos-rebuild switch --flake .#thinkpad";
      nrs-desktop = "sudo nixos-rebuild switch --flake .#desktop";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      theme = "robbyrussell";
    };
    initContent = ''
      # Force cursor to be a block (standard vt100 code)
      echo -ne '\e[2 q'

      # Ensure it stays a block every time the prompt is drawn
      precmd() {
        echo -ne '\e[2 q'
      }
    '';
  };
}
