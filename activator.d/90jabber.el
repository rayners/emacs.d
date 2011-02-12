
(vendor 'jabber)

(setq jabber-account-list
      '(("rayners@gmail.com"
	 (:network-server . "talk.google.com")
	 (:connection-type . ssl))))

(setq jabber-roster-line-format " %c %-25n %u %-8s  %S")

(private 'jabber)
