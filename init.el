
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(load "rayners/private")

; basic stuff
(load "rayners/paths")
(load "rayners/buffers")

; load the gui bits
(load "rayners/gui")

;; Mode setups
(load "rayners/erc")
(load "rayners/org")
