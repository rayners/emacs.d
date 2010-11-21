;;; perltidy-mode.el --- Minor mode to automatically perltidy.

;;; Perltidy is a program that is available on CPAN.

;;; Copyright 2006 Joshua ben Jore

;;; Author: Joshua ben Jore <jjore@cpan.org>
;;; Version: 0.02
;;; CVS Version: $Id$
;;; Keywords: perl perltidy
;;; X-URL: http://search.cpan.org/~jjore/perltidy-mode/

;;; This program is free software; you can redistribute it and/or
;;; modify it under the same terms as Perl itself.

;;; To install this first generate your perltidy-mode.el file by running
;;; perltidy-mode.PL with your copy of perl. Copy the generated perltidy-mode.el to
;;; your ~/.site-lisp/ directory or a different preferred location.
;;; 
;;; Add the following lines to your .emacs file to inform emacs of the directory
;;; and of the two main functions provided by this library.
;;;
;;;   (add-to-list 'load-path "~/.site-lisp/")
;;;   (autoload 'perltidy "perltidy-mode" nil t)
;;;   (autoload 'perltidy-mode "perltidy-mode" nil t)
;;;
;;; Add the following snippet to enable full-auto mode.
;;;
;;;   (eval-after-load "cperl-mode"
;;;     '(add-hook 'cperl-mode-hook 'perltidy-mode))
;;;
;;; Add the following snippet to set the C-ct key sequence to trigger
;;; perltidy.
;;;
;;;   ; Run perltidy when the C-ct key sequence is used.
;;;   (global-set-key "\C-ct" 'perltidy)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                              Perltidy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar perltidy-bin "perltidy -q"
  "The command to run perltidy.")

(defmacro mark-active ()
  "Xemacs/emacs compatibility macro. It returns either nil or non-nil
and there are no guarantees about what constitutes \"non-nil\"."
  (if (boundp 'mark-active)
      `mark-active
    `(mark)))

(defun perltidy (start-in end-in)
  "Run perltidy on the current region or buffer."
  (interactive "r")

  (let ((start (or start-in (point-min)))
        (end   (or end-in   (point-max)))
        (original-line (point->line (point)))
        (error-buffer (get-buffer-create "*perltidy-errors*")))

    ; Clear the error buffer if needed.
    (or (zerop (buffer-size error-buffer))
        (save-excursion (set-buffer error-buffer)
                        (erase-buffer)))

    ; Inexplicably, save-excursion doesn't work to restore the
    ; point. I'm using it to restore the mark and point and manually
    ; navigating to the proper new-line.
    (let ((result
           (save-excursion
             (if (zerop (shell-command-on-region
                         start end
                         perltidy-bin t t error-buffer))

                 ; Success! Clean up.
                 (progn 
                   (kill-buffer error-buffer)
                   t)

               ; Oops! Show our error and give back the text that
               ; shell-command-on-region stole.
               (progn (undo)
                      (display-buffer error-buffer)
                      nil)))))

      ; This goto-line is outside the save-excursion becuase it'd get
      ; removed otherwise.  I hate this bug. It makes things so ugly.
      (goto-line original-line)
      result)))


(defun point->line (point)
  "Get the line number that POINT is on."
  ; I'm not bothering to use save-excursion because I think I'm
  ; calling this function from inside other things that are likely to
  ; use that and all I really need to do is restore my current
  ; point. So that's what I'm doing manually.
  (let ((line 1)
        (original-point (point)))
    (goto-char (point-min))
    (while (< (point) point)
      (incf line)
      (forward-line))
    (goto-char original-point)
    line))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                         Automatic perltidy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar perltidy-mode nil
  "Automatically `perltidy' when saving.")
(make-variable-buffer-local 'perltidy-mode)

(defun perltidy-write-hook ()
  "Perltidys a buffer during `write-file-hooks' for
`perltidy-mode'. If perltidy returns nil then the buffer isn't saved."
  (if perltidy-mode
      (save-restriction
        (widen)
        ; Impede the save if perltidy is false.
        (not (perltidy (point-min) (point-max))))
    ; Don't impede the save.
    nil))

(defun perltidy-mode (&optional arg)
  "Perltidy minor mode."
  (interactive "P")

  ; Cargo-culted from the Extending Emacs book.
  (setq perltidy-mode (if (null arg)
                          ; Toggle it on and off.
                          (not perltidy-mode)
                        ; Enable if >0.
                        (> (prefix-numeric-value arg) 0)))
  
  (add-hook 'write-file-hooks 'perltidy-write-hook nil t))
;  (make-local-hook 'write-file-hooks)
;  (funcall (if perltidy-mode #'add-hook #'remove-hook)
;           'write-file-hooks 'perltidy-write-hook))

; Add this to the list of minor modes.
(if (not (assq 'perltidy-mode minor-mode-alist))
    (setq minor-mode-alist
          (cons '(perltidy-mode " Perltidy")
                minor-mode-alist)))

(provide 'perltidy-mode)

;;; perltidy-mode.el ends here
