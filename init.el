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
 '(package-selected-packages
   '(## use-package eglot rust-mode haskell-mode)))

;; disable the toolbar

(tool-bar-mode -1)

;; add site-list-directory

(add-to-list 'load-path  (concat user-emacs-directory  "site-lisp"))

;; Save backups in config folder

(setq backup-directory-alist `(("." . ,(file-name-as-directory (locate-user-emacs-file "backups")))))

;; scroll the screen in increments of one line

(setq scroll-step 1)

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
  (:map eglot-mode-map
  ("C-c a" . eglot-code-actions)
  ("C-c r n" . eglot-rename)
  ("C-c f" . eglot-format))
  :hook
  (eglot-managed-mode . (lambda () (eglot-inlay-hints-mode 0)))
  :custom
  (eglot-report-progress t))

(use-package haskell-mode
  :config
  (defun haskell-doctest
      ()
    "Run all doctests for haskell project"
    (interactive)
    (compile "cabal repl --with-ghc=doctest"))
  :bind (:map haskell-mode-map
	      ("C-c C-c t" . 'haskell-doctest))
  :hook
  ((haskell-mode . eglot-ensure)
   (haskell-mode . interactive-haskell-mode)))

(use-package rust-mode
	     :config
	     (setq rust-format-on-save t)
	     :hook
	     (rust-mode . eglot-ensure))

;;------------------------------------------------------------------------------
;; Global keybindings
;;------------------------------------------------------------------------------

(global-set-key (kbd "C-c K") 'eldoc-doc-buffer)
(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c E") 'flymake-show-project-diagnostics)
(global-set-key (kbd "C-c ^") 'beginning-of-line-text)
(global-set-key (kbd "C-c SPC") 'cycle-spacing)


(load-library "error-map")

(load-library "insert-matched-pair")

(load-library "jump-to-char")

(defun config ()
  "Go to the Emacs config folder"
  (interactive)
  (find-file user-emacs-directory))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
