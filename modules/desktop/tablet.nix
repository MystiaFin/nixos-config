{ lib, hw_file, ... }:

{
  services.xserver.wacom.enable = lib.mkIf (hw_file == "nixos") true;
  hardware.opentabletdriver.enable = lib.mkIf (hw_file == "nixos") true;
}
