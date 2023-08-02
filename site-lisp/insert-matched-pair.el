;; Set up a keybind to insert matched characters like (), [],
;; or {}.  If there is an active region, surround it with the
;; characters.

(setq skeleton-pair t)
(setq skeleton-pair-alist
      '( (?\( . (_ ?\)))
	 (?\[ . (_ ?\]))
	 (?\{ . (\n > _ \n ?\}))
	 (?\" . (_ ?\"))
	 (?\' . (_ ?\'))
	 (?< . (_ ?>))))

(setq skeleton-pair-transient-map
      (make-sparse-keymap))
(mapcar
 (lambda (skeleton)
   (bind-key
    (string (car skeleton))
    'skeleton-pair-insert-maybe
   skeleton-pair-transient-map))
 skeleton-pair-alist)

(defun insert-matched-pair
    ()
  "Insert a matched pair from the skeleton-pair-alist"
  (interactive)
  (set-transient-map skeleton-pair-transient-map))
  
  

(global-set-key (kbd "C-c b") 'insert-matched-pair) 
