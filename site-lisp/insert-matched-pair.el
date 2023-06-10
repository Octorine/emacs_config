;; Set up a keybind to insert matched characters like (), [],
;; or {}.  If there is an active region, surround it with the
;; characters.

(defun insert-pair-{} ()
  "Insert a pair of {} brackets and position the cursor inside."
  (interactive)
  		  (insert "{\n\n}")
		  (previous-line))
(defun insert-pair-parens ()
  "Insert a pair of () brackets and position the cursor inside."
  (interactive)
  		  (insert "()")
		  (backward-char))

(global-set-key (kbd "C-c b (") 'insert-pair-parens)

(defun insert-pair-{} ()
  "Insert a pair of {} brackets and position the cursor inside."
  (interactive)
  		  (insert "{\n\n}")
		  (previous-line)
		  (indent-for-tab-command))

(global-set-key (kbd "C-c b {") 'insert-pair-{})
