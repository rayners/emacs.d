
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
      (append rayners/shared-org-files rayners/private-org-files))

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
