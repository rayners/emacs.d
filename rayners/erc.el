
(setq erc-nick "rayners")
(setq erc-user-full-name "David Raynes")

; don't automatically reconnect
; it's kind of annoying
; plus I might not be back on the VPN
(setq erc-server-auto-reconnect nil)

(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?

    (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6667 :nick "rayners" :full-name "David Raynes"))))

;  Need a way to detect VPN being on or something
;      (erc :server "irc.gimp.org" :port 6667 :nick "foo" :full-name "bar"))))

;; switch to ERC with Ctrl+c e
(global-set-key (kbd "C-c e") 'djcb-erc-start-or-switch) ;; ERC

;; Nickserv bits

(require 'erc-services)
(erc-services-mode 1)
(setq erc-prompt-for-nickserv-password nil)
(load "rayners/private")
;; originally, I had rayners-freenode-password variable set in private.el
;; but I couldn't seem to get it to work as a variable instead of just a string
;; so I just define the whole erc-nickserv-passwords variable in there now
;; have to play with that later
;(setq erc-nickserv-passwords 
;      '((freenode     (("rayners" . ,rayners-freenode-password))
;		      )))
;		       ("nick-two" . "password")))
;	(DALnet       (("nickname" . "password")))))

;; we don't need *everything* to trigger a "something new in this channel" alert
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                    "324" "329" "332" "333" "353" "477"))
