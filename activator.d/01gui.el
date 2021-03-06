;(load-theme 'wheatgrass) ; this looks spiffy, and it's core!
;(load-theme 'tango)
(load-theme 'wombat) ;; wombat!

;; use that fancy font I downloaded
;; but only if we're using the GUI
;; because this barfs otherwise
(if (not noninteractive)
    (set-face-font 'default "-apple-Droid_Sans_Mono-medium-normal-normal-*-10-*-*-*-m-0-iso10646-1"))

(add-to-list 'default-frame-alist '(width . 128))
(add-to-list 'default-frame-alist '(height . 50))

;; my fancy frame title
;; "Emacs: <filename> [on <user>@<host>] [[ Working on <current-clocked-task> ]]"
(setq frame-title-format '("" invocation-name ": "(:eval (if (buffer-file-name)
							     (abbreviate-file-name (buffer-name))
							   "%b"))
			   (:eval (if (and (boundp 'tramp-tramp-file-p) (tramp-tramp-file-p buffer-file-name))
				      (concat " on " (tramp-file-name-user (tramp-dissect-file-name (buffer-file-name))) "@" (tramp-file-name-host (tramp-dissect-file-name (buffer-file-name))))))
			   " "
			   (:eval (if (and (fboundp 'org-clock-is-active)
					   (org-clock-is-active)) 
				      (concat "[ Working: " org-clock-heading " ]")))
			   " "
			   (:eval (if (and (and (boundp '*jabber-connected*) 
						*jabber-connected*)
					   (not (string= "" *jabber-current-show*)))
				      (concat "[ "  *jabber-current-show* ": " *jabber-current-status* " ]")))
			   ))

(add-to-list 'el-get-sources '(:name color-theme-solarized))
(add-to-list 'el-get-sources '(:name color-theme-railscasts))
(add-to-list 'el-get-sources '(:name color-theme :load "color-theme-6.6.0/color-theme.el" :load-path ("./color-theme-6.6.0")))
