{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./tools.nix
  ];

  options.custom.username = lib.mkOption {
    type = lib.types.str;
    default = "mystiafin";
    description = "Primary user account name";
  };

  config = {
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    time.timeZone = "Asia/Jakarta";

    networking.networkmanager.enable = true;

    users.users.${config.custom.username} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.fish;
    };

    services.cloudflare-warp.enable = true;

    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      user = config.custom.username;
      group = "users";
      dataDir = "/home/${config.custom.username}";
      configDir = "/home/${config.custom.username}/.config/syncthing";
    };
  };
}
