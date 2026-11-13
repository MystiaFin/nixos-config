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
		# nixpkgs lags behind upstream; inline image previews landed 2026-09-29 and need go 1.27
		((pkgs-unstable.discordo.override { buildGoModule = pkgs-unstable.buildGo127Module; }).overrideAttrs (old: {
			version = "0-unstable-2026-11-12";
			src = pkgs.fetchFromGitHub {
				owner = "ayn2op";
				repo = "discordo";
				rev = "61e975dc9763adbc546fd3b81496a6682c4d36a8";
				hash = "sha256-WBPKralbJp0zdx+z/ezRZnlkkHecuJ4YJ9nx6Dz7FCQ=";
			};
			vendorHash = "sha256-04HOQ5NHe85bhysVLASmRf5ZTp/iWsqj8YeOrmt/Fno=";
			# guild icons in a rail beside the channels of one guild, like Discord
			patches = (old.patches or [ ]) ++ [ ./patches/discordo-guild-icons.patch ];
		}))
  ];
  # set per key, so thunar can still save the rest of its settings
  xfconf.settings.thunar-volman = {
    "automount-drives/enabled" = true;
    "automount-media/enabled" = true;
    "autoplay-audio-cds/enabled" = true;
    "autoplay-video-cds/enabled" = true;
  };
  # force: replaces the uca.xml thunar wrote itself (its one action is kept below)
  xdg.configFile."Thunar/uca.xml" = {
    force = true;
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <actions>
      <action>
      	<icon>utilities-terminal</icon>
      	<name>Open Terminal Here</name>
      	<submenu></submenu>
      	<unique-id>1785897717360669-1</unique-id>
      	<command>exo-open --working-directory %f --launch TerminalEmulator</command>
      	<description>Example for a custom action</description>
      	<range></range>
      	<patterns>*</patterns>
      	<startup-notify/>
      	<directories/>
      </action>
      <action>
      	<icon>application-pdf</icon>
      	<name>Combine into PDF</name>
      	<submenu></submenu>
      	<unique-id>combine-pdf</unique-id>
      	<command>combine-pdf %F</command>
      	<description>Merge the selected images and PDFs into combined.pdf</description>
      	<range></range>
      	<patterns>*.pdf;*.PDF;*.png;*.PNG;*.jpg;*.JPG;*.jpeg;*.JPEG;*.tif;*.tiff;*.webp</patterns>
      	<image-files/>
      	<other-files/>
      </action>
      </actions>
    '';
  };
}
