(setq user-full-name "Berto Yáñez"
      user-mail-address "berto@ber.to")

;; save the position of the cursor
(save-place-mode 1)

;; increase garbage collection
(setq-default gc-cons-threshold 20000000)

;; remove splash screen and set default mode
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; UTF-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Disable lockfiles
(setq create-lockfiles nil)

;; revert buffer if file has changed
(global-auto-revert-mode)

;; Remove menu bar and toolbar in GUI mode
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; select like other editors
(delete-selection-mode t)
(transient-mark-mode t)

;; use system clipboard
(setq select-enable-clipboard t)

;; show directories first in dired
(setq dired-listing-switches "-aBhl")

;; scroll to top and bottom more naturally
(setq scroll-error-top-bottom t)
(require 'view)
(setq scroll-step            1
      scroll-conservatively  10000)


;; show empty lines at the end
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; tabs as 2 spaces
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default sgml-basic-offset 2)

;; Place all the backups in one directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; save history
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; Fastest input
(fset 'yes-or-no-p 'y-or-n-p)

;; Disable bell
(setq ring-bell-function 'ignore)

;; echo keybindings to minibuffer faster
(setq echo-keystrokes 0.1
      use-dialog-box nil)

;; highlight parens
(show-paren-mode t)

;; line spacing
(setq-default line-spacing 0)

;; line spacing
(setq-default line-spacing 0)

;; use ibuffer C-x C-b
(defalias 'list-buffers 'ibuffer)

;; default TRAMP
(setq tramp-default-method "ssh")

;; Remove spaces and tabs on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'untabify)

;; Better defaults
(setq save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      ediff-window-setup-function 'ediff-setup-windows-plain
      )

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)

;; Mouse pasting without moving the pointer
(setq mouse-yank-at-point t)

;;
;; GLOBAL KEYBINDINGS
;;

