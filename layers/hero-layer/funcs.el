;; Commons
(defun kill-other-buffers()
  "Kill all buffers without current buffer."
  (interactive)
  (delete-other-windows)
  (let ((current (buffer-name)))
    (mapcar 'kill-buffer (cdr (buffer-list)))))

(defun forward-kill-a-word ()
  "Kill a word forward."
  (interactive)
  (backward-kill-word -1))

(defun kill-region-or-line ()
  "Kill the region or a line"
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-whole-line)))

(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))

(defun hero-toggle-indent-offset ()
  "toggle indent offset between 4 or 2 spaces"
  (interactive)
  (cond
   ((or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
    (progn
      (setq js-indent-level (if (= js-indent-level 2) 4 2))
      (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))
   ((eq major-mode 'web-mode)
    (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
           (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
           (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
   ((eq major-mode 'css-mode)
    (setq css-indent-offset (if (= css-indent-offset 2) 4 2))))
  (spacemacs/indent-region-or-buffer))

;; Java
(defun run-java-main (filename)
  "Compile and run java file"
  (let ((output-buffer "*Java Output*")
        (filename (format "%s" filename)))
    (if (equal (shell-command (format "javac -d . %s" filename) output-buffer output-buffer) 0)
        (async-shell-command (format "java %s" (car (split-string filename "\\."))) output-buffer output-buffer)
      (progn (switch-to-buffer-other-window output-buffer)
             (messages-buffer-mode)))))

(defun run-java-main-currently-buffer ()
  "Compile and run java file use current buffer name"
  (interactive)
  (if (buffer-modified-p (current-buffer))
      (save-buffer))
  (run-java-main (file-name-nondirectory (buffer-file-name))))

;; Windows OS funcs
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

