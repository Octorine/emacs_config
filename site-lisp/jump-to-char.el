(defun jump-to-char
    (prefix c)
  "Jump forwards or backwars to the specified character"
  (interactive "p\nc")
  (let* ((times (if prefix prefix 1))
	 (direction (if (< prefix 0) -1 1))
	 (beg (line-beginning-position))
	 (end (line-end-position))
	 (is-in-line
	  (lambda ()
	    (if (> direction 0)
		(< (point) end)
	      (> (point) beg)))))
    (dotimes (count (* direction times))
      (if (funcall is-in-line) (forward-char direction))
      (while (and (funcall is-in-line) (/= c (char-after)))
	(forward-char direction)))))

(global-set-key (kbd "C-j") 'jump-to-char)
	       
	       
