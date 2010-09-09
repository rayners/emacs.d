
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(load "rayners/private")
(load "rayners/defuns")

; load the gui bits
(load "rayners/gui")

;; Mode setups
(load "rayners/modes")

;; specific modes
(load "rayners/erc")
(load "rayners/org")
(load "rayners/perl")
(load "rayners/wl")

;; vendor libs/modes
(vendor 'org)
(vendor 'gist)
(vendor 'wl)
