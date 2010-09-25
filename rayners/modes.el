
;; use cperl-mode instead of perl-mode because it's fancier
(defalias 'perl-mode 'cperl-mode)

;; perl tests
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))

;; MT templates are HTML-ish files
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.mtml$" . html-mode))

;; yaml files
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

