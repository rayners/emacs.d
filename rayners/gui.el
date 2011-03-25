
; nix the tool bar
; it's yucky
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))

; load that spiffy zenburn theme
;(vendor 'color-theme)
;(require 'zenburn)
;(load "~/.emacs.d/vendor/color-theme-twilight")
;(eval-after-load "color-theme"
;                '(progn
;                (color-theme-initialize)
;                (color-theme-twilight)))
(load-theme 'wheatgrass) ; this looks spiffy, and it's core!

;; use that fancy font I downloaded
;; but only if we're using the GUI
;; because this barfs otherwise
(if (not noninteractive)
    (set-face-font 'default "-apple-Droid_Sans_Mono-medium-normal-normal-*-10-*-*-*-m-0-iso10646-1"))

(add-to-list 'default-frame-alist '(width . 128))
(add-to-list 'default-frame-alist '(height . 50))
