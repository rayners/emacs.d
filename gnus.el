(setq gnus-nntp-server nil)
(setq gnus-select-method 
      '(nnimap "" 
		(nnimap-address “imap.gmail.com”)
		(nnimap-server-port 993)
		(nnimap-stream ssl)))