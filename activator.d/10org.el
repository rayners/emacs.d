(add-to-list 'el-get-sources 'org-mode)
;(vendor 'org)
;; org-mode fanciness

; key bindings
(global-set-key (kbd "C-c a") 'org-agenda)      ;; Agenda
(global-set-key (kbd "C-c b") 'org-iswitchb)    ;; switch
(global-set-key (kbd "C-c r") 'org-capture)     ;; capture

; round clock times to 15m increments
(setq org-time-stamp-rounding-minutes (quote (1 15)))

(setq org-clock-persist-file "~/Dropbox/org/org-clock-save.el")
(setq org-clock-persist t)
(org-clock-persistence-insinuate)

(require 'cl)
(defun rayners/org-files (directory)
  "Gets the org-mode files for a given directory"
  (let ((f (directory-files-and-attributes directory t "\.org$")))
    (remove-if 'file-symlink-p (mapcar 'car f)))) 
; is this a side effect of using Dropbox? the .#filename symlinks?

; need to set the list of files
; first, shared files
(setq rayners/shared-org-files 
      (file-expand-wildcards "~/Dropbox/projects/*.org"))
; now the personal ones
(setq rayners/private-org-files 
      (file-expand-wildcards "~/Dropbox/org/*.org"))

;; build the list from the shared and private files
(setq org-agenda-files (rayners/org-files "~/Dropbox/org"))

;; be a little paranoid about saving org-mode buffers
;; by saving all the org mode buffers *NOW*
;; and again every 15m
(run-at-time nil 900 'org-save-all-org-buffers)

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
	("a" "Appointment" entry (file "")
	 "* %? %^t")
	))

(setq org-tag-alist '(("PHONE" . ?P) 
		      ("REFILE" . ?R)
		      ("GROCERIES" . ?G)))
(setq org-tag-faces '(("PHONE" :foreground "blue" :weight bold)
		      ("REFILE" :foreground "red" :weight bold)
		      ("GROCERIES" :foreground "green" :weight bold)))

(setq org-agenda-custom-commands
      '(
	("p" "Phone Calls" tags-todo "PHONE"
	 ((org-agenda-overriding-header "Phone Calls"))
	 )
	("r" "Items to refile" tags "REFILE" ;; tags means include done items
	 ((org-agenda-overriding-header "Items to Refile"))
	 )
	("g" "Grocery list" tags-todo "GROCERIES"
	 ((org-agenda-overriding-header "Grocery List"))
	 )
	("G" "Geektool agenda"
	 ((agenda "")
	  (alltodo))
	 ((org-agenda-ndays 2)
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
(setq org-agenda-include-diary t)
(setq org-agenda-diary-file "~/Dropbox/org/diary.org")

;; refile-y bits
(setq org-refile-targets 
      '((org-agenda-files :maxlevel . 5) ;; use the files from the agenda list
	(nil :maxlevel . 5)))            ;; as well as stuff from current buffer

(setq org-refile-use-outline-path 'file)

(if (not noninteractive)
    (progn
      ;; update appt each time agenda opened
      (add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)
      (org-agenda-to-appt) ;; make sure it's run at least once
      ))


(setq org-agenda-ndays 1)
(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))

;; more keyboardy bits
(global-set-key (kbd "<f7> i") 'rayners/clock-in)
(global-set-key (kbd "<f7> o") 'rayners/clock-out)
(defun rayners/clock-in ()
  "Clock in, just like it says"
  (interactive)
  (org-clock-in '(4))) ;; clock in with prefix, so as to select

(defun rayners/clock-out ()
  "Clock out"
  (interactive)
  (when (org-clock-is-active)
    (org-clock-out)))
