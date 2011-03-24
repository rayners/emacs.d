;(load-theme 'wheatgrass) ; this looks spiffy, and it's core!
(load-theme 'tango)

;; use that fancy font I downloaded
;; but only if we're using the GUI
;; because this barfs otherwise
(if (not noninteractive)
    (set-face-font 'default "-apple-Droid_Sans_Mono-medium-normal-normal-*-11-*-*-*-m-0-iso10646-1"))

(add-to-list 'default-frame-alist '(width . 128))
(add-to-list 'default-frame-alist '(height . 50))

;; my fancy frame title
;; "Emacs: <filename> [on <user>@<host>] [[ Working on <current-clocked-task> ]]"
(setq frame-title-format '("" invocation-name ": "(:eval (if (buffer-file-name)
							     (abbreviate-file-name (buffer-name))
							   "%b"))
			   (:eval (if (tramp-tramp-file-p buffer-file-name)
				      (concat " on " (tramp-file-name-user (tramp-dissect-file-name (buffer-file-name))) "@" (tramp-file-name-host (tramp-dissect-file-name (buffer-file-name))))))
			   " "(:eval (if (org-clock-is-active) (concat "[ Working: " org-clock-heading " ]")))))
