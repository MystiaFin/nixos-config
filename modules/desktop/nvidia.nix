{ lib, hw_file, ... }:

{
  hardware.nvidia = lib.mkIf (hw_file == "nixos") {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
  };

  hardware.graphics = lib.mkIf (hw_file == "nixos") {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = lib.mkIf (hw_file == "nixos") [ "nvidia" ];
}
