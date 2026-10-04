# Software debounce for the worn left microswitch on the AJAZZ mouse.
{ pkgs, ... }:

let
  device = "/dev/input/by-id/usb-Compx_AJAZZ_2.4G_4K-if02-event-mouse";
  # Seconds; raise if chatter still gets through.
  threshold = "0.08";

  mouse-debounce = pkgs.writers.writePython3Bin "mouse-debounce" {
    libraries = [ pkgs.python3Packages.evdev ];
  } ''
    import os
    import sys
    from evdev import InputDevice, UInput, ecodes as e

    THRESHOLD = float(os.environ.get("DEBOUNCE_THRESHOLD", "0.08"))

    dev = InputDevice(sys.argv[1])
    ui = UInput.from_device(dev, name=dev.name + " (debounced)")
    dev.grab()  # exclusive: only the virtual device reaches libinput

    last_release = 0.0  # time of last forwarded BTN_LEFT release
    dropping = False    # a chatter press was dropped; drop its release too

    # Unplug raises OSError; the process exits and systemd restarts it.
    for ev in dev.read_loop():
        if ev.type == e.EV_KEY and ev.code == e.BTN_LEFT:
            t = ev.timestamp()
            if ev.value == 1 and t - last_release < THRESHOLD:
                dropping = True
                continue
            if ev.value == 0:
                if dropping:
                    dropping = False
                    continue
                last_release = t
        ui.write_event(ev)
  '';
in
{
  boot.kernelModules = [ "uinput" ];

  systemd.services.mouse-debounce = {
    description = "Debounce left mouse button";
    wantedBy = [ "multi-user.target" ];
    environment.DEBOUNCE_THRESHOLD = threshold;
    # Retry forever while the mouse is unplugged.
    startLimitIntervalSec = 0;
    serviceConfig = {
      ExecStart = "${mouse-debounce}/bin/mouse-debounce ${device}";
      User = "root";
      Restart = "always";
      RestartSec = 1;
    };
  };
}
