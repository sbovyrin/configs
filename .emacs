;; Todo:
;; - commands (like next-line and sim.)
;; - using abbrev
;; - tramp to edit a file remotely
;; - what is narrowing?
;; - expand-region
;; - undo-redo
;; - go to last change
;; - jump to any chars's pair in editor
;; - show occurences
;; - diff files
;; - files/buffers/recent navigation
;; - toggle in-editor terminal (also multi-term)
;; - comment line/s
;; - edit multiple word at onetime
;; - multiple cursors or multiline commands?
;; - snippets
;; - insert/change surrounded symbols
;; - toggle case
;; - rename/delete/move current file
;; - create new file/dir
;; - rename/delete/move dir
;; - transpose selected (forward/backward)
;; - clone line/s or char/s
;; - go to line number
;; - go to begin/end of line
;; - join line/s
;; - select line
;; - record actions and replay
;; - support editorconfig

;; Editor core
;; - performance
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(setq redisplay-dont-pause t)

;; - files behavior
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(global-auto-revert-mode t); refresh opened file when it changed
(set-default-coding-systems 'utf-8)
(setq vc-follow-symlinks t)


;; Editor UI
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(menu-bar-mode -1)
(global-display-line-numbers-mode t)
(column-number-mode t);; show column and line pos in statusbar

;; Command prompt behavior
(icomplete-mode t)

;; Editor behavior
(setq-default major-mode 'text-mode)
(set-fill-column 79) ;; set line width
(visual-line-mode t) ;; soft wrap too long line
(show-paren-mode t)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil) ;; use spaces instead of tabs
(delete-selection-mode 1) ;; delete selected text when typing
(setq require-final-newline t)
(subword-mode t) ;; enable moving over camelCase world correclty

;; WTF?
(setq custom-file "~/.emacs.d/custom.el")
;; add checking if exists
(load custom-file 'noerror)

;; Package manager
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(unless package--initialized (package-initialize))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-always-ensure t)

(use-package company
  :config
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  (add-hook 'after-init-hook 'global-company-mode))

(use-package company-flx
  :config
  (setq company-flx-limit 10)
  (company-flx-mode +1))

(use-package fzf)

(use-package lsp-mode
  :hook (php-mode . lsp-deferred)
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-response-timeout 4
        lsp-enable-completion-at-point t
        lsp-semantic-tokens-enable nil
        lsp-enable-xref nil
        lsp-enable-on-type-formatting nil
        lsp-file-watch-threshold 10000
        lsp-file-watchers-enable t
        lsp-headerline-breadcrumb-enable nil
        lsp-enable-text-document-color nil
        lsp-signature-auto-activate nil
        lsp-idle-delay 0.200
        lsp-log-io nil
        lsp-intelephense-completion-trigger-parameter-hints nil
        lsp-intelephense-completion-max-items 20
        lsp-intelephense-telemetry-enabled nil))
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.git\\'"))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Elisp
;(eldoc-mode t)
