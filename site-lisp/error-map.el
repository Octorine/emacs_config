(defun transiant-error-map ()
  (set-temporary-overlay-map
   (let ((map (make-sparse-keymap)))
     (define-key map (kbd "E") 'flymake-show-project-diagnostics)
     (define-key map (kbd "[") 'my-prev-error)
     (define-key map (kbd "]") 'my-next-error)
     map)))



(defun my-next-error ()
  "Go to the next flymake error and set a temporary keybinding to jump between errors with []"
  (interactive)
   (flymake-goto-next-error)
   (transiant-error-map))

(global-set-key (kbd "C-c e ]")
		'my-next-error)

(defun my-prev-error ()
  "Go to the previous flymake error and set a temporary keybinding to jump between errors with []"
    (interactive)
   (flymake-goto-prev-error)
   (transiant-error-map))

(global-set-key (kbd "C-c e [") 'my-prev-error)
