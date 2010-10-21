;; the appointment notification facility
(setq
 appt-message-warning-time 15 ;; warn 15 min in advance

 appt-display-mode-line t     ;; show in the modeline
 appt-display-format 'window) ;; use our func
(appt-activate 1)              ;; active appt (appointment notification)
(display-time)                 ;; time display is required for this...

(require 'growl)
;; our little façade-function for djcb-popup
(defun drr-appt-display (min-to-app new-time msg)
   (growl (format "Appointment in %s minute(s)" min-to-app) msg))

(setq appt-disp-window-function (function drr-appt-display))
