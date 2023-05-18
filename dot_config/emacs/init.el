;;; package --- Summary
;;; OgaKen's dotemacs
;;; Commentary:

;;; Code:

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("melpa" . "https://melpa.org/packages/")
		       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

(leaf *builtin
  :config
  (leaf cus-edit
    :doc "tools for customizing Emacs and Lisp packages"
    :tag "builtin" "faces" "help"
    :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))
  (leaf cus-start
    :doc "define customization properties of builtins"
    :tag "builtin" "internal"
    :preface
    (defun c/redraw-frame nil
      (interactive)
      (redraw-frame))
    :bind (("M-ESC ESC" . c/redraw-frame))
    :custom '((user-full-name . "Kento Ogata")
	      (create-lockfiles . nil)
	      (debug-on-error . t)
	      (init-file-debug . t)
	      (frame-resize-pixelwise . t)
	      (enable-recursive-minibuffers . t)
	      (history-length . 1000)
	      (history-delete-duplicates . t)
	      (scroll-preserve-screen-position . t)
	      (scroll-conservatively . 100)
	      (mouse-wheel-scroll-amount . '(1 ((control) . 5)))
	      (ring-bell-function . 'ignore)
	      (text-quoting-style . 'straight)
	      (truncate-lines . t)
	      (use-dialog-box . nil)
	      (use-file-dialog . nil)
	      (menu-bar-mode . nil)
	      (tool-bar-mode . nil)
	      (scroll-bar-mode . nil)
	      (indent-tabs-mode . nil))
    :config
    (defalias 'yes-or-no-p 'y-or-n-p)
    (keyboard-translate ?\C-h ?\C-?))
  (leaf autorevert
    :doc "revert buffers when files on disk change"
    :tag "builtin"
    :custom ((auto-revert-interval . 1))
    :global-minor-mode global-auto-revert-mode)
  (leaf cc-mode
    :doc "major mode for editing C and similar languages"
    :tag "builtin"
    :defvar (c-basic-offset)
    :bind (c-mode-base-map
	   ("C-c c" . compile))
    :mode-hook
    (c-mode-hook . ((c-set-style "bsd")
		    (setq c-basic-offset 4)))
    (c++-mode-hook . ((c-set-style "bsd")
		      (setq c-basic-offset 4))))
  (leaf delsel
    :doc "delete selection if you insert"
    :tag "builtin"
    :global-minor-mode delete-selection-mode)
  (leaf paren
    :doc "highlight matching paren"
    :tag "builtin"
    :custom ((show-paren-delay . 0.1))
    :global-minor-mode show-paren-mode)
  (leaf simple
    :doc "basic editing commands for Emacs"
    :tag "builtin" "internal"
    :custom ((kill-ring-max . 100)
	     (kill-read-only-ok . t)
	     (kill-whole-line . t)
	     (eval-expression-print-length . nil)
	     (eval-expression-print-level . nil))
    :global-minor-mode column-number-mode)
  (leaf files
    :doc "file input and output commands for Emacs"
    :tag "builtin"
    :custom `((auto-save-timeout . 15)
	      (auto-save-interval . 60)
	      (auto-save-file-name-transforms . '((".*" ,(locate-user-emacs-file "backup/") t)))
	      (backup-directory-alist . '((".*" . ,(locate-user-emacs-file "backup"))
					  (,tramp-file-name-regexp . nil)))
	      (version-control . t)
	      (delete-old-versions . t)))
  (leaf startup
    :doc "process Emacs shell arguments"
    :tag "builtin" "internal"
    :custom `((auto-save-list-file-prefix . ,(locate-user-emacs-file "backup/.saves-"))
	      (inhibit-startup-message . t)
	      (initial-scratch-message . "")))
  (leaf time
    :tag "builtin"
    :global-minor-mode display-time-mode)
  (leaf tool-bar
    :tag "builtin"
    :config
    (tool-bar-mode -1))
  (leaf mule-cmds
    :tag "builtin"
    :config
    (prefer-coding-system 'utf-8)))

(leaf flycheck
  :doc "On-the-fly syntax checking"
  :req "dash-2.12.1" "pkg-info-0.4" "let-alist-1.0.4" "seq-1.11" "emacs-24.3"
  :tag "minor-mode" "tools" "languages" "convenience" "emacs>=24.3"
  :url "https://www.flycheck.org"
  :emacs>= 24.3
  :ensure t
  :bind (("M-n" . flycheck-next-error)
	 ("M-p" . flycheck-previous-error))
  :global-minor-mode global-flycheck-mode)

(leaf company
  :doc "Modular text completion framework"
  :req "emacs-24.3"
  :tag "matching" "convenience" "abbrev" "emacs>=24.3"
  :url "http://company-mode.github.io/"
  :emacs>= 24.3
  :ensure t
  :blackout t
  :leaf-defer nil
  :bind ((company-active-map
	  ("M-n" . nil)
	  ("M-p" . nil)
	  ("C-s" . company-filter-candidates)
	  ("C-n" . company-select-next)
	  ("C-p" . company-select-previous)
	  ("<tab>" . company-complete-selection))
	 (company-search-map
	  ("C-n" . company-select-next)
	  ("C-p" . company-select-previous)))
  :custom ((company-idle-delay . 0)
	   (company-minimum-prefix-length . 1)
	   (company-transformers . '(company-sort-by-occurrence)))
  :config
  (add-hook 'org-mode-hook #'(lambda nil
			       (setq-local company-begin-commands nil)))
  :global-minor-mode global-company-mode)


(leaf ddskk
  :doc "Simple Kana to Kanji conversion program."
  :ensure t
  :bind ("C-x C-j" . skk-mode)
  :custom `((default-input-method . "japanese-skk")
	    (skk-use-azik . t)
	    (skk-azik-keyboard-type . "us101")
	    (skk-jisyo-code . "utf-8")
	    (skk-jisyo . ,(concat (getenv "XDG_DATA_HOME") "/skk/user-jisyo"))
	    (skk-large-jisyo . ,(concat (getenv "XDG_DATA_HOME") "/skk/SKK-JISYO.L"))
	    (skk-jisyo-edit-user-accepts-editing . t)
            (skk-save-jisyo-instantly . t)
            (skk-egg-like-newline . t)))

(leaf *themes
  :config
  (leaf solarized-theme
    :doc "The solarized color theme"
    :ensure t
    :custom ((solarized-use-less-bold . t)
	     (solarized-use-variable-pitch . nil)
	     (solarized-scale-org-headlines . nil)
	     (solarized-high-contrast-mode-line . nil)
	     (solirized-distinct-fringe-background . t)
	     (solarized-height-minus-1 . 1.0)
	     (solarized-height-plus-1 . 1.0)
	     (solarized-height-plus-2 . 1.0)
	     (solarized-height-plus-3 . 1.0)
	     (solarized-height-plus-4 . 1.0)))

  (leaf catppuccin-theme
    :doc "Soothing pastel theme for Emacs"
    :ensure t
    :custom (catppuccin-flavor . 'frappe))

  (load-theme 'solarized-gruvbox-dark t))
  
(leaf rainbow-delimiters
  :doc "Highlight brackets according to theier depth"
  :ensure t
  :tag "faces" "convenience" "lisp" "tools"
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(leaf which-key
  :doc "Display available keybindings in popup"
  :ensure t
  :global-minor-mode which-key-mode)

(leaf *filetype
  :config
  (leaf csharp-mode :ensure t)

  (leaf yaml-mode :ensure t)

  (leaf markdown-mode :ensure t)

  (leaf dockerfile-mode :ensure t)

  (leaf csv-mode
    :doc "Major mode for editing comma/char separated values"
    :ensure t)

  (leaf org
    :doc "Outline-based notes management and organizer"
    :ensure t
    :bind (("C-c c" . org-capture)
           ("C-c a" . org-agenda))
    :custom ((org-agenda-files . '(org-directory))
             (org-startup-folded . nil)
             (org-capture-templates . '(("p" "電話番メモ" entry (file (concat org-directory "/incoming-call-history.org"))
                                         "* %T \n- 会社: \n- 支店: \n- 部署: \n- 氏名: \n- 宛先: \n- 案件: \n- 要件: \n- 折り返し先: \n- 備考:")
                                        ("t" "Todo" entry (file (concat org-directory "/notes.org"))
                                         "* TODO \n Entry: %T"))))
    :init
    (leaf org-journal
      :doc "a simple org-mode based journaling mode"
      :ensure t
      :bind (("C-c j" . org-journal-new-entry))
      :custom ('(org-journal-dir . ,(concat org-directory "/journal"))
	       (org-journal-date-format . "%A, %d %B %Y")))
    (leaf org-roam
      :doc "A database abstraction layer for Org-mode"
      :ensure t)
    :config
    (leaf org-modern
      :ensure t
      :init
      (add-hook 'org-mode-hook #'org-modern-mode)
      (add-hook 'org-agenda-finalize-hook #'org-modern-agenda))
    (add-hook 'org-mode-hook #'org-indent-mode)))

(leaf editorconfig
  :ensure t
  :global-minor-mode editorconfig-mode)

(leaf vertico
  :doc "VERTical Interactive COmpletion"
  :ensure t
  :custom ((vertico-count . 20))
  :config
  (savehist-mode t)
  (leaf consult
    :ensure t
    :bind (("C-s" . consult-line)
	   ("C-S-s" . consult-imenu)
	   ("C-x C-r" . consult-recent-file)
	   ("C-x C-b" . consult-buffer))
    :init
    (leaf consult-ghq
      :ensure t)
    (leaf consult-ls-git
      :ensure t)
    (recentf-mode))
  (leaf marginalia
    :ensure t
    :global-minor-mode marginalia-mode)
  (leaf orderless
    :ensure t
    :custom ((completion-styles . '(orderless))))
  (leaf embark
    :ensure t
    :init
    (leaf embark-consult
      :ensure t)
    :bind (("C-h b" . embark-bindings)))
  :global-minor-mode vertico-mode)

(leaf evil
  :ensure t
  :bind ("C-x v" . evil-mode))

(leaf magit
  :ensure t)

(leaf paredit
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode))

;;; init.el ends here
