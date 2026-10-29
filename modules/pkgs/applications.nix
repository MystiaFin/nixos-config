{ pkgs, pkgs-unstable, inputs, ... }:
{
  home.packages = with pkgs; [
    pcmanfm
    yazi
    inputs.zennotes.packages.${pkgs.system}.zennotes-desktop
    pkgs-unstable.claude-code
    # arRPC only knows a stale bundled snapshot of Discord's game list; fetch the live one.
    (vesktop.overrideAttrs (old: {
      preBuild = (old.preBuild or "") + ''
        arrpc=$(realpath node_modules/arrpc)
        chmod -R u+w "$arrpc"
        patch -p1 -d "$arrpc" < ${./patches/arrpc-live-detectable-db.patch}
      '';
    }))
    zed-editor
    obsidian
    vlc
    showmethekey
    onlyoffice-desktopeditors
    libreoffice
    qalculate-gtk
    obs-studio
    inkscape-with-extensions
    localsend
    qbittorrent-enhanced
    aerc
    rofi
    stirling-pdf-desktop
    losslesscut-bin
    wineWow64Packages.stable
    winetricks
    kdePackages.gwenview
    zathura
    zathuraPkgs.zathuraWrapper
		quickshell
  ];
  home.file."xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <channel name="thunar" version="1.0">
      <property name="volman">
        <property name="manage-removable-drives" type="bool" value="true"/>
        <property name="autoplay-drives" type="bool" value="true"/>
        <property name="automount-drives" type="bool" value="true"/>
        <property name="automount-media" type="bool" value="true"/>
        <property name="automount-mtp" type="bool" value="true"/>
        <property name="automount-camera" type="bool" value="true"/>
        <property name="automount-printer" type="bool" value="true"/>
        <property name="automount-keyboard" type="bool" value="true"/>
        <property name="automount-gamepad" type="bool" value="true"/>
        <property name="automount-tablet" type="bool" value="true"/>
        <property name="automount-scanner" type="bool" value="true"/>
        <property name="automount-charger" type="bool" value="true"/>
      </property>
    </channel>
  '';
}
