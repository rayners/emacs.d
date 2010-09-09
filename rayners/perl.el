
(autoload 'perlcritic        "perlcritic" "" t)
(autoload 'perlcritic-region "perlcritic" "" t)
(autoload 'perlcritic-mode   "perlcritic" "" t)

(eval-after-load "cperl-mode"
  '(add-hook 'cperl-mode-hook 'perlcritic-mode))

;; need to add some perltidy bits in here too
