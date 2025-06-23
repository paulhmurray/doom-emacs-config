;; Dashboard configuration
(setq +doom-dashboard-functions
      '(doom-dashboard-widget-banner
        doom-dashboard-widget-shortmenu
        doom-dashboard-widget-loaded))
(global-set-key (kbd "C-c d") #'+doom-dashboard/open)

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

;; ORG MODE CONFIGURATION
;; First, set up org-agenda-files properly
(after! org
  ;; Ensure org-agenda-files is set correctly
  (setq org-agenda-files '("~/org/meetings.org"))

  ;; Create the files if they don't exist
  (dolist (file org-agenda-files)
    (unless (file-exists-p file)
      (with-temp-buffer
        (write-file file))))

  ;; Set up org-capture-templates
  (setq org-capture-templates
        '(("m" "Meeting Notes" entry
           (file+headline "~/org/meetings.org" "Meetings")
           "* %^{Meeting Title} :meeting:\n:PROPERTIES:\n:DATE: %U\n:ATTENDEES: %^{Attendees}\n:END:\n** Agenda\n- %?\n** Notes\n- \n** Decisions\n- \n** Action Items\n*** TODO "
           :empty-lines 1)
          ("t" "Todo" entry
           (file+headline "~/org/inbox.org" "Tasks")
           "* TODO %?\n  %U\n  %a")
          ("n" "Note" entry
           (file+headline "~/org/notes.org" "Notes")
           "* %?\nEntered on %U\n  %a")
          ("j" "Journal" entry
           (file+olp+datetree "~/org/journal.org")
           "* %<%H:%M> %?\nEntered on %U\n"
           :empty-lines 1)
          ))

  ;; Remove the hook that might interfere with org-capture
  (remove-hook 'org-capture-mode-hook #'yas-minor-mode))

;; Org-roam configuration
(use-package! org-roam
  :after org
  :custom
  (org-roam-directory (file-truename "~/org/zettel"))
  (org-roam-completion-everywhere t)
  :config
  (org-roam-db-autosync-mode)

  (setq org-roam-capture-templates
        '(("d" "default" plain
           "#+title: ${title}\n\n* Notes\n\n%?\n\n* Backlinks\n\n"
           :target (file+head "zettel/%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n")
           :unnarrowed t))))

;; Spell checking configuration
(setq ispell-program-name "hunspell")
(setq ispell-dictionary "en_GB") ;; Use English (UK)
(setq ispell-local-dictionary "en_GB")
(setq ispell-local-dictionary-alist
      '(("en_GB" "[[:alpha:]]" "[^[:alpha:]]" "[']" t ("-d" "en_GB") nil utf-8)))
;; WEB DEVELOPMENT CONFIGURATION
;; Add this section to your ~/.doom.d/config.el file

;; Web-mode configuration
;; Company configuration for web modes
(after! web-mode
  (set-company-backend! 'web-mode
    '(company-web-html company-css company-files company-dabbrev))

  ;; Web-mode specific settings
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t
        web-mode-enable-current-element-highlight t
        web-mode-enable-auto-indentation t))
