{ config, lib, pkgs, hw_file, ... }:

{
  boot = {
    loader.systemd-boot = {
      enable = true;
      consoleMode = "max";
      configurationLimit = 10;
    };
    loader.efi.canTouchEfiVariables = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      themePackages = with pkgs; [
        (catppuccin-plymouth.override { variant = "mocha"; })
      ];
    };

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
      "fbcon=nodefer"
    ] ++ lib.optionals (hw_file == "nixos") [
      "pcie_aspm=off"
      "mt7921e.disable_aspm=1"
      "amdgpu.dcdebugmask=0x10"
    ];
  };
}

