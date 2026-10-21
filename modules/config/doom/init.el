;;; $DOOMDIR/init.el -*- lexical-binding: t; -*-

;; Which Doom modules are enabled. Run 'doom sync' after changing this file.
;; 'SPC h d h' opens Doom's docs, and 'K' on a module name shows its readme.

(doom! :completion
       (corfu +orderless)  ; completion popup
       vertico             ; fuzzy search for files, buffers, commands

       :ui
       doom
       dashboard
       hl-todo             ; highlight TODO/FIXME/NOTE
       indent-guides
       modeline
       nav-flash
       ophints             ; highlight the region an operation acts on
       (popup +defaults)
       treemacs            ; file tree, 'SPC o p'
       (vc-gutter +pretty) ; git diff in the fringe
       vi-tilde-fringe
       workspaces

       :editor
       (evil +everywhere)  ; vim keys, everywhere
       file-templates
       fold
       (format +onsave)
       multiple-cursors
       snippets
       (whitespace +guess +trim)

       :emacs
       dired
       electric
       tramp
       undo
       vc

       :term
       vterm               ; real terminal, 'SPC o t'

       :checkers
       syntax
       (spell +flyspell)

       :tools
       editorconfig
       (eval +overlay)
       lookup
       lsp
       magit               ; git porcelain, 'SPC g g'
       make

       :os
       tty

       :lang
       (cc +lsp)
       emacs-lisp
       (go +lsp)
       json
       (javascript +lsp)
       latex
       (lua +lsp)
       markdown
       (nix +lsp)
       org
       (php +lsp)
       (python +lsp)
       (rust +lsp)
       sh
       (web +lsp)
       yaml

       :config
       (default +bindings +smartparens))

;; avoid the white flash on startup before the theme loads
(add-to-list 'initial-frame-alist '(background-color . "#1e1e2e"))
