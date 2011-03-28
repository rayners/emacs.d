(setq wl-from "David Raynes <rayners@gmail.com>")
(setq wl-user-mail-address-list '("rayners@gmail.com"
				  "rayners@rayners.org"
				  "rayners@endevver.com"))
(setq wl-forward-subject-prefix "Fwd: ")
(setq
 wl-message-ignored-field-list '("^.*:")
 wl-message-visible-field-list
 '("^\\(To\\|Cc\\):"
   
   "^Subject:"
   "^\\(From\\|Reply-To\\):"
   "^Organization:"
   "^Message-Id:"
   "^\\(Posted\\|Date\\):"
   )
 wl-message-sort-field-list
 '("^From"
   
   "^Organization:"
   "^X-Attribution:"
   "^Subject"
   "^Date"
   "^To"
   "^Cc"))
(setq wl-draft-always-delete-myself t)
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "rayners"
      wl-smtp-posting-server "smtp.gmail.com"
      wl-local-domain "gmail.com")
(setq elmo-imap4-default-server "imap.gmail.com")
(setq elmo-imap4-default-user "rayners@gmail.com") 
(setq elmo-imap4-default-authenticate-type 'clear)
(setq elmo-imap4-default-port 993)
(setq elmo-imap4-default-stream-type 'ssl)
(setq elmo-imap4-use-modified-utf7 t)
(setq wl-default-folder "%[Gmail]/Important")
(setq wl-trash-folder "%[Gmail]/Trash")
(setq wl-default-spec "%")
(add-hook 'wl-hook 
	  (lambda ()
	    (require 'bbdb-wl)
	    (bbdb-wl-setup)
	    
	    ;; i don't want to store addresses from my mailing folders
	    (setq 
	     bbdb-wl-folder-regexp    ;; get addresses only from these folders
	     "^\.inbox$\\|^.sent")    ;;
	    ))

;; where deleted messages go
;;
;;  - Important deleted to Trash (so I have to take specific action to archive a message)
;;
;;  - Otherwise, the default is just to remove I think?
;;
(setq wl-dispose-folder-alist '(("^%[Gmail]/Important" . 'trash)))

;; keep the folder window around
(setq wl-stay-folder-window t
      wl-folder-window-width 40)
