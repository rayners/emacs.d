
;; make sure to load the needed libraries

;(vendor 'apel)
;(vendor 'semi)
;(vendor 'emu) ;; this one too?
;(vendor 'flim)

(add-to-list 'load-path "~/.emacs.d/vendor/apel")
(add-to-list 'load-path "~/.emacs.d/vendor/emu")
(add-to-list 'load-path "~/.emacs.d/vendor/flim")
(add-to-list 'load-path "~/.emacs.d/vendor/semi")

;; Wanderlust settings

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame" t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust" t)

;; setup files
(setq wl-init-file "~/.emacs.d/rayners/wl/wl.el"
      wl-folders-file "~/.emacs.d/rayners/wl/folders")
