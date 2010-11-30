
(setq erc-nick "rayners")
(setq erc-user-full-name "David Raynes")

; don't automatically reconnect
; it's kind of annoying
; plus I might not be back on the VPN
(setq erc-server-auto-reconnect nil)

;(setq rayners/which-irc 'rcirc)
(setq rayners/which-irc 'erc)
(setq rayners/freenode-channels 
      '("#git" "#emacs" "#perl" "#movabletype" "#movabletype-talk" "#openmelody" "#zsh"))
(cond ((eq rayners/which-irc 'rcirc)
       (add-to-list 'rayners/freenode-channels "#rcirc"))
      ((eq rayners/which-irc 'erc)
       (add-to-list 'rayners/freenode-channels "#erc")))

(load "rayners/private/irc.el")

; channels should be all setup now
; erc needs the channels set, by server, it erc-autojoin-channels-alist
(if (eq rayners/which-irc 'erc)
    (setq erc-autojoin-channels-alist `(("freenode.net" ,@rayners/freenode-channels))))
;    (progn
;      (setq erc-autojoin-channels-alist '())
;      (add-to-list
;       'erc-autojoin-channels-alist 
;       ((append '("freenode.net") rayners/freenode-channels)))))

(defun rayners/freenode-connect ()
  "Connect to freenode.net"
  (interactive)
  (cond ((eq rayners/which-irc 'rcirc)
	 (rcirc-connect "irc.freenode.net" "6667" 
			"rayners" "rayners" "David Raynes" 
			rayners/freenode-channels))
	((eq rayners/which-irc 'erc)
	 (erc :server "irc.freenode.net" :port 6667 :nick "rayners" :full-name "David Raynes"
))))
(global-set-key (kbd "C-c I f") 'rayners/freenode-connect)

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

;; rcirc bits, in case I decide to permanently switch
(setq rcirc-default-nick "rayners")
(setq rcirc-default-user-name "rayners")
(setq rcirc-default-full-name "David Raynes")

(add-hook 'rcirc-mode-hook
	  (lambda ()
	    (rcirc-track-minor-mode 1)))

(setq rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY"))

;; spelling bits
(add-hook 'rcirc-mode-hook (lambda ()
			     (flyspell-mode 1)))
(erc-spelling-mode 1)

(eval-after-load 'rcirc
  '(defun-rcirc-command reconnect (arg)
     "Reconnect the server process."
     (interactive "i")
     (unless process
       (error "There's no process for this target"))
     (let* ((server (car (process-contact process)))
	    (port (process-contact process :service))
	    (nick (rcirc-nick process))
	    channels query-buffers)
       (dolist (buf (buffer-list))
	 (with-current-buffer buf
	   (when (eq process (rcirc-buffer-process))
	     (remove-hook 'change-major-mode-hook
			  'rcirc-change-major-mode-hook)
	     (if (rcirc-channel-p rcirc-target)
		 (setq channels (cons rcirc-target channels))
	       (setq query-buffers (cons buf query-buffers))))))
       (delete-process process)
       (rcirc-connect server port nick
		      rcirc-default-user-name
		      rcirc-default-user-full-name
		      channels))))

;; growl bits for erc
(require 'growl)
(defun rayners/growl-erc-hook (match-type nick message)
  "Basic growl notification when someone says my nick in an irc channel."
  ; skip if it's the user list
  (unless (posix-string-match "^\\** Users on #" message)
    (when (and
	   (eq match-type 'current-nick)
	   (not (eq (erc-extract-nick nick) erc-nick))) ; if I didn't say it
      (growl (concat "<irc> " (buffer-name (current-buffer)))
	     (concat "<" (erc-extract-nick nick) "> " message) "Colloquy"))))

(add-hook 'erc-text-matched-hook 'rayners/growl-erc-hook)

(defun rayners/growl-erc-private-hook (proc parsed)
  "Growl notification for private messages"
  (let ((nick (car (erc-parse-user (erc-response.sender parsed))))
	(target (car (erc-response.command-args parsed)))
	(msg (erc-response.contents parsed)))
    (when (and (erc-current-nick-p target)
	       (not (erc-is-message-ctcp-and-not-action-p msg)))
      (growl (concat "<irc> " nick ": ") msg "Colloquy")
      nil)))

(add-hook 'erc-server-PRIVMSG-functions 'rayners/growl-erc-private-hook)
