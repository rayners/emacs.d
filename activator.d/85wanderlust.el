(setq user-mail-address "rayners@gmail.com")

(add-to-list 'el-get-sources '(:name wanderlust
				     :after (lambda ()
					      (setq wl-init-file (expand-file-name "~/.emacs.d/wl/wl.el"))
					      (if (rayners/my-laptop)
						  (setq wl-folders-file (expand-file-name "~/.emacs.d/wl/folders"))
						(setq wl-folders-file (expand-file-name "~/.emacs.d/wl/folders-work")))
)))
(add-to-list 'el-get-sources 'apel)
(add-to-list 'el-get-sources 'flim)
(add-to-list 'el-get-sources 'semi)

(add-to-list 'el-get-sources '(:name offlineimap))
