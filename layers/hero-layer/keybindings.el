;; Emacs 自带功能
(global-set-key (kbd "C-t") 'nil)
(global-set-key (kbd "C-c k") 'kill-other-buffers)
;; (global-set-key [(control \`)] 'sr-speedbar-toggle)
(global-set-key (kbd "M-s o") 'occur-dwim)
(global-set-key (kbd "C-d") 'kill-region-or-line)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(global-set-key (kbd "C-r") 'ivy-switch-buffer)
(global-set-key (kbd "C-c q") 'quit-window)
(global-set-key (kbd "C-k") 'forward-kill-a-word)
(global-set-key (kbd "C-t x") 'hexl-mode)

;; 第三方
(global-set-key (kbd "C-;") 'mc/mark-all-dwim)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "M-j") 'mc/mark-next-like-this)
(global-set-key (kbd "M-s i") 'helm-imenu)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-M-f") 'spacemacs/indent-region-or-buffer)
(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "C-r") 'undo-tree-redo)
(global-set-key (kbd "C-c s s") 'counsel-rg)
(global-set-key (kbd "C-t i") 'hero-toggle-indent-offset)
(global-set-key (kbd "C-c f z f") 'counsel-fzf)
(global-set-key (kbd "C-c i c") 'macro-math-eval-region)
(spacemacs/set-leader-keys "fzf" 'fzf)
(spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)

;; Normol State
(define-key evil-normal-state-map (kbd "C-e") 'mwim-end-of-line-or-code)
(define-key evil-normal-state-map (kbd "C-z") 'undo-tree-undo)

;; Visula State
(define-key evil-visual-state-map (kbd "C-e") 'mwim-end-of-line-or-code)
(define-key evil-visual-state-map (kbd "C-z") 'undo-tree-undo)

;; Motion State
(define-key evil-motion-state-map (kbd "C-e") 'mwim-end-of-line-or-code)
(define-key evil-motion-state-map (kbd "C-z") 'undo-tree-undo)

;; hook keybindings
(add-hook 'multiple-cursors-mode-hook
          (lambda ()
            (define-key mc/keymap (kbd "<return>") 'newline-and-indent)))
(add-hook 'js2-mode-hook
          (lambda ()
            (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-sexp)
            (define-key js2-mode-map (kbd "C-c C-b") 'nodejs-repl-send-buffer)
            (define-key js2-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js2-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js2-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)
            (define-key js2-mode-map (kbd "C-c C-c") 'nodejs-repl-quit-or-cancel)))
(add-hook 'dired-mode-hook
          (lambda ()
            (evil-define-key 'normal dired-mode-map "o" 'dired-find-file-other-window)
            (evil-define-keymap evil-normal-state-map (kbd "o") 'dired-find-file-other-window)
            (define-key evil-normal-state-map (kbd "<normal-state> o") 'dired-find-file-other-window);在当前DiredBuffer打开文件
            (define-key dired-mode-map (kbd "e") 'dired-find-alternate-file);在当前DiredBuffer打开文件
            (define-key dired-mode-map (kbd "o") 'dired-find-file-other-window);在当前DiredBuffer打开文件
            (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file);在当前DiredBuffer打开文件
            (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))));返回上一层使用当前 DiredBuffer
(add-hook 'org-agenda-mode-hook
          (lambda ()
            (define-key org-agenda-keymap (kbd "TAB") 'org-agenda-show-and-scroll-up)
            (define-key org-agenda-keymap (kbd "<tab>") 'org-agenda-show-and-scroll-up)
            (define-key org-agenda-keymap (kbd "RET") 'org-agenda-goto)
            (define-key org-agenda-keymap (kbd "SPC") 'org-agenda-switch-to)))
(add-hook 'org-mode-hook
          (lambda ()
            (setq org-adapt-indentation t)
            (define-key spacemacs-org-mode-map-root-map (kbd "C-c i r") 'org-roam-ref-add)
            (define-key spacemacs-org-mode-map-root-map (kbd "C-c i i") 'org-id-get-create)
            (define-key spacemacs-org-mode-map-root-map (kbd "M-RET") 'org-meta-return)
            (define-key spacemacs-org-mode-map-root-map (kbd "<M-return>") 'org-meta-return)))
(add-hook 'java-mode-hook
          (lambda ()
            (define-key java-mode-map (kbd "C-x C-e") 'run-java-main-currently-buffer)
            (define-key java-mode-map (kbd "C-d") 'kill-whole-line)))
(add-hook 'markdown-mode-hook
          (lambda ()
            (define-key markdown-mode-map (kbd "C-c C-c p") 'markdown-live-preview-switch-to-output)))
