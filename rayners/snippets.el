
(vendor 'yasnippet)

; first is local snippets list, then the packaged one
(setq yas/root-directory 
      '("~/.emacs.d/snippets" "~/.emacs.d/vendor/yasnippet/snippets"))
(yas/reload-all)
(yas/global-mode 1)
