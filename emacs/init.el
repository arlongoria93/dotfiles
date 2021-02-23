(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; package initialization
(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; getting rid of clutter
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; modes to activate
(electric-pair-mode 1)
(global-visual-line-mode 1)

;; global defaults
(setq visible-bell nil
      inhibit-startup-message t
      confirm-kill-emacs 'yes-or-no-p
      custom-file (expand-file-name "custom.el" user-emacs-directory))

;; others
(set-fringe-mode 10)
(set-face-attribute 'default nil :font "MonoLisa" :height 180)

;; org-mode
(require 'org-tempo)

;; org mode defaults
(setq org-src-tab-acts-natively t
      org-export-html-postamble nil
      org-confirm-babel-evaluate nil)

;; hooks
(add-hook 'org-mode-hook 'org-indent-mode)

;; org-babel
(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)
    (js . t)))

;; ido-vertical-mode
(use-package ido-vertical-mode
  :config
  (ido-mode 1)
  (ido-vertical-mode 1)
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

;; org bullets
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; org-journal
(use-package org-journal
  :config
  (setq org-journal-file-type 'weekly
        org-journal-dir "/home/manikandan/Documents/journal"))

;; center org buffers
(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

;; evil
(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;; evil leader
(use-package evil-leader
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "f" 'find-file
    "b" 'switch-to-buffer
    "d" 'dired-jump
    "o" 'other-window
    "O" 'delete-other-windows
    "e" 'eshell
    "j" 'bookmark-jump
    "x" 'execute-extended-command
    "n" 'org-narrow-to-subtree
    "w" 'widen
    "k" 'kill-buffer))

;; evil collection
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; dired related
(use-package dired
  :ensure nil
  :hook (dired-mode . dired-hide-details-mode)
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

;; hide-mode-line
(use-package hide-mode-line
  :config
  (global-hide-mode-line-mode 1))
  ;; (add-hook 'org-mode-hook #'hide-mode-line-mode)
  ;; (add-hook 'prog-hook #'hide-mode-line-mode)
  ;; (add-hook 'dired-mode-hook #'hide-mode-line-mode))

;; dired-single
(use-package dired-single)

;; dired-open
(use-package dired-open
  :config
  (add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extentions '(("png" . "sxiv") ("mpv" . "mkv"))))

;; dired-hide-dotfiles
(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;; which-key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; doom-themes
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-snazzy t))

;; rainbox-delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; typescript-mode
(use-package typescript-mode)

;; markdown-mode
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


;; get rid of bold fonts everywhere
(defun remap-faces-default-attributes ()
  (let ((family (face-attribute 'default :family))
        (height (face-attribute 'default :height)))
    (mapcar (lambda (face)
              (face-remap-add-relative
               face :family family :weight 'normal :height height))
          (face-list))))
(when (display-graphic-p)
  (add-hook 'minibuffer-setup-hook 'remap-faces-default-attributes)
  (add-hook 'change-major-mode-after-body-hook 'remap-faces-default-attributes))

;; organizing backups
;; backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))

;; for auto-save files
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
      auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

;; disable lock files
(setq create-lockfiles nil)

;; START TABS CONFIG:
;; source: https://dougie.io/emacs/indentation/
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)

;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width)
(setq-default js-indent-level custom-tab-width)
(setq-default c-basic-offset custom-tab-width)
(setq-default typescript-indent-level custom-tab-width)
(setq-default css-indent-level custom-tab-width)

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)

;; This will also show trailing characters as they are useful to spot
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
'(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9])))
(global-whitespace-mode)
; END TABS CONFIG

;; transparency
(set-frame-parameter (selected-frame) 'alpha '(84 . 84))
(add-to-list 'default-frame-alist '(alpha . (84 . 84)))

;; set fringe face to whatever the theme face is
(defun mk/transparent-fringes ()
  (set-face-attribute 'fringe nil
        :foreground (face-foreground 'default)
        :background (face-background 'default)))
(mk/transparent-fringes)

;; Make movement keys work like they should
(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(setq-default evil-cross-lines t)
