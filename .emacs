;; ;;**********************************
;; ;;********* Switch Buffer  *********
;; ;;**********************************
(require 'iswitchb) 
(iswitchb-default-keybindings) 


;; *********************************
;; ********** data & time **********
;; *********************************
(setq display-time-24hr-format t)         ; In 24 hour format
(setq display-time-day-and-date t)

(display-time)                      ; Display the time
(transient-mark-mode t)

;; **********************************
;; ***** Show Column Number *********
;; **********************************
(column-number-mode t)

;; **********************************
;; ***** Using Y-N not yes-not ******
;; **********************************
(fset 'yes-or-no-p 'y-or-n-p)

(global-font-lock-mode t)

(global-set-key (kbd "M-<SPC>") 'set-mark-command)

(require 'calendar)
(global-set-key [(f8)] 'calendar)
(setq mark-diary-entries-in-calendar t) 
(setq mark-holidays-in-calendar t) 

;;========================================
;;================dict====================
;;========================================
(autoload 'dictionary-search "dictionary"
  "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary"
  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
  "Create a new dictionary buffer" t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary"
  "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary"
  "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary"
  "Display tooltips for the current word" t)
(autoload 'global-dictionary-tooltip-mode "dictionary"
  "Enable/disable dictionary-tooltip-mode for all buffers" t)

(global-set-key [mouse-3] 'dictionary-mouse-popup-matching-words)
(global-set-key [(control c)(d)] 'dictionary-lookup-definition)
(global-set-key [(control c)(f)] 'dictionary-search)
(global-set-key [(control c)(m)] 'dictionary-match-words)

;; choose a dictionary server
(setq dictionary-server "localhost")

;; for dictionary tooltip mode
;; choose the dictionary: "wn" for WordNet
;; "web1913" for Webster's Revised Unabridged Dictionary(1913)
;; so on
;(setq dictionary-tooltip-dictionary "wn")
;(global-dictionary-tooltip-mode t)
;(dictionary-tooltip-mode t);


;************************************
;**********  Major Mode  ************
;************************************
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook (lambda () (outline-minor-mode 1)))

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(show-paren-mode t)
(setq show-paren-style 'parentheses)

(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

(defun my-c-mode-common-hook()
  (c-set-style "K&R")
  (setq tab-width 8 indent-tabs-mode nil)
  (c-toggle-auto-hungry-state 1)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4)

  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  (define-key c-mode-base-map [(f7)] 'compile)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
;;  (define-key c-mode-base-map [(tab)] 'hippie-expand)
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(menu-bar-mode nil)

(defun my-c++-mode-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (c-set-style "stroustrup")
)

;;;goto-line
(global-set-key [(meta g)] 'goto-line)

(add-to-list 'load-path "~/.emacs.d/.lisp")

;;appt
(setq appt-audible nil)
(setq appt-display-diary t)
(setq appt-issue-message t)
(setq appt-display-duration 1000)

(setq inhibit-startup-message t)
(setq inhibit-splash-screen  t)

;;todo
;;   (setq todo-file-do "~/.emacs.d/todo-do")
;;   (setq todo-file-done "~/.emacs.d/todo-done")
;;   (setq todo-file-top "~/.emacs.d/todo-top")

(setq auto-mode-alist (cons '("~/.emacs.d/todo-do" . todo-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.todo$" . todo-mode) auto-mode-alist))

;;

(setq default-fill-column 65)

(setq frame-title-format "emacs@%b")

(auto-image-file-mode)


(setq scroll-margin 3
      scroll-conservatively 10000)

(mouse-avoidance-mode 'animate)

;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; my functions ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun insert-time()
  "insert current time in the test"
  (interactive)
;  (insert "\t\tUpdate By Cyvins@")
  (insert (format-time-string "%H:%M:%S %b %d %Y" (current-time))))

(defun insert-date()
  "insert current time in the test"
  (interactive)
  (insert (format-time-string "%b %d %Y" (current-time))))

(global-set-key "\C-xt" 'insert-date)

(global-set-key "\M-[" 'shrink-window)
(global-set-key "\M-]" 'enlarge-window)

(put 'narrow-to-region 'disabled nil)

(put 'set-goal-column 'disabled nil)


;;======================================
;====key for window=====================
;=======================================
(global-set-key [(control {)] 'shrink-window-horizontally)
(global-set-key [(control })] 'enlarge-window-horizontally)


;; *********************************
;; ********** gtags **********
;; *********************************
;; (autoload 'gtags-mode "gtags" "" t)
;; (setq c-mode-hook
;;       '(lambda ()
;; 	 (gtags-mode 1)
;; 	 ))
;; (global-set-key "\M-." 'gtags-find-tag)
;; (global-set-key "\M-+" 'gtags-find-symbol)
;; (global-set-key "\M-_" 'gtags-find-rtag)


(require 'xcscope)
(setq cscope-do-not-update-database t)
(setq cscope-display-cscope-buffer t)

(global-set-key "\M-." 'cscope-find-global-definition)
(global-set-key "\M-+" 'cscope-next-symbol)
(global-set-key "\M-_" 'cscope-prev-symbol)
(global-set-key "\M-*" 'cscope-pop-mark)

(global-set-key "%" 'match-paren)
          
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((compile-command-alphaLX . "gcc -DMODULE -Wall -Wstrict-prototypes -O2 -c yellowfin.c -fomit-frame-pointer -fno-strength-reduce -mno-fp-regs -Wa,-m21164a -DBWX_USABLE -DBWIO_ENABLED") (c-set-style . "BSD")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


(defun my-insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%A, %B %d, %Y")
                 ((equal prefix '(4)) "%m-%d-%Y")
                 ((equal prefix '(16)) "%m.%d.%Y"))))
    (insert (format-time-string format))))

;; (add-to-list 'load-path "~/.lisp/git-emacs-1.1")
;; (require 'git-emacs)
(ansi-color-for-comint-mode-on)
;; **********************************
;; ********* Color Theme  ***********
;; **********************************
(load-file "~/.emacs.d/.lisp/color-theme.el")
(require 'color-theme)
;;(color-theme-gnome2)


;; (require 'gtags)
;; (global-unset-key "\M-.")
;; (global-set-key "\M-." 'gtags-find-tag)
;; (global-unset-key "\M-*")
;; (global-set-key "\M-*" 'gtags-pop-stack)
;; (global-set-key "\C-csa" 'gtags-visit-rootdir)
;; (global-set-key "\C-csc" 'gtags-find-rtag)
;; (global-set-key "\C-css" 'gtags-find-symbol)
(make-variable-buffer-local 'my-shell-mode-directory-changed)
(setq my-shell-mode-directory-changed t)

(defun my-shell-mode-auto-rename-buffer-output-filter (text)
  (if (and (eq major-mode 'shell-mode)
           my-shell-mode-directory-changed)
      (progn
        (let ((bn  (concat "sh:" default-directory)))
          (if (not (string= (buffer-name) bn))
              (rename-buffer bn t)))
        (setq my-shell-mode-directory-changed nil))))


(defun my-shell-mode-auto-rename-buffer-input-filter (text)
  (if (eq major-mode 'shell-mode)
      (if ( string-match "^[ \t]*cd *" text)
          (setq my-shell-mode-directory-changed t))))

(add-hook 'comint-output-filter-functions 'my-shell-mode-auto-rename-buffer-output-filter)
(add-hook 'comint-input-filter-functions 'my-shell-mode-auto-rename-buffer-input-filter)

;;(add-to-list 'load-path (expand-file-name "/home/songsy/.lisp/my_emacs_lisp/jde/lisp"))
;;(add-to-list 'load-path (expand-file-name "/home/songsy/.lisp/my_emacs_lisp/cedet/common"))
;;(load-file (expand-file-name "/home/songsy/.lisp/my_emacs_lisp/cedet/common/cedet.el"))
;;(add-to-list 'load-path (expand-file-name "/home/songsy/.lisp/my_emacs_lisp/elib"))

;;(require 'jde)
;;(server-start)
