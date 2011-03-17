(setq gnus-nntp-server nil)
(setq gnus-select-method 
      '(nnimap "gmail" 
		(nnimap-address "imap.gmail.com")
		(nnimap-server-port 993)
		(nnimap-stream ssl)))

(setq gnus-parameters
      '((".*" ; this may not need to be this drastic
	 (display . all))))
(setq gnus-permanently-visible-groups ".*")
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
