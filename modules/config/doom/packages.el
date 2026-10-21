;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; Run 'doom sync' after changing this file.

(package! catppuccin-theme)

;; vterm comes prebuilt from nixpkgs (modules/config/emacs.nix); building it
;; through straight fails on nixos because libvterm isn't where cmake looks
(package! vterm :built-in t)
