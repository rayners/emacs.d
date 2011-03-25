
;; swiped from http://tsdh.wordpress.com/2007/08/14/directory-local-variables/
(defvar th-dir-local-variables-alist
  '(("~/repos/gnus/" . ((indent-tabs-mode . t)
                        (tab-width . 8))))
  "An alist with (PATH . LIST) pairs.  PATH is a path and LIST is
a list of variables to set locally for files below that path.  It
has elements of the form (VAR . VAL) where VAR is a symbol and
VAL is its value.")

(defun th-set-dir-local-variables ()
  "Locally set the variables defined in
`th-dir-local-variables-alist' for the current buffer."
  (interactive)
  (let ((file (buffer-file-name (current-buffer))))
    (when file
      (dolist (pair th-dir-local-variables-alist)
        (when (string-match (concat "^" (regexp-quote (expand-file-name (car pair))))
                            file)
          (dolist (var (cdr pair))
            (if (local-variable-if-set-p (car var))
                (set (car var) (cdr var))
              (set (make-local-variable (car var)) (cdr var)))))))))

(add-hook 'find-file-hook
          'th-set-dir-local-variables)

; now set my own bits
(setq th-dir-local-variables-alist
      '(("~/repositories/buzzfeed" . ((perltidy-bin . "perltidy -q -buzzfeed")))))
