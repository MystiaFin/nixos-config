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

  options.features.desktop = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether this host is a desktop host, enabling desktop-only packages and entries";
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
        "docker"
      ];
      shell = pkgs.fish;
    };

    virtualisation.docker.enable = true;

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
