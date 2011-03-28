(add-to-list 'el-get-sources '(:name nognus
				     :after (lambda ()
					      (setq gnus-init-file (expand-file-name "~/.emacs.d/gnus.el")))))
