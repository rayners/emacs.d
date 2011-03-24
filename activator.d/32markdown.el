
(add-to-list 'el-get-sources '(:name markdown-mode
				     :after (lambda () (add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode)))))
