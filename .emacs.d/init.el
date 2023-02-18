;;;
;;; init.el -- emacs startup file
;;;

;;; Appearance

(require-theme 'ef-themes)
(load-theme 'ef-night t)

(if (not (frame-parameter nil 'fullscreen))
    (toggle-frame-fullscreen))

(set-face-attribute 'default nil :height 220)

(set-default 'truncate-lines t)

(display-time)

;;; Options

(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq completion-ignore-case t)
(setq completion-styles '(basic substring partial-completion flex initials orderless))
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(setq delete-old-versions t)
(setq display-time-day-and-date nil)
(setq display-time-default-load-average nil)
(setq global-auto-revert-non-file-buffers t)
(setq inferior-lisp-program (executable-find "sbcl"))
(setq inhibit-startup-screen t)
(setq initial-scratch-message ";; Scratch\n\n")
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq load-path (append '("/opt/homebrew/share/emacs/site-lisp/lilypond") load-path))
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
(setq use-dialog-box nil)
(setq version-control t)

;;; Keybinds

(global-set-key "f" 'toggle-frame-fullscreen)
(global-set-key "l" 'display-line-numbers-mode)
(global-set-key "" 'ibuffer-other-window)

;;; Modes

(blink-cursor-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(size-indication-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)

(column-number-mode 1)
(display-battery-mode 1)
(electric-pair-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
(savehist-mode 1)
(show-paren-mode 1)

;;; Loads

(load custom-file 'noerror 'nomessage)
(load-file "/opt/homebrew/share/emacs/site-lisp/lilypond/lilypond-init.el")
(eval-after-load 'flycheck '(require 'flycheck-lilypond))

;;; Packages

(require 'package)

(add-to-list 'package-archives '("MELPA" . "http://melpa.org/packages/"))

(package-initialize)

(use-package accent
  :ensure t
  :bind ("C-x C-a" . accent-menu))

(use-package ace-window
  :ensure t)

(use-package beginend
  :ensure t
  :config
  (beginend-global-mode 1))

(use-package cape
  :ensure t
  :bind ("M-/" . cape-dabbrev))

(use-package captain
  :ensure t
  :init
  (setq sentence-end-double-space nil)
  :config
  (global-captain-mode 0)
  :bind ("C-c u" . captain-capitalize-word))

(use-package centered-cursor-mode
  :ensure t
  :bind ("C-c c" . centered-cursor-mode))

(use-package consult
  :ensure t
  :bind (("C-c b" . consult-buffer)
	 ("C-c C-f" . consult-recent-file)
	 ("C-c C-l" . consult-line)
	 ("M-g g" . consult-goto-line)))

(use-package corfu
  :ensure t
  :init
  (setq corfu-auto nil)
  (setq corfu-auto-delay 0)
  :config
  (global-corfu-mode 1))

(use-package csv-mode
  :ensure t)

(use-package dired-hide-dotfiles
  :ensure t
  :config
  (dired-hide-dotfiles-mode 1))

(use-package ef-themes
  :ensure t)

(use-package eyebrowse
  :ensure t
  :config
  (eyebrowse-mode 1))

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

(use-package haskell-mode
  :ensure t)

(use-package ido-yes-or-no
  :ensure t
  :config
  (ido-yes-or-no-mode 1))

(use-package magit
  :ensure t)

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package markdown-mode
  :ensure t)

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c" . mc/edit-lines)
	 ("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C->" . mc/mark-all-like-this)))

(use-package neotree
  :ensure t)

(use-package olivetti
  :ensure t
  :bind ("C-c o" . olivetti-mode))

(use-package org-bullets
  :ensure t)

(use-package orderless
  :ensure t)

(use-package pabbrev
  :ensure t
  :config
  (setq pabbrev-idle-timer-verbose t)
  (global-pabbrev-mode 1))

(use-package pdf-tools
  :ensure t)

(use-package rainbow-mode
  :ensure t)

(use-package sly
  :ensure t)

(use-package swiper
  :ensure t)

(use-package tuareg
  :ensure t)

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package vterm
  :ensure t
  :config
  (setq vterm-timer-delay nil))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1))

;;; Hooks

(add-to-list 'auto-mode-alist
             '("\\.poem\\'" . (lambda ()
                                (text-mode)
				(olivetti-mode 1)
				(text-scale-adjust 1)
				(setq-local completion-at-point-functions nil))))

(add-hook 'c-mode-hook (lambda ()
			 (c-set-style "bsd")))

(add-hook 'dired-mode-hook (lambda ()
			     (beginend-dired-mode 1)
			     (local-set-key "," 'dired-hide-dotfiles-mode)))

(add-hook 'doc-view-mode-hook (lambda ()
				(pdf-tools-install)))

(add-hook 'LilyPond-mode-hook (lambda ()
				(flycheck-mode)))

(add-hook 'org-mode-hook (lambda ()
			   (org-bullets-mode 1)
			   (org-indent-mode 1)
			   (setq captain-predicate
				 (lambda () (not (org-in-src-block-p))))
			   (local-set-key "" 'consult-recent-file)))

(add-hook 'prog-mode-hook (lambda ()
			    (setq-local completion-at-point-functions '(cape-dabbrev cape-keyword))
			    (setq captain-predicate
				  (lambda () (nth 8 (syntax-ppss (point)))))
			    (display-line-numbers-mode 1)))

(add-hook 'text-mode-hook (lambda ()
			    (setq captain-predicate
				  (lambda () t))
			    (local-set-key (kbd "M-/") 'cape-ispell)
			    (setq-local completion-at-point-functions 'cape-ispell)
			    (setq-local corfu-auto t)
			    (setq-local corfu-auto-delay 0.2)))

