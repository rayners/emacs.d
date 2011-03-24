(add-to-list 'el-get-sources '(:name nognus
				     :after (lambda ()
;					      (add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor/gnus"))
;					      (require 'gnus-load)
;					      (setq debug-on-error t)
					      (setq gnus-init-file (expand-file-name "~/.emacs.d/gnus.el")))))
