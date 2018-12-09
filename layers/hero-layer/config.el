;; auto-save
(setq auto-save-default nil)

;; editor
(menu-bar-mode t)
(delete-selection-mode t) ;; 删除选中的字符

;; dired-mode
(setq dired-dwim-target t) ;; 如果分屏显示两个 DiredBuffer 则拷贝就会直接拷贝到另一 DiredBuffer 目录下
(setq dired-recursive-deletes 'always) ;; 递归删除
(setq dired-recursive-copies 'always) ;; 递归拷贝
(put 'dired-find-alternate-file 'disabled nil) ;; 去掉 (dired-find-alternate-file) 函数的警告

;; speedbar
(with-eval-after-load 'speedbar (setq speedbar-show-unknown-files t))

;; web-mode 高亮选中元素，显示元素区间
(add-hook 'web-mode-hook
          (lambda ()
            (setq web-mode-enable-current-element-highlight t)
            (setq web-mode-enable-current-column-highlight t)))

;; Windows 特殊配置
(when (eq system-type 'windows-nt)
  ;; 修改一些可执行文件
    (add-hook 'markdown-mode-hook
              (lambda ()
                (setq markdown-command "pandoc"))))

;; 文件关联 major-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
         ("\\.html\\'" . web-mode)
         ("\\.[agj]sp\\'" . web-mode)
         ("\\.plantuml\\'" . plantuml-mode)
         ("\\.puml\\'" . plantuml-mode))
       auto-mode-alist))

