;;------------------------------------------------------------------------------
;; Variables
;;------------------------------------------------------------------------------

(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(deeper-blue))
 '(inhibit-startup-screen t)
 '(ispell-dictionary nil)
 '(package-selected-packages '(## use-package eglot rust-mode haskell-mode)))

;; disable the toolbar

(tool-bar-mode -1)

;;------------------------------------------------------------------------------
;; Packages
;;------------------------------------------------------------------------------

;; Basic setup
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package eglot
  :bind
  ("C-c a" . eglot-code-actions)
  ("C-c g d" . xref-find-definitions)
  ("C-c r n" . eglot-rename)
  ("C-c f" . eglot-format)
  :custom
  (eglot-report-progress t))

(use-package haskell-mode
  :hook
  (haskell-mode . eglot-ensure))

(use-package rust-mode
	     :config
	     (rust-enable-format-on-save)
	     :hook
	     (rust-mode . eglot-ensure))

;;------------------------------------------------------------------------------
;; Global keybindings
;;------------------------------------------------------------------------------

(global-set-key (kbd "C-c K") 'eldoc-doc-buffer)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c E") 'flymake-show-project-diagnostics)


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

(global-set-key (kbd "C-c ^") 'beginning-of-line-text)

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

(defun config ()
  "Go to the Emacs config folder"
  (find-file user-emacs-directory))
