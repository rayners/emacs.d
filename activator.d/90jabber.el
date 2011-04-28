
(add-to-list 'el-get-sources '(:name emacs-jabber
				     :after (lambda ()

					      (setq jabber-show-offline-contacts nil)
					      (setq jabber-account-list
						    '(("rayners@gmail.com"
						       (:network-server . "talk.google.com")
						       (:connection-type . ssl))))
					      
					      (setq jabber-roster-line-format " %c %-25n %u %-8s  %S")
					      (setq jabber-chat-buffer-show-avatar nil)
					      (setq jabber-roster-show-bindings nil)
					      (setq jabber-history-enabled t)
					      (setq jabber-use-global-history nil)
					      (private 'jabber)
)))
