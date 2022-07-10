;; auto-save
(setq auto-save-default nil)

;; editor
(delete-selection-mode t) ;; 删除选中的字符

;; dired-mode
(setq dired-dwim-target t) ;; 如果分屏显示两个 DiredBuffer 则拷贝就会直接拷贝到另一 DiredBuffer 目录下
(setq dired-recursive-deletes 'always) ;; 递归删除
(setq dired-recursive-copies 'always) ;; 递归拷贝
(put 'dired-find-alternate-file 'disabled nil) ;; 去掉 (dired-find-alternate-file) 函数的警告

;; speedbar
;; (with-eval-after-load 'speedbar (setq speedbar-show-unknown-files t))

;; web-mode 高亮选中元素，显示元素区间
(add-hook 'web-mode-hook
          (lambda ()
            (smartparens-mode t)
            (setq web-mode-enable-current-element-highlight t)
            (setq web-mode-enable-current-column-highlight t)))

;; 文件关联 major-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
         ("\\.html\\'" . web-mode)
         ("\\.clangd\\'" . yaml-mode)
         ("\\.[agj]sp\\'" . web-mode)
         ("\\.plantuml\\'" . plantuml-mode)
         ("\\.puml\\'" . plantuml-mode))
       auto-mode-alist))

;; Windows OS
(when (eq system-type 'windows-nt)
  (add-hook 'markdown-mode-hook
            (lambda ()
              (setq markdown-command "pandoc")))
  (add-hook 'helm-major-mode-hook 'hidden-dos-eol)
  (add-hook 'minibuffer-setup-hook 'hidden-dos-eol)
  (with-eval-after-load 'helm
    (setq helm-grep-ag-command "ag --vimgrep -S %s %s %s"))
  (with-eval-after-load 'counsel
    (progn
      (setq counsel-ag-base-command "ag --vimgrep -S %s")
      (setq counsel-ag-command "ag --vimgrep -S %s"))))

(setq org-support-shift-select t)
