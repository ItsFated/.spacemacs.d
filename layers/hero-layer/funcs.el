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
    (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))
   ((eq major-mode 'plantuml-mode)
    (setq plantuml-indent-level (if (= plantuml-indent-level 2) 4 2))))
  (spacemacs/indent-region-or-buffer))

(defun hero/load-my-layout ()
  (interactive)
  (persp-load-state-from-file (concat persp-save-dir "hero-persp-save")))

(defun hero/save-my-layout ()
  (interactive)
  (persp-save-state-to-file (concat persp-save-dir "hero-persp-save")))

(defun hero-calc-equation-at-point=()
  (interactive)
  (let ((str (buffer-substring (line-beginning-position) (point))))
    (message "str:%s" str)
    (string-match "[0-9]+ *[\/\*\+\-\%0-9 ]+ *\=? *" str)
    (setq str (match-string 0 str))
    (message "str:%s" str)
    (setq str (replace-regexp-in-string "=" "" str))
    (message "str:%s" str)
    (insert (calc-eval str))))

(defun macro-math-eval-region (beg end &optional copy-to-kill-ring digits)
  "Evaluate the marked mathematical expression and replace it with the result.
With arg COPY-TO-KILL-RING or prefix arg, don't replace the region, but
save the result to the kill-ring.  When DIGITS is non-nil, or a numeric
prefix arg is given, it determines the number of decimal digits to round
to."
  (interactive (list (region-beginning)
                     (region-end)
                     (consp current-prefix-arg)
                     (when (numberp current-prefix-arg) current-prefix-arg)))
  (let* ((equation (buffer-substring beg end))
         (calc-multiplication-has-precedence nil)
         (result (macro-math-eval (buffer-substring-no-properties beg end)))
         (rounded (if digits
                      (macro-math-round result digits)
                    (number-to-string result))))
    (message equation)
    (if (or buffer-read-only copy-to-kill-ring)
        (progn (deactivate-mark)
               (kill-new rounded)
               (message "Saved %s in kill-ring" rounded))
      (delete-region beg end)
      (insert (format "%s = %s" equation rounded)))))


(defun macro-math-eval-and-round-region (beg end &optional digits)
  "Call `macro-math-eval-region' and round the number to DIGITS places.
If DIGITS is nil, `macro-math-rounding-precision' will be used."
  (interactive "r\nP")
  (macro-math-eval-region
   beg end nil (or digits macro-math-rounding-precision)))

(defsubst macro-math-symbol-value (symbol)
  (let* ((symbol (intern symbol))
         (value (when (boundp symbol)
                  (symbol-value symbol))))
    ;; Add parentheses, so two numbers aren't accidentally concatenated.
    (if (numberp value)
        (concat "(" (number-to-string value) ")")
      (error "Unknown value '%s'" symbol))))

(defun macro-math-eval (expression)
  ;; Replace variables with their values.
  (setq expression
        (replace-regexp-in-string "\\<\\([-a-zA-Z]+\\)\\>"
                                  'macro-math-symbol-value expression))
  (string-to-number (calc-eval expression)))

(defun macro-math-round (number digits)
  "Return a string representation of NUMBER rounded to DIGITS places."
  (if (<= digits 0)
      (number-to-string (round number))
    (format
     (format "%%.%df" digits) number)))

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

