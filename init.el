
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(load "rayners/private")
(load "rayners/defuns")

; buffer handling
(load "rayners/buffers")

; load the gui bits
(load "rayners/gui")

;; Mode setups
(load "rayners/modes")

;; specific modes
(load "rayners/irc")
(load "rayners/org")
(load "rayners/perl")
(load "rayners/wl")

;; vendor libs/modes
(vendor 'org)
(vendor 'gist)
(vendor 'wl)
(vendor 'growl)

(setq growl-program "/usr/local/bin/growlnotify") ; why isn't it finding this?
