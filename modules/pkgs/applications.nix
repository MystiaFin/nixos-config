{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    pcmanfm
		yazi
    inputs.zennotes.packages.${pkgs.system}.zennotes-desktop
    vesktop
    zed-editor
    vlc
    showmethekey
    onlyoffice-desktopeditors
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
