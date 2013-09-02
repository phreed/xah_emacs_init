
(defun xah-html-mode-keys ()
  "Modify keymaps used by `html-mode'."
  ;; .p gc
  ;; eu ht

  (local-set-key (kbd "<f6>") 'xah-browse-url-of-buffer)

  (local-set-key (kbd "<C-left>") 'xhm-skip-tag-backward)
  (local-set-key (kbd "<C-right>") 'xhm-skip-tag-forward)
  (local-set-key (kbd "<tab> 0") nil)
  (local-set-key (kbd "<tab> 1") nil)
  (local-set-key (kbd "<tab> 2") nil)
  (local-set-key (kbd "<tab> 3") nil)
  (local-set-key (kbd "<tab> 4") nil)
  (local-set-key (kbd "<tab> 5") 'mark-unicode)
  (local-set-key (kbd "<tab> 6") 'xhm-remove-html-tags)
  (local-set-key (kbd "<tab> 7") 'xhm-htmlize-or-de-precode)
  (local-set-key (kbd "<tab> 8") 'xhm-get-precode-make-new-file)
  (local-set-key (kbd "<tab> a") 'xwe-annotate)
  (local-set-key (kbd "<tab> b") 'make-blogger-entry)
  (local-set-key (kbd "<tab> c") 'xhm-make-citation)
  (local-set-key (kbd "<tab> d") 'insert-date-tag)
  (local-set-key (kbd "<tab> e") 'nil)
  (local-set-key (kbd "<tab> f") 'xah-copy-url-current-file)
  (local-set-key (kbd "<tab> g") 'xah-browse-url-of-buffer)
  (local-set-key (kbd "<tab> h") 'xah-all-linkify)
  (local-set-key (kbd "<tab> i") 'nil)
  (local-set-key (kbd "<tab> j") 'nil)
  (local-set-key (kbd "<tab> k") 'xhm-htmlize-keyboard-shortcut-notation)
  (local-set-key (kbd "<tab> l .") 'xhm-lines-to-html-list)
  (local-set-key (kbd "<tab> l 6") 'xhm-source-url-linkify)
  (local-set-key (kbd "<tab> l c") 'xwe-chinese-linkify)
  (local-set-key (kbd "<tab> l d") 'perldoc-ref-linkify)
  (local-set-key (kbd "<tab> l e") 'emacs-ref-linkify)
  (local-set-key (kbd "<tab> l f") 'full-size-img-linkify)
  (local-set-key (kbd "<tab> l i") 'image-linkify)
  (local-set-key (kbd "<tab> l j") 'image-file-to-html-figure-tag)
  (local-set-key (kbd "<tab> l p") 'php-ref-linkify)
  (local-set-key (kbd "<tab> l t") 'xwe-word-etymology-linkify)
  (local-set-key (kbd "<tab> l u") 'xhm-wrap-url)
  (local-set-key (kbd "<tab> l w") 'xhm-wikipedia-linkify)
  (local-set-key (kbd "<tab> l z") 'amazon-linkify)
  (local-set-key (kbd "<tab> m") 'xhm-pre-source-code)
  (local-set-key (kbd "<tab> n") 'nil)
  (local-set-key (kbd "<tab> o") 'nil)
  (local-set-key (kbd "<tab> p") 'xhm-wrap-p-tag)
  (local-set-key (kbd "<tab> q") 'nil)
  (local-set-key (kbd "<tab> r ,") 'xhm-replace-html-chars-to-unicode)
  (local-set-key (kbd "<tab> r .") 'xhm-replace-html-&<>-to-entities)
  (local-set-key (kbd "<tab> r 3") 'xhm-update-title)
  (local-set-key (kbd "<tab> r 4") 'xahsite-update-article-timestamp)
  (local-set-key (kbd "<tab> r c") 'code-bracket-to-html-tag)
  (local-set-key (kbd "<tab> r e") 'xhm-htmlize-elisp-keywords)
  (local-set-key (kbd "<tab> r k") 'xhm-emacs-to-windows-kbd-notation)
  (local-set-key (kbd "<tab> r m") 'xhm-make-html-table)
  (local-set-key (kbd "<tab> r t") 'title-bracket-to-html-tag)
  (local-set-key (kbd "<tab> s") 'nil)
  (local-set-key (kbd "<tab> t a") 'xah-make-atom-entry)
  (local-set-key (kbd "<tab> t l") 'xah-add-to-related-links)
  (local-set-key (kbd "<tab> t r") 'xhm-rename-html-inline-image)
  (local-set-key (kbd "<tab> t u") 'xhm-extract-url)
  (local-set-key (kbd "<tab> t") 'nil)
  (local-set-key (kbd "<tab> u") 'xhm-wrap-html-tag)
  (local-set-key (kbd "<tab> v") 'nil)
  (local-set-key (kbd "<tab> w") (lambda () (interactive) (xhm-wrap-html-tag "b" "w")))
  (local-set-key (kbd "<tab> x") 'nil)
  (local-set-key (kbd "<tab> y") 'nil)
  (local-set-key (kbd "<tab> z") 'nil)

)

(add-hook 'html-mode-hook 'xah-html-mode-keys)
(add-hook 'xah-html-mode-hook 'xah-html-mode-keys)
(add-hook 'nxml-mode-hook 'xah-html-mode-keys)

(defun xah-eval-defun ()
  "like `eval-defun' but doesn't need proper indentation for it to work.
Still, the code isn't 100% correct.
"
  (interactive)
  (save-excursion
    (search-backward "(defun")
    ;;    (mark-sexp)
    ;;    (eval-region (region-beginning) (region-end))
    (forward-sexp)
    (call-interactively 'eval-last-sexp)
    )
  )

;; (defun xah-cperl-mode-keys ()
;;   "Modify keymaps used by cperl-mode."
;;   (local-set-key (kbd ")") 'self-insert-command)
;;   (local-set-key (kbd "]") 'self-insert-command)
;; )
;; (add-hook 'cperl-mode-hook 'xah-cperl-mode-keys)

;; ;(setq mybuf (get-buffer-create "*show commands*"))
;; (defun xx ()
;;   "tttttt"
;;   (let ()
;;     (princ (format "%s\n" last-command) mybuf )
;;     )
;;   ;;(message "%s" last-command)
;;   )
;; (add-hook 'post-command-hook 'xx)
;; (remove-hook 'post-command-hook 'xx)

(defun xah-elisp-mode-keys ()
  "Modify keymaps used by lisp mode."
  ;; .p gc
  ;; eu ht

  (local-set-key (kbd "<tab> t") 'eval-last-sexp)
  (local-set-key (kbd "<tab> f") 'xah-eval-defun)
)

(add-hook 'xah-elisp-mode-hook 'xah-elisp-mode-keys)
(add-hook 'emacs-lisp-mode-hook 'xah-elisp-mode-keys)



(defun xah-magit-mode-keys ()
  "Modify keymaps ."
  (local-set-key (kbd "<tab> <tab>") 'magit-toggle-section)
)

(add-hook 'magit-mode-hook 'xah-magit-mode-keys)

;; (unload-feature 'sgml-mode)
;; (remove-hook 'html-mode-hook 'xah-html-mode-keys)

;; (defun xah-isearch-mode-keys ()
;;   "my keybindings for `isearch-mode'.
;; For `isearch-mode-hook'."
;;   (define-key isearch-mode-map (kbd "C-f") 'isearch-repeat-forward)
;;   )
;; (add-hook 'isearch-mode-hook 'xah-isearch-mode-keys )

(defun xah-rcirc-mode-keys ()
  "my keybindings for `rcirc'.
For `rcirc-mode-hook'."
  (local-set-key (kbd "<f11>") 'rcirc-insert-prev-input)
  (local-set-key (kbd "<f12>") 'rcirc-insert-next-input)
  )
(add-hook 'rcirc-mode-hook 'xah-rcirc-mode-keys)

(defun xah-org-mode-keys ()
  "my keybindings for `org-mode'.
For `org-mode-hook'."
  (local-set-key (kbd "<M-up>") 'org-metaup)
  (local-set-key (kbd "<M-down>") 'org-metadown)
  (local-set-key (kbd "<M-left>") 'org-metaleft)
  (local-set-key (kbd "<M-right>") 'org-metaright)
  )
(add-hook 'org-mode-hook 'xah-org-mode-keys)

(defun xah-Info-mode-keys ()
  "my keybindings for `Info-mode'.
For `Info-mode-hook'."
  (local-set-key (kbd "<tab> g") 'xah-view-emacs-manual-in-browser)
  )
(add-hook 'Info-mode-hook 'xah-Info-mode-keys)

(defun xah-dired-mode-keys ()
  "Modify keymaps used by `dired'."
;;  (define-key dired-mode-map (kbd "<return>") 'dired-find-alternate-file) ; was dired-advertised-find-file
;;  (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file ".."))) ; was dired-up-directory
  ;; (define-key dired-mode-map (kbd "M-$") nil) ; was dired-up-directory
;; (local-set-key (kbd "6") 'dired-up-directory)
  (when (>= emacs-major-version 23)
;    (define-key dired-mode-map (kbd "M-s") 'isearch-forward)
;    (define-key dired-mode-map (kbd "M-S") 'isearch-backward)
    (define-key dired-mode-map (kbd "<tab> 8") 'wdired-change-to-wdired-mode)
    )
  )

(add-hook 'dired-mode-hook 'xah-dired-mode-keys)