;; don't keep backup files in the same directory as the original
;; swiped from SO:
;;    http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
