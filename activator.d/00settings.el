(setq inhibit-startup-message t) 

(menu-bar-mode -1)
(tool-bar-mode -1)

(global-font-lock-mode t)

;; don't keep backup files in the same directory as the original
;; swiped from SO:
;;    http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(add-to-list 'load-path "~/.emacs.d/vendor")
; so it uses the right subversion/git/etc
(push "/opt/local/bin" exec-path)
(push "/usr/local/bin" exec-path)

(add-to-list 'exec-path (expand-file-name "~/perl5/perlbrew/bin"))
(add-to-list 'exec-path "/usr/local/mysql/bin")

(setenv "PATH" (mapconcat 'identity exec-path ":"))

;; yes or no becomes y or n
(fset 'yes-or-no-p 'y-or-n-p)
