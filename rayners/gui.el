
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
