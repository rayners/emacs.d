
; so it uses the right subversion/git/etc
(push "/opt/local/bin" exec-path)
(push "/usr/local/bin" exec-path)

(add-to-list 'exec-path (expand-file-name "~/perl5/perlbrew/bin"))

(setenv "PATH" (mapconcat 'identity exec-path ":"))
