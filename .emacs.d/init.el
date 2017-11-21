(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))

(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

(setq custom-file "~/.emacs.d/custom-settings.el")
(load custom-file t)

(put 'dired-find-alternate-file 'disabled nil)
