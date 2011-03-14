
(vendor 'jekyll)

(setq jekyll-directory (expand-file-name "~/Code/rayners-blog/"))

(global-set-key (kbd "C-c B n") 'jekyll-draft-post)
(global-set-key (kbd "C-c B P") 'jekyll-publish-post)
(global-set-key (kbd "C-c B p") (lambda () 
                                  (interactive)
				  (find-file jekyll-directory)))
(global-set-key (kbd "C-c B d") (lambda () 
				  (interactive)
				  (find-file jekyll-directory)))
