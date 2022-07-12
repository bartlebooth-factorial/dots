;;;
;;; init.el -- emacs startup file
;;;

;;; Appearance

(require-theme 'dracula-theme)
(load-theme 'dracula t)

(if (not (frame-parameter nil 'fullscreen)) (toggle-frame-fullscreen))

(set-face-attribute 'default nil :height 200)

(set-default 'truncate-lines t)

(display-time)

;;; Startup

(setq inhibit-startup-screen t)

(setq initial-scratch-message ";; Scratch\n\n")

;;; Options

(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "~/.emacs.d/backups"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)

(setq completion-styles '(basic substring partial-completion flex))
(setq completion-ignore-case t)

(setq display-time-default-load-average nil)
(setq display-time-day-and-date nil)

(setq inferior-lisp-program (executable-find "sbcl"))

(setq mac-command-modifier 'control)

;;; Keybinds

(global-set-key "f" 'toggle-frame-fullscreen)

(global-set-key "l" 'display-line-numbers-mode)

(global-set-key "" 'ibuffer-other-window)

;;; Modes

(blink-cursor-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)

(column-number-mode 1)
(electric-pair-mode 1)
(global-auto-revert-mode 1)
(recentf-mode 1)
(savehist-mode 1)
(show-paren-mode 1)

;;; Packages

(require 'package)

(add-to-list 'package-archives '("MELPA" . "http://melpa.org/packages/"))

(package-initialize)

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))

(use-package cape
  :ensure t
  :bind ("M-/" . cape-dabbrev))

(use-package captain
  :ensure t
  :init
  (setq sentence-end-double-space nil)
  :config
  (global-captain-mode 1)
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
  (setq corfu-auto t)
  (setq corfu-auto-delay 0.2)
  :config
  (global-corfu-mode 1))

(use-package darkroom
  :ensure t
  :bind ("C-c d" . darkroom-tentative-mode))

(use-package dired-hide-dotfiles
  :ensure t
  :config
  (dired-hide-dotfiles-mode 1))

(use-package ido-yes-or-no
  :ensure t
  :config
  (ido-yes-or-no-mode 1))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
	 ("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C->" . mc/mark-all-like-this)))

(use-package olivetti
  :ensure t
  :bind ("C-c o" . olivetti-mode))

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
	 ("C-r" . swiper-backward)))

(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

;;; Hooks

(add-hook 'org-mode-hook (lambda ()
			   (org-bullets-mode 1)
			   (org-indent-mode 1)
			   (setq captain-predicate
				 (lambda () (not (org-in-src-block-p))))
			   (local-set-key "" 'consult-recent-file)))

(add-hook 'prog-mode-hook (lambda ()
			    (setq-local completion-at-point-functions 'cape-dabbrev)
			    (setq captain-predicate
				  (lambda () (nth 8 (syntax-ppss (point)))))
			    (display-line-numbers-mode 1)))

(add-hook 'text-mode-hook (lambda ()
			    (setq captain-predicate
				  (lambda () t))
			    (local-set-key (kbd "M-/") 'cape-ispell)
			    (setq-local completion-at-point-functions 'cape-ispell)
			    (setq-local corfu-auto-delay 0.2)))

(add-hook 'doc-view-mode-hook (lambda ()
				(pdf-tools-install)))

(add-to-list 'auto-mode-alist
             '("\\.poem\\'" . (lambda ()
                                (text-mode)
				(olivetti-mode 1)
				(text-scale-adjust 1)
				(setq-local completion-at-point-functions nil))))

;;; Automated

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "#8be9fd" :slant normal))))
 '(font-lock-type-face ((t (:weight bold :slant normal :foreground "#2d93f9" :inherit font-lock-builtin-face))))
 '(font-lock-variable-name-face ((t (:foreground "#f8f8f2" :weight normal))))
 '(fountain ((t (:height 1.2 :family "Courier"))))
 '(line-number ((t (:background "#282a36" :foreground "#565761" :slant normal)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5283a0c77cc7640fc28493cfdf8957b11e1c72af846d96f5e5a6a37432264c34" "1436985fac77baf06193993d88fa7d6b358ad7d600c1e52d12e64a2f07f07176" "0f2f1feff73a80556c8c228396d76c1a0342eb4eefd00f881b91e26a14c5b62a" "3d4df186126c347e002c8366d32016948068d2e9198c496093a96775cc3b3eaa" "57a29645c35ae5ce1660d5987d3da5869b048477a7801ce7ab57bfb25ce12d3e" "2d035eb93f92384d11f18ed00930e5cc9964281915689fa035719cab71766a15" "e983c35ab806b2b6e442e7b45032694b303a2abde663fee376c2d809fd5ea210" "0dd2666921bd4c651c7f8a724b3416e95228a13fca1aa27dc0022f4e023bf197" "b73a23e836b3122637563ad37ae8c7533121c2ac2c8f7c87b381dd7322714cd0" "56db2719e8649367de50bfd5137e0202bb7142beefa85c927f0b18fe5fa4c9b1" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "22f080367d0b7da6012d01a8cd672289b1debfb55a76ecdb08491181dcb29626" default))
 '(eww-download-directory "~/downloads")
 '(initial-frame-alist '((fullscreen . maximized)))
 '(olivetti-style 'fancy)
 '(package-selected-packages
   '(clang-capf swiper pabbrev gotham-theme consult use-package marginalia vertico projectile multiple-cursors sly ilist ido-yes-or-no corfu pdf-tools dired-hide-dotfiles paren-completer vterm forecast fontaine fontsloth markdown-preview-mode darkroom org-bullets flycheck-aspell olivetti pylint vundo fountain-mode markdown-mode poetry centered-cursor-mode ace-window ag chess c-eval go-mode lua-mode magit academic-phrases evil dracula-theme captain cape beacon modus-operandi-theme which-key))
 '(ring-bell-function 'ignore)
 '(send-mail-function 'mailclient-send-it)
 '(warning-suppress-types '((use-package) (comp))))
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'upcase-region 'disabled nil)
