(setq user-mail-address "rayners@gmail.com")

(add-to-list 'el-get-sources '(:name wanderlust
				     :after (lambda ()
					      (setq wl-init-file (expand-file-name "~/.emacs.d/wl/wl.el"))
					      (setq wl-folders-file (expand-file-name "~/.emacs.d/wl/folders"))
)))
(add-to-list 'el-get-sources 'apel)
(add-to-list 'el-get-sources 'flim)
(add-to-list 'el-get-sources 'semi)
