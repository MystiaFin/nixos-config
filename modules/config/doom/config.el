;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Changes here apply on restart (or 'SPC h r r'), no 'doom sync' needed.

;; same font as kitty/foot
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 13.0)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 13.0))

;; matches the catppuccin mocha qt/cursor theme in themes.nix
(setq catppuccin-flavor 'mocha
      doom-theme 'catppuccin)

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

;; vterm should use fish like everything else
(after! vterm
  (setq vterm-shell "fish"))
