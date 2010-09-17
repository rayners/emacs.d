
;; org-mode fanciness

; round clock times to 15m increments
(setq org-time-stamp-rounding-minutes (quote (1 15)))

; need to set the list of files
; first, shared files
(setq rayners/shared-org-files 
      (file-expand-wildcards "~/Dropbox/projects/*.org"))
; now the personal ones
(setq rayners/private-org-files 
      (file-expand-wildcards "~/Dropbox/org/*.org"))

(setq org-agenda-files 
      (append rayners/shared-org-files rayners/private-org-files))
