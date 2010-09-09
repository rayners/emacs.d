
; nix the tool bar
; it's yucky
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))

; load that spiffy zenburn theme
(require 'color-theme)
(require 'zenburn)
(eval-after-load "color-theme"
                '(progn
                (color-theme-initialize)
                (color-theme-zenburn)))

;; use that fancy font I downloaded
(set-face-font 'default "-apple-DejaVu_Sans_Mono-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1")
