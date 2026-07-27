{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    ripgrep
    gcc
    ffmpeg
    tree
    inputs.home-manager.packages.${pkgs.system}.home-manager
    opencode
  ];

  programs.fish.enable = true;

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
