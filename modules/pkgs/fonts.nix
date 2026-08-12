{ pkgs, lib, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    material-design-icons
    roboto
		open-sans
		poppins
		raleway
		noto-fonts
    corefonts
    inter
  ];

	home.activation.copyFontsForOnlyOffice = lib.hm.dag.entryAfter ["writeBoundary"] ''
    FONT_DIR="$HOME/.local/share/fonts"
    
    # Ensure the target is a physical directory and not a symlink created by other tools
    if [ -L "$FONT_DIR" ]; then
      rm "$FONT_DIR"
    fi
    mkdir -p "$FONT_DIR"

    # Copy the actual files directly into the root of the fonts folder (no subdirectories)
    cp -L ${pkgs.corefonts}/share/fonts/truetype/* "$FONT_DIR"/
    
    # ONLYOFFICE requires standard file permissions to read them
    chmod 644 "$FONT_DIR"/*
  '';
}
