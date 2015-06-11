
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Part common to all OSes
;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Lisp interpreter settings
(setq max-lisp-eval-depth 18000)
(setq max-specpdl-size 13000)


;; keyboard setup
(set-keyboard-coding-system nil)

(global-set-key (kbd "M-`") 'other-window)
 
; function keys setup
(global-set-key [f1] 'eshell)
(global-set-key [f5] 'eval-region)


;; imenu setup
(global-unset-key [double-mouse-1]) 
(global-set-key [double-mouse-1] 'imenu)


;; remove scrollbars, menus and toolbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


;; minor modes & various options
(show-paren-mode t)
(column-number-mode t)
(global-hl-line-mode nil) 
(blink-cursor-mode 0)
(icomplete-mode t)
(global-font-lock-mode t)

(setq show-paren-style 'expression)
(setq read-buffer-completion-ignore-case 't)
(setq indent-tabs-mode nil)
(windmove-default-keybindings) ; Shift-<Arrow keys> switch active window
(setq undo-limit 100000)
(put 'narrow-to-region  'disabled nil)

(if (fboundp 'ace-jump-mode)
    (progn
      (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
      (define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)))

;; aliases for useful functions

(defalias 'qrr 'query-replace-regexp)
;; useful in eshell for use as a shell command
(defalias 'ff 'find-file)


;; MELPA support
(when (> emacs-major-version 23)
  (require 'package)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
  (package-initialize))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings for different programming languages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; python-specific stuff
;;;;;;;;;;;;;;;;;;;;;;;;;

;; activate elpy if it is installed
(if (fboundp 'elpy-enable)
    (progn
      (elpy-enable)
      (elpy-use-ipython)))


;;;;;;;;;;;;;;;;;;;;;;
;; Mac specific parts
;;;;;;;;;;;;;;;;;;;;;;


;; correct exec-path necessary when launching Emacs from spotlight
(defun set-exec-path-from-shell-PATH ()
  "Sets the exec-path to the same value used by the user shell"
  (let ((path-from-shell
         (replace-regexp-in-string
          "[[:space:]\n]*$" ""
          (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; call function now - only for mac
(if (eq system-type 'darwin)
    (set-exec-path-from-shell-PATH))


;; use cmd key for meta on mac
(if (eq system-type 'darwin)
    (setq mac-option-key-is-meta nil
	  mac-command-key-is-meta t
	  mac-command-modifier 'meta
	  mac-option-modifier 'none))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Themes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-theme 'deeper-blue)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rest for the custom section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
