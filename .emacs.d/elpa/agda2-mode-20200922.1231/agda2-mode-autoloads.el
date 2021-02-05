;;; agda2-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "agda-input" "agda-input.el" (0 0 0 0))
;;; Generated autoloads from agda-input.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "agda-input" '("agda-input-")))

;;;***

;;;### (autoloads nil "agda2" "agda2.el" (0 0 0 0))
;;; Generated autoloads from agda2.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "agda2" '("agda2-directory")))

;;;***

;;;### (autoloads nil "agda2-abbrevs" "agda2-abbrevs.el" (0 0 0 0))
;;; Generated autoloads from agda2-abbrevs.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "agda2-abbrevs" '("agda2-")))

;;;***

;;;### (autoloads nil "agda2-highlight" "agda2-highlight.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from agda2-highlight.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "agda2-highlight" '("agda2-highlight-")))

;;;***

;;;### (autoloads nil "agda2-mode" "agda2-mode.el" (0 0 0 0))
;;; Generated autoloads from agda2-mode.el

(add-to-list 'auto-mode-alist '("\\.l?agda\\'" . agda2-mode))

(modify-coding-system-alist 'file "\\.l?agda\\'" 'utf-8)

(autoload 'agda2-mode "agda2-mode" "\
Major mode for Agda files.

The following paragraph does not apply to Emacs 23 or newer.

  Note that when this mode is activated the default font of the
  current frame is changed to the fontset `agda2-fontset-name'.
  The reason is that Agda programs often use mathematical symbols
  and other Unicode characters, so we try to provide a suitable
  default font setting, which can display many of the characters
  encountered. If you prefer to use your own settings, set
  `agda2-fontset-name' to nil.

Special commands:
\\{agda2-mode-map}

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "agda2-mode" '("agda2-")))

;;;***

;;;### (autoloads nil "agda2-queue" "agda2-queue.el" (0 0 0 0))
;;; Generated autoloads from agda2-queue.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "agda2-queue" '("agda2-queue-")))

;;;***

;;;### (autoloads nil nil ("agda2-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; agda2-mode-autoloads.el ends here
