(autoload 'perlcritic        "perlcritic" "" t)
(autoload 'perlcritic-region "perlcritic" "" t)
(autoload 'perlcritic-mode   "perlcritic" "" t)

(eval-after-load "cperl-mode"
  '(add-hook 'cperl-mode-hook 'perlcritic-mode))

;; need to add some perltidy bits in here too
(autoload 'perltidy      "perltidy-mode" nil t)
(autoload 'perltidy-mode "perltidy-mode" nil t)

;; only use perltidy on my personal laptop
;; for now, until I come up with a better way to turn it off
;; for certain directories/buffers/etc
(if (string= "Bruce-Wayne.local" (system-name))
    (eval-after-load "cperl-mode"
      '(add-hook 'cperl-mode-hook 'perltidy-mode)))

(global-set-key "\C-ct" 'perltidy)

; normal perltidy settings
(setq perltidy-bin "perltidy -q -pbp")

;; creating a header-line with the current method
(defun rayners/current-defun ()
  (save-excursion
    (beginning-of-defun)

    (if (looking-at "^sub \\([A-Za-z_0-9]+\\).*")
        (match-string 1))))

(eval-after-load "cperl-mode"
  '(add-hook 'cperl-mode-hook (lambda ()
                                (setq header-line-format '(:eval (rayners/current-defun))))))

;; use cperl-mode instead of perl-mode because it's fancier
(defalias 'perl-mode 'cperl-mode)

;; perl tests
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))