(global-set-key (kbd "C-:") 'comment-or-uncomment-region)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-unset-key "\C-z")
(global-unset-key "\C-x\C-z")
(global-set-key (kbd "M-z") 'zap-up-to-char)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "C-v")   'View-scroll-half-page-forward)
(global-set-key (kbd "M-v")   'View-scroll-half-page-backward)

;;
;; PACKAGE STUFF
;;

;; Init package stuff
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)

;; Install 'use-package' if necessary
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Load use-package and friends
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

;; large file warning (10MB)
(setq large-file-warning-threshold 10000000)

;;
;; PACKAGES
;;

(use-package dash
  :ensure t)

(when (fboundp 'winner-mode)
  (winner-mode 1))

(use-package flycheck
  :ensure t
  :config
  (setq flycheck-check-syntax-automatically '(mode-enabled save idle-change))
  (setq flycheck-idle-change-delay 5)
  (add-hook 'prog-mode-hook 'global-flycheck-mode)
  (setq-default flycheck-disabled-checkers '(javascript-jshint json-jsonlist))
  )

(use-package hl-line
  :config
  ;; Highlight the line only in the active window
  (setq hl-line-sticky-flag nil)

  ;; hl-line+
  ;; http://www.emacswiki.org/emacs/hl-line+.el
  (use-package hl-line+
    :ensure t
    :config
    (toggle-hl-line-when-idle 1) ; Highlight line only when idle
    ;; Number of seconds of idle time after when the line should be highlighted
    (setq hl-line-idle-interval 3)
    ;; Number of seconds for `hl-line-flash' to highlight the line
    (setq hl-line-flash-show-period 3))
  )


;; Project management.
(use-package projectile
  :ensure t
  :commands (projectile-find-file projectile-switch-project)
  :diminish projectile-mode
  :config
  (setq projectile-enable-caching t)
  (projectile-mode)
  )


(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  )

(use-package emmet-mode
  :ensure t
  :init
  (add-hook 'web-mode-hook 'emmet-mode)
  (add-hook 'js2-mode-hook 'emmet-mode)
  :config
  (setq emmet-expand-jsx-className? t)
  (setq emmet-move-cursor-between-quotes t)
  )

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown")
  )

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init (yas-global-mode 1))

;;; load yasnippet before auto-complete
(defadvice ac-common-setup (after give-yasnippet-highest-priority activate)
  (setq ac-sources (delq 'ac-source-yasnippet ac-sources))
  (add-to-list 'ac-sources 'ac-source-yasnippet))

(use-package org
  :ensure t
  :defer t
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c l" . org-store-link)
         ("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb)
         ("C-c C-w" . org-refile)
         ("C-c j" . org-clock-goto)
         ("C-c C-x C-o" . org-clock-out)
         )
  :init
  (setq org-todo-keywords
        '((sequence "TODO" "WAITING" "VERIFY" "|" "DONE")))

  (setq org-todo-keyword-faces
        '(("TODO" . "#CC1B44")
          ("VERIFY" . "#C97F50")
          ("WAITING" . "#E0EBD1")
          ("DONE" . "#9BA607")
          )
        )

  ;;set priority range from A to C with default A
  (setq org-highest-priority ?A)
  (setq org-lowest-priority ?C)
  (setq org-default-priority ?A)

  ;;set colours for priorities
  (setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
                             (?B . (:foreground "LightSteelBlue"))
                             (?C . (:foreground "OliveDrab"))))

  ;;open agenda in current window
  (setq org-agenda-window-setup (quote current-window))

  ;;capture todo items using C-c c t
  ;; (define-key global-map (kbd "C-c c") 'org-capture)
  (setq org-capture-templates
        '(("t" "todo" entry (file+headline "~/Dropbox/Org/Notes.org" "Tasks")
           "* TODO [#A] %?")))

  :config
  (setq org-outline-path-complete-in-steps t)
  (setq org-catch-invisible-edits t)
  (setq org-directory "~/Dropbox/Org")
  (setq org-agenda-files '("~/Dropbox/Org"))
  (setq org-default-notes-file (concat org-directory "~/Dropbox/Org/Notes.org"))
  (setq org-mobile-inbox-for-pull (concat org-directory "~/Dropbox/Org/Notes.org"))
  )

(use-package org-bullets
  :ensure t
  :commands (org-bullets-mode)
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package prettier-js
  :ensure t
  :config
  (setq prettier-js-args '(
                           "--tab-width" "2"
                           "--single-quote"
                           "--jsx-bracket-same-line"
                           ))
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  )

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region))
  )


(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")

  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))  
  )

(use-package recentf
  :ensure t
  :config
  (setq recentf-max-menu-items 25)
  (setq recentf-exclude '("[/\\]\\.elpa/" "[/\\]\\.git/"))
  (recentf-mode 1)
  )

(use-package ace-window
  :ensure t
  :bind
  ("C-x o" . ace-window)
  :init
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 2.0)))))

  (setq aw-background t)
  )

(use-package iedit
  :ensure t)

(use-package scss-mode
  :ensure t
  :mode "\\.scss\\'"
  )

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :init
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)
  :config
  (sp-local-pair 'js2-mode "{" nil :post-handlers '(:add ("||\n[i]" "RET")))
  (add-hook 'sgml-mode  'smartparens-mode)
  (add-hook 'js2-mode  'smartparens-mode)
  :bind
  ("C-M-k" . sp-kill-sexp)
  ("C-M-f" . sp-forward-sexp)
  ("C-M-b" . sp-backward-sexp)
  ("C-M-n" . sp-up-sexp)
  ("C-M-d" . sp-down-sexp)
  ("C-M-u" . sp-backward-up-sexp)
  ("C-M-p" . sp-backward-down-sexp)
  ("C-M-w" . sp-copy-sexp)
  )
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package web-mode
  :ensure t
  :mode ("\\.html\\'"
         "\\.css\\'"
         "\\.php\\'")
  :init
  (setq-default
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-enable-auto-closing t
   web-mode-enable-auto-opening t
   web-mode-enable-auto-quoting nil
   web-mode-enable-auto-indentation t))

(use-package js2-mode
  :ensure t
  :mode (
         ("\\.js\\'" . js2-mode)
         ("\\.es6\\'" . js2-mode)
         )
  :init
  (add-hook 'js2-mode-hook (lambda ()
                             (js2-imenu-extras-mode)))
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
  :config
  (setq js2-basic-offset 2)
  (setq js2-highlight-level 3)
  (setq js2-mode-show-strict-warnings nil)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-idle-timer-delay 1)
  (setq js-indent-level 2)
  (setq js-switch-indent-offset 2)
  (setq js2-bounce-indent-p t)
  )

(use-package yaml-mode
  :ensure t
  :mode ("\\.yml$" . yaml-mode))

(use-package tern
  :if (executable-find "tern")
  :ensure t
  :diminish tern-mode
  :config
  (defun my-js-mode-hook ()
    "Hook for `js-mode'."
    (set (make-local-variable 'company-backends)
         '((company-tern company-files company-yasnippet))))
  (add-hook 'js2-mode-hook 'my-js-mode-hook)
  (add-hook 'js2-mode-hook 'company-mode)
  (add-hook 'js2-mode-hook 'tern-mode)
  )

(use-package company-tern
  :if (executable-find "tern")
  :ensure t
  :config
  ;; Disable completion keybindings, as we use xref-js2 instead
  (define-key tern-mode-keymap (kbd "M-.") nil)
  (define-key tern-mode-keymap (kbd "M-,") nil)
  )

(use-package indium
  :config (add-hook 'js2-mode-hook 'indium-interaction-mode))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init (load-theme 'sanityinc-tomorrow-night t)
  )

(use-package spaceline-config
  :ensure spaceline
  :init
  (setq ns-use-srgb-colorspace nil)
  (setq spaceline-minor-modes-p nil)
  :config
  (spaceline-emacs-theme))


(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config 
  (which-key-mode)
  )

(use-package drag-stuff
  :ensure t
  :diminish drag-stuff-mode
  :config
  (setq drag-stuff-modifier '(meta shift))
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys)
  )

(use-package magit
  :ensure t
  :defer 2
  :bind (("C-x g" . magit-status)))

(use-package avy
  :ensure t
  :bind (("C-_" . avy-goto-char-timer)))

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :bind
  ("C-s" . swiper)
  ("C-S-s" . swiper-all)
  ("C-r" . swiper)
  ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("M-y" . counsel-yank-pop)
  ("C-c s" . counsel-ag)
  ("C-c C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-height 15)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-re-builders-alist
        '((t   . ivy--regex-ignore-order)))
  )

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t)

(use-package counsel-projectile
  :ensure t
  :init
  (counsel-projectile-on)
  :bind
  ("M-p" . counsel-projectile-find-file)
  ("M-P" . counsel-projectile-switch-project)
  )

(use-package smex
  :ensure t
  :init
  (smex-initialize))

(use-package exec-path-from-shell
  :ensure t
  :init
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)
    (global-set-key (kbd "M-1") "|")
    (global-set-key (kbd "M-2") "@")
    (global-set-key (kbd "M-3") "#")
    (global-set-key (kbd "M-º") "\\")
    (global-set-key (kbd "M-ç") "}")
    (global-set-key (kbd "M-+") "]")
    (global-set-key (kbd "M-ñ") "~")
    )
  )

(use-package erc
  :init
  (use-package erc-truncate
    :config (add-to-list 'erc-modules 'truncate))
  (use-package erc-autoaway
    :config (add-to-list 'erc-modules 'autoaway))
  (use-package erc-notifications
    :config (add-to-list 'erc-modules 'notifications))
  (use-package erc-track
    :config (erc-track-mode 1))
  :config
  (defvar erc-autoaway-use-emacs-idle t)
  (setq erc-server-coding-system '(utf-8 . utf-8)
        erc-auto-discard-away t
        erc-autoaway-idle-seconds 600
        erc-interpret-mirc-color t
        erc-user-full-name "Berto Yáñez"
        erc-email-userid "berto@ber.to"
        erc-max-buffer-size 10000
        erc-hide-list '("JOIN" "PART" "QUIT" "NICK" "MODE")
        erc-auto-query 'buffer
        erc-server-auto-reconnect t
        erc-server-reconnect-attempts 5
        erc-server-reconnect-timeout 3
        erc-rename-buffers t
        erc-truncate-buffer-on-save t
        erc-hide-list '("PART" "QUIT" "JOIN")
        erc-autojoin-channels-alist '(("freenode.net"
                                       "#emacs-beginners"
                                       "#javascript"))
        erc-server "irc.freenode.net"
        erc-nick "bertez")

  (defvar erc-insert-post-hook)
  (add-hook 'erc-insert-post-hook
            'erc-truncate-buffer)
  )

(use-package json-mode
  :ensure t
  :mode (("\\.json\\'" . json-mode)
         ("\\.eslintrc\\'" . json-mode))
  :config (setq-default js-indent-level 2))

(use-package git-gutter
  :ensure t
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode t)
  )

;; Load this computer custom settings file if exists
(setq custom-file "~/.emacs.d/custom-settings.el")
(load custom-file t)

(put 'upcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
