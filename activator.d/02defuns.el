
;; swiped from http://github.com/defunkt/emacs/blob/master/defunkt/defuns.el
;; and modified

; for loading libraries in from the vendor directory
(defun vendor (library)
  (let* ((file (symbol-name library))
         (normal (concat "~/.emacs.d/vendor/" file))
         (suffix (concat normal ".el"))
         (rayners (concat "~/.emacs.d/rayners/" file)))
    (cond
     ((file-directory-p normal) (add-to-list 'load-path normal) (require library))
     ((file-directory-p suffix) (add-to-list 'load-path suffix) (require library))
     ((file-exists-p suffix) (require library)))
    (when (file-exists-p (concat rayners ".el"))
      (load rayners))))

(setq rayners/private-directory (expand-file-name "~/Dropbox/emacs-private"))
(defun private (library)
  (load (concat rayners/private-directory "/" (symbol-name library) ".el")))

    
