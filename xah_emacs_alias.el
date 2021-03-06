;; -*- coding: utf-8 -*-
;; emacs customization for command aliases
;; Xah Lee ; 2007-06

; shortening of often used commands

(defalias 'yes-or-no-p 'y-or-n-p)

(defalias 'fd 'find-dired)
(defalias 'gf 'grep-find)
(defalias 'lcd 'list-colors-display)
(defalias 'rb 'revert-buffer)
(defalias 'rs 'replace-string)
(defalias 'sl 'sort-lines)
(defalias 'snf 'sort-numeric-fields)
(defalias 'g 'grep)
(defalias 'ds 'desktop-save)
(defalias 'dt 'desktop-save)
(defalias 'dsm 'desktop-save-mode)

(defalias 'elm 'emacs-lisp-mode)
(defalias 'hm 'html-mode)

(defalias 'ssm 'shell-script-mode)

(defalias 'tpu-edt 'forward-char)
(defalias 'tpu-edt-on 'forward-char) ; fuck tpu-edt


;; xah personal

(defalias '8w 'xah-words-new-word-entry)
(defalias '8d 'xah-words-add-definition)
(defalias '8s 'xah-words-add-source)
(defalias '8c 'xah-words-add-comment)
