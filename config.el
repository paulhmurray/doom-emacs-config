;; ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; ;; Place your private configuration here! Remember, you do not need to run 'doom
;; ;; sync' after modifying this file!


;; ;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; ;; clients, file templates and snippets. It is optional.
;; ;; (setq user-full-name "John Doe"
;; ;;       user-mail-address "john@doe.com")

;; ;; Doom exposes five (optional) variables for controlling fonts in Doom:
;; ;;
;; ;; - `doom-font' -- the primary font to use
;; ;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; ;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;; ;;   presentations or streaming.
;; ;; - `doom-symbol-font' -- for symbols
;; ;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;; ;;
;; ;; See 'C-h v doom-font' for documentation and more examples of what they
;; ;; accept. For example:
;; ;;
;; ;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;; ;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;; ;;
;; ;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; ;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; ;; refresh your font settings. If Emacs still can't find your font, it likely
;; ;; wasn't installed correctly. Font issues are rarely Doom issues!

;; ;; There are two ways to load a theme. Both assume the theme is installed and
;; ;; available. You can either set `doom-theme' or manually load a theme with the
;; ;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)

;; ;; This determines the style of line numbers in effect. If set to `nil', line
;; ;; numbers are disabled. For relative line numbers, set this to `relative'.
;; (setq display-line-numbers-type 'relative)

;; ;; If you use `org' and don't want your org files in the default location below,
;; ;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; (after! flycheck
;;   (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)))

;; ;; Whenever you reconfigure a package, make sure to wrap your config in an
;; ;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;; ;;
;; ;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; In ~/.doom.d/config.el
;;
;; (after! evil-escape
;;   (setq evil-escape-key-sequence "jk")
;;   (setq evil-esc-delay 0.2)) ; Time (in seconds) to wait between j and k

;; ;; Configure company for faster completion
;; (after! evil
;;   (setq evil-clipboard t))

;; (after! company
;;   (setq company-idle-delay 0.3  ; Faster completion popup
;;         company-minimum-prefix-length 1)
;;   (define-key company-active-map (kbd "C-y") #'company-complete-selection))

;; ;; Configure lsp-ui for inline diagnostics
;; (after! lsp-ui
;;   (setq lsp-ui-sideline-enable t
;;         lsp-ui-sideline-show-diagnostics t
;;         lsp-ui-sideline-update-mode 'line))   ; Show diagnostics on the current line

;; ;; Configure lsp-mode for better responsiveness
;; (after! lsp-mode
;;   (setq lsp-idle-delay 0.5
;;         lsp-auto-guess-root t))

;; ;; Configure lsp-go for Go development
;; (after! lsp-go
;;   (setq lsp-gopls-staticcheck t)  ; Enable staticcheck for deeper analysis
;;   (setq lsp-gopls-use-placeholders t)  ; Optional: for snippet-like behavior
;;   (setq lsp-gopls-complete-unimported t)  ; Suggest and auto-import unimported packages
;;   (setq lsp-gopls-hover-kind "FullDocumentation")  ; Optional: richer hover info
;;   (setq lsp-gopls-env '("GOPLS_LOGFILE=/tmp/gopls.log"))
;;   (setq lsp-gopls-analyses '((unusedparams . t)))
;;   (add-hook 'go-mode-hook
;;             (lambda ()
;;               (add-hook 'before-save-hook #'lsp-organize-imports nil t)))
;;   (map! :map go-mode-map
;;         :localleader
;;         "i" #'lsp-go-imports))  ; Bind a key to trigger import organization
;; (after! go-mode
;;   (add-hook 'go-mode-hook #'lsp))



;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Ensure dashboard shows up in new frames
(setq +doom-dashboard-functions
      '(doom-dashboard-widget-banner
        doom-dashboard-widget-shortmenu
        doom-dashboard-widget-loaded))

;; Show dashboard in emacsclient frames
(setq initial-buffer-choice (lambda () (get-buffer-create "*doom*")))

;; Basic Doom settings
(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)
(setq org-directory "~/org/")

;; Set a larger default font
(setq doom-font (font-spec :family "JetBrains Mono" :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 16)
      doom-big-font (font-spec :family "JetBrains Mono" :size 16))

;; Ensure font settings apply to new frames (like emacsclient)
(add-to-list 'default-frame-alist '(font . "JetBrains Mono"))

;; Evil mode configuration
(after! evil-escape
  (setq evil-escape-key-sequence "jk")
  (setq evil-escape-delay 0.2))

(after! evil
  (setq evil-clipboard t))

;; Company (completion) configuration
(after! company
  (setq company-idle-delay 0.3
        company-minimum-prefix-length 1)
  (define-key company-active-map (kbd "C-y") #'company-complete-selection))

;; Flycheck configuration
(after! flycheck
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)))

;; LSP Mode configuration
(after! lsp-mode
  (setq lsp-idle-delay 0.5
        lsp-auto-guess-root t
        lsp-log-io nil  ; Disable logging for better performance
        lsp-restart 'auto-restart
        lsp-enable-symbol-highlighting t
        lsp-enable-on-type-formatting nil
        lsp-signature-auto-activate nil
        lsp-signature-render-documentation nil
        lsp-eldoc-hook nil
        lsp-modeline-code-actions-enable nil
        lsp-modeline-diagnostics-enable nil
        lsp-headerline-breadcrumb-enable nil
        lsp-semantic-tokens-enable nil
        lsp-enable-folding nil
        lsp-enable-imenu nil
        lsp-enable-snippet nil))

;; LSP UI configuration
(after! lsp-ui
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-update-mode 'line
        lsp-ui-sideline-show-code-actions nil
        lsp-ui-peek-enable t
        lsp-ui-doc-enable nil))

;; Go-specific configuration
(after! go-mode
  ;; Enable LSP for Go files
  (add-hook 'go-mode-hook #'lsp-deferred)

  ;; Auto-organize imports before save
  (add-hook 'go-mode-hook
            (lambda ()
              (add-hook 'before-save-hook #'lsp-organize-imports nil t)
              (add-hook 'before-save-hook #'lsp-format-buffer nil t)))

  ;; Key bindings for Go mode
  (map! :map go-mode-map
        :localleader
        "i" #'lsp-organize-imports
        "f" #'lsp-format-buffer
        "r" #'lsp-rename
        "d" #'lsp-find-definition
        "R" #'lsp-find-references))

;; Gopls (Go language server) configuration
(after! lsp-go
  (setq lsp-gopls-staticcheck t
        lsp-gopls-use-placeholders t
        lsp-gopls-complete-unimported t
        lsp-gopls-hover-kind "FullDocumentation"
        lsp-gopls-analyses '((unusedparams . t)
                             (shadow . t))))
