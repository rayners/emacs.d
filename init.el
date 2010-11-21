
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(load "rayners/private")
(load "rayners/paths")
(load "rayners/defuns")

; buffer handling
(load "rayners/buffers")

; files
(load "rayners/files")

; load the gui bits
(load "rayners/gui")

;; Mode setups
(load "rayners/modes")

;; specific modes
(load "rayners/irc")
(load "rayners/appt")
(load "rayners/org")
(load "rayners/perl")
(load "rayners/wl")

(load "rayners/snippets")

;; vendor libs/modes
(vendor 'org)
(vendor 'gist)
(vendor 'wl)
(vendor 'growl)
(vendor 'yaml-mode)
(vendor 'magit)
(vendor 'rinari)
