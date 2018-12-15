;;; packages.el --- hero-layer layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author:  <Jason@DEVELOPERII>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `hero-layer-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `hero-layer/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `hero-layer/pre-init-PACKAGE' and/or
;;   `hero-layer/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst hero-layer-packages
  '(winum super-save hungry-delete dos)
  "The list of Lisp packages required by the hero-layer layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun hero-layer/post-init-winum()
  (use-package winum
    :init
    (setq winum-auto-assign-0-to-minibuffer t)))

(defun hero-layer/init-super-save()
  (use-package super-save
    :init
    (setq super-save-auto-save-when-idle t)
    (setq super-save-idle-duration 2.5)
    (super-save-mode +1)))

(defun hero-layer/post-init-hungry-delete()
  (use-package hungry-delete
    :init
    (global-hungry-delete-mode t)))

(defun hero-layer/post-init-dos()
  (use-package dos
    :init
    (add-hook 'dos-mode-hook 'smartparens-mode)))

;;; packages.el ends here
