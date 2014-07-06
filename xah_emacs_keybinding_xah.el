;; -*- coding: utf-8 -*-

(progn
  ;; this should reserved for user-defined keys
  (define-prefix-command 'xah-user-keymap)

  (define-key xah-user-keymap (kbd "<menu>") nil)
  (define-key xah-user-keymap (kbd "SPC") 'ace-jump-mode)
  (define-key xah-user-keymap (kbd "<return>") 'xah-run-current-file)
  (define-key xah-user-keymap (kbd "<backspace>") 'xah-delete-current-file)
  (define-key xah-user-keymap (kbd "<tab>") nil)
  (define-key xah-user-keymap (kbd "<delete>") nil)
  (define-key xah-user-keymap (kbd "<home>") nil)
  (define-key xah-user-keymap (kbd "<end>") nil)

  (define-key xah-user-keymap (kbd "-") 'xah-insert-form-feed)
  (define-key xah-user-keymap (kbd ".") 'title-case-string-region-or-line)

  (define-key xah-user-keymap (kbd "1") 'xah-copy-to-register-1)
  (define-key xah-user-keymap (kbd "2") 'xah-paste-from-register-1)
  (define-key xah-user-keymap (kbd "3") nil)
  (define-key xah-user-keymap (kbd "4") nil)
  (define-key xah-user-keymap (kbd "7") nil)
  (define-key xah-user-keymap (kbd "8") nil)

  (define-key xah-user-keymap (kbd "a") 'ace-jump-mode-pop-mark)
  (define-key xah-user-keymap (kbd "b") 'xah-shell-commands)
  (define-key xah-user-keymap (kbd "c") 'xah-cite)
  (define-key xah-user-keymap (kbd "d") 'insert-date)
  (define-key xah-user-keymap (kbd "e") 'xah-open-file-fast)
  (define-key xah-user-keymap (kbd "f") 'xah-find-text)
  (define-key xah-user-keymap (kbd "g") nil)

  (define-key xah-user-keymap (kbd "h") nil)
  (define-key xah-user-keymap (kbd "i n") 'xah-insert-random-number)
  (define-key xah-user-keymap (kbd "i s") 'xah-insert-random-string)
  (define-key xah-user-keymap (kbd "i u") 'xah-insert-random-uuid)
  (define-key xah-user-keymap (kbd "i x") 'xah-insert-random-hex)
  (define-key xah-user-keymap (kbd "j") nil)
  (define-key xah-user-keymap (kbd "k") nil)
  (define-key xah-user-keymap (kbd "l") nil)
  (define-key xah-user-keymap (kbd "m") 'magit-status)
  (define-key xah-user-keymap (kbd "n") 'xah-make-backup)
  (define-key xah-user-keymap (kbd "o") 'xah-open-file-from-clipboard)
  (define-key xah-user-keymap (kbd "p") 'xah-copy-file-path)
  (define-key xah-user-keymap (kbd "q") nil)
  (define-key xah-user-keymap (kbd "r c") 'xah-escape-quotes)
  (define-key xah-user-keymap (kbd "r '") 'xah-replace-straight-quotes)
  (define-key xah-user-keymap (kbd "r ,") 'xah-remove-punctuation-trailing-redundant-space)
  (define-key xah-user-keymap (kbd "r .") 'xah-convert-english-chinese-punctuation)
  (define-key xah-user-keymap (kbd "r [") 'xah-remove-square-brackets)
  (define-key xah-user-keymap (kbd "r g") 'xah-convert-latin-alphabet-gothic)
  (define-key xah-user-keymap (kbd "r p") 'xah-convert-asian/ascii-space)
  (define-key xah-user-keymap (kbd "r w") 'xah-convert-fullwidth-chars)
  (define-key xah-user-keymap (kbd "s") nil)
  (define-key xah-user-keymap (kbd "t") nil)
  (define-key xah-user-keymap (kbd "u") 'xah-find-replace-text)
  (define-key xah-user-keymap (kbd "v") nil)
  (define-key xah-user-keymap (kbd "w") nil)
  (define-key xah-user-keymap (kbd "y") 'xah-open-last-closed)
  (define-key xah-user-keymap (kbd "z") 'xah-toggle-read-novel-mode))

(global-set-key (kbd "<end>") xah-user-keymap)
