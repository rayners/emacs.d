
(add-to-list 'el-get-sources '(:name emacs-jabber
				     :after (lambda ()

					      (setq jabber-show-offline-contacts nil)
					      (setq jabber-account-list
						    '(("rayners@gmail.com"
						       (:network-server . "talk.google.com")
						       (:connection-type . ssl))))
					      
					      (setq jabber-roster-line-format " %c %-25n %u %-8s  %S")
					      
					      (private 'jabber)
)))
