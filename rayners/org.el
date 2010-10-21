
;; org-mode fanciness

; key bindings
(global-set-key (kbd "C-c a") 'org-agenda)      ;; Agenda
(global-set-key (kbd "C-c b") 'org-iswitchb)    ;; switch
(global-set-key (kbd "C-c r") 'org-capture)     ;; capture

; round clock times to 15m increments
(setq org-time-stamp-rounding-minutes (quote (1 15)))

; need to set the list of files
; first, shared files
(setq rayners/shared-org-files 
      (file-expand-wildcards "~/Dropbox/projects/*.org"))
; now the personal ones
(setq rayners/private-org-files 
      (file-expand-wildcards "~/Dropbox/org/*.org"))

;; build the list from the shared and private files
(setq org-agenda-files 
;      (append rayners/shared-org-files rayners/private-org-files))
      rayners/private-org-files)

;; be a little paranoid about saving org-mode buffers
(run-at-time "00:59" 3600 'org-save-all-org-buffers)

;; swiped, then edited from http://doc.norang.ca/org-mode.html
(setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
 (sequence "WAITING(w@/!)" "SOMEDAY(s!)" "|" "CANCELLED(c@/!)")
 (sequence "OPEN(O)" "|" "CLOSED(C)"))))

(setq org-todo-keyword-faces (quote (("TODO" :foreground "red" :weight bold)
 ("NEXT" :foreground "blue" :weight bold)
 ("DONE" :foreground "forest green" :weight bold)
 ("WAITING" :foreground "yellow" :weight bold)
 ("SOMEDAY" :foreground "goldenrod" :weight bold)
 ("CANCELLED" :foreground "orangered" :weight bold)
 ("OPEN" :foreground "magenta" :weight bold)
 ("CLOSED" :foreground "forest green" :weight bold))))

;; mobile settings
;; for mobileorg
;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/org/inbox.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

;; capture bits

(setq org-default-notes-file "~/Dropbox/org/notes.org")
(setq org-capture-templates
      '(("t" "Todo" entry (file "")
	 "* TODO %?\n  %i\n  %a")
	("p" "Phone call" entry (file "")
	 "* TODO %? :PHONE:\n  %i\n  %a")
	))

(setq org-tag-alist '(("PHONE" . ?P) 
		      ("REFILE" . ?R)))
(setq org-tag-faces '(("PHONE" :foreground "green" :weight bold)
		      ("REFILE" :foreground "red" :weight bold)))

(setq org-agenda-custom-commands
      '(
	("p" "Phone Calls" tags-todo "PHONE"
	 ((org-agenda-overriding-header "Phone Calls"))
	 )
	("r" "Items to refile" tags "REFILE" ;; tags means include done items
	 ((org-agenda-overriding-header "Items to Refile"))
	 )
	("G" "Geektool agenda"
	 ((agenda "")
	  (alltodo))
	 ((org-agenda-ndays 1)
	  (org-deadline-warning-days 7))
	 ("~/agenda.txt"))
	))

;; Remove completed deadline tasks from the agenda view
(setq org-agenda-skip-deadline-if-done t)

;; Remove completed scheduled tasks from the agenda view
(setq org-agenda-skip-scheduled-if-done t)

;; Remove completed items from search results
(setq org-agenda-skip-timestamp-if-done t)

;; Diary bits
(setq org-agenda-include-diary nil)
(setq org-agenda-diary-file "~/Dropbox/org/diary.org")

;; refile-y bits
(setq org-refile-targets 
      '((org-agenda-files :maxlevel . 5) ;; use the files from the agenda list
	(nil :maxlevel . 5)))            ;; as well as stuff from current buffer

(setq org-refile-use-outline-path 'file)

;; update appt each time agenda opened
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)
