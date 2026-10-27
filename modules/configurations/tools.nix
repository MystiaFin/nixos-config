{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    ripgrep
    gcc
    tree
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.home-manager
    opencode
  ];

  programs.zsh = {
    enable = true;
    # home-manager's .zshrc runs compinit itself, so skip the system one
    enableGlobalCompInit = false;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };
  };
}
