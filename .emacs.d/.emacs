(add-to-list 'load-path "~/.config/emacs")

;; PACKAGES
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Macaulay 2 start
(load "~/.emacs.d/emacs-Macaulay2" t)
;; Macaulay 2 end

;; AUTOCOMPLETION
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; UI ELEMENTS
(setq inhibit-startup-message t)
(setq default-frame-alist '((font . "APL386 Nerd Font-18")
			    (undecorated-round . 1)
                            (drag-internal-border . 1)
            			    (internal-border-width . 5)))
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config))

;; EDITOR OPTIONS
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq make-backup-files nil)

;; COLORSCHEME
(load-theme 'catppuccin t)

(defun set-catppuccin-flavour (appearance)
  (pcase appearance
    ('light (progn
	      (setq catppuccin-flavor 'latte)
	      (catppuccin-reload)))
    ('dark (progn
	     (setq catppuccin-flavor 'mocha)
	     (catppuccin-reload)))))

(add-hook 'ns-system-appearance-change-functions #'set-catppuccin-flavour)

;; CUSTOM SET
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(spaceline catppuccin-theme leaf nord-theme smex magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
