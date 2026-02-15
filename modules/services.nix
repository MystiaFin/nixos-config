{ ... }:

{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.libinput.enable = true;
  services.printing.enable = true;
  services.openssh.enable = true;
  services.cloudflare-warp.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.flatpak.enable = true;

  services.pipewire = {
    enable = true;
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 44100 48000 ];
      };
    };
  };
  services.pipewire.wireplumber.extraConfig."11-bluetooth-policy" = {
    "monitor.bluez.rules" = [
      {
        matches = [{ "node.name" = "~bluez_output.*"; }];
        actions = {
          update-props = {
            "audio.rate" = 48000;
          };
        };
      }
    ];
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
            esc = "capslock";
          };
        };
      };
    };
  };
}