(after! html-mode
  (set-company-backend! 'html-mode
    '(company-web-html company-files company-dabbrev)))

;; CSS mode configuration
(after! css-mode
  (set-company-backend! 'css-mode
    '(company-css company-files company-dabbrev)))

;; JavaScript/TypeScript configuration
(after! js2-mode
  (setq js2-basic-offset 2
        js-indent-level 2))

(after! typescript-mode
  (setq typescript-indent-level 2))

;; Format on save for web development files
(add-hook! (html-mode web-mode css-mode js-mode js2-mode typescript-mode json-mode)
  (format-all-mode))

;; Enable emmet mode for HTML expansion (e.g., div.class>p*3)
(add-hook! (html-mode web-mode) #'emmet-mode)

;; LSP configuration for web development
(after! lsp-mode
  ;; Enable LSP for web development modes
  (add-hook 'html-mode-hook #'lsp-deferred)
  (add-hook 'css-mode-hook #'lsp-deferred)
  (add-hook 'js-mode-hook #'lsp-deferred)
  (add-hook 'js2-mode-hook #'lsp-deferred)
  (add-hook 'typescript-mode-hook #'lsp-deferred)
  (add-hook 'web-mode-hook #'lsp-deferred))

;; HTMX Configuration (built-in, no external package needed)
(defvar htmx-attributes
  '("hx-get" "hx-post" "hx-put" "hx-patch" "hx-delete"
    "hx-target" "hx-trigger" "hx-swap" "hx-select"
    "hx-include" "hx-push-url" "hx-vals" "hx-confirm"
    "hx-disable" "hx-boost" "hx-indicator" "hx-params"
    "hx-encoding" "hx-ext" "hx-headers" "hx-history"
    "hx-history-elt" "hx-request" "hx-sync" "hx-validate"
    "hx-on" "hx-disinherit" "hx-preserve")
  "List of HTMX attributes for completion.")

;; HTMX syntax highlighting
(defun htmx-setup-highlighting ()
  "Add HTMX attribute highlighting to HTML modes."
  (font-lock-add-keywords
   nil
   '(("\\bhx-[a-z-]+\\b" . font-lock-keyword-face))))

(add-hook 'html-mode-hook #'htmx-setup-highlighting)
(add-hook 'web-mode-hook #'htmx-setup-highlighting)

;; HTMX snippets using yasnippet
(after! yasnippet
  (defun add-htmx-snippets ()
    "Add HTMX snippets to yasnippet."
    (yas-define-snippets 'html-mode
                         '(("hxget" "hx-get=\"$1\" hx-target=\"$2\"$0" "HTMX GET request")
                           ("hxpost" "hx-post=\"$1\" hx-target=\"$2\"$0" "HTMX POST request")
                           ("hxtrigger" "hx-trigger=\"$1\"$0" "HTMX trigger")
                           ("hxswap" "hx-swap=\"$1\"$0" "HTMX swap")
                           ("hxtarget" "hx-target=\"$1\"$0" "HTMX target")
                           ("hxboost" "hx-boost=\"true\"$0" "HTMX boost")
                           ("hxconfirm" "hx-confirm=\"$1\"$0" "HTMX confirm")
                           ("hxindicator" "hx-indicator=\"$1\"$0" "HTMX indicator")
                           ("hxform" "<form hx-post=\"$1\" hx-target=\"$2\">\n  $0\n</form>" "HTMX form")))

    (yas-define-snippets 'web-mode
                         '(("hxget" "hx-get=\"$1\" hx-target=\"$2\"$0" "HTMX GET request")
                           ("hxpost" "hx-post=\"$1\" hx-target=\"$2\"$0" "HTMX POST request")
                           ("hxtrigger" "hx-trigger=\"$1\"$0" "HTMX trigger")
                           ("hxswap" "hx-swap=\"$1\"$0" "HTMX swap")
                           ("hxtarget" "hx-target=\"$1\"$0" "HTMX target")
                           ("hxboost" "hx-boost=\"true\"$0" "HTMX boost")
                           ("hxconfirm" "hx-confirm=\"$1\"$0" "HTMX confirm")
                           ("hxindicator" "hx-indicator=\"$1\"$0" "HTMX indicator")
                           ("hxform" "<form hx-post=\"$1\" hx-target=\"$2\">\n  $0\n</form>" "HTMX form"))))

  (add-hook 'html-mode-hook #'add-htmx-snippets)
  (add-hook 'web-mode-hook #'add-htmx-snippets))

;; Web-mode file associations
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.htm\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

;; Key bindings for web development
(map! :after web-mode
      :map web-mode-map
      :localleader
      "f" #'format-all-buffer
      "=" #'web-mode-buffer-indent
      "e" #'emmet-expand-line
      (:prefix ("h" . "htmx")
               "g" (lambda () (interactive) (insert "hx-get=\"\" hx-target=\"\"") (backward-char 15))
               "p" (lambda () (interactive) (insert "hx-post=\"\" hx-target=\"\"") (backward-char 16))
               "t" (lambda () (interactive) (insert "hx-trigger=\"\"") (backward-char 1))
               "s" (lambda () (interactive) (insert "hx-swap=\"\"") (backward-char 1))
               "T" (lambda () (interactive) (insert "hx-target=\"\"") (backward-char 1))))

(map! :after html-mode
      :map html-mode-map
      :localleader
      "f" #'format-all-buffer
      "e" #'emmet-expand-line
      (:prefix ("h" . "htmx")
               "g" (lambda () (interactive) (insert "hx-get=\"\" hx-target=\"\"") (backward-char 15))
               "p" (lambda () (interactive) (insert "hx-post=\"\" hx-target=\"\"") (backward-char 16))
               "t" (lambda () (interactive) (insert "hx-trigger=\"\"") (backward-char 1))
               "s" (lambda () (interactive) (insert "hx-swap=\"\"") (backward-char 1))
               "T" (lambda () (interactive) (insert "hx-target=\"\"") (backward-char 1))))
