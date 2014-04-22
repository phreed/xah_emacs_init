;; -*- coding: utf-8 -*-
;; some custome string functions for working with HTML
;; most things moved to xah-html-mode
;; ∑ http://xahlee.org/

(defun forward-html-end-tag ()
  "Move cursor to the next HTML tag's content."
  (interactive)
  (forward-char 1)
  (search-forward "</")
  (backward-char 2)
  )

(defun backward-html-end-tag ()
  "Move cursor to the previous HTML tag's content."
  (interactive)
  (search-backward "</")
  ;; (forward-char-char 2)
  )



(defun xah-ref-span-tag ()
  "Add <p>…</p> tag to current text block or text selection.
If there's a text selection, wrap p around each text block (separated by 2 newline chars.)"
  (interactive)
  (let (bds p1 p2 inputText)
    (setq bds (get-selection-or-unit 'line))
    (setq inputText (elt bds 0) )
    (setq p1 (elt bds 1) )
    (setq p2 (elt bds 2) )
    (set-mark p1)
    (goto-char p2)
    (xhm-wrap-html-tag "span" "ref")
    ) )

(defun xah-mark-unicode (p1)
  "Wrap 「<mark class=\"unicode\" title=\"U+…: ‹NAME›\"></mark>」 around current character.
When called in elisp program, wrap the tag at cursor position p1."
  (interactive (list (point)))
  (let* (
         (ξcodepoint (string-to-char (buffer-substring-no-properties p1 (1+ p1))) )
         (ξname (get-char-code-property ξcodepoint 'name))
         )
    (goto-char p1)
    (insert (format "<mark class=\"unicode\" title=\"U+%X: %s\">" ξcodepoint ξname) )
    (forward-char 1)
    (insert (format "</mark>") )
    ) )



(defun xahsite-update-article-timestamp ()
  "Update article's timestamp.
Add today's date to the byline tag of current file, also delete the last one if there are more than one."
  (interactive)
  (let (p1 p2 ξnum )
    (progn
      (goto-char 1)
      (when (search-forward "<div class=\"byline\">" nil)
        (setq p1 (point) )
        (backward-char 1)
        (sgml-skip-tag-forward 1)
        ;; (search-forward "</time></div>")
        (setq p2 (point) )

        (setq ξnum (count-matches "<time>" p1 p2 ) )

        ;; if there are more than 1 “time” tag, delete the last one
        (when (> ξnum 1)
          (let (p3 p4)
            (goto-char p2)
            (search-backward "</time>")
            (setq p4 (+ (point) 7) )
            (search-backward "<time>")
            (setq p3 (point) )
            (delete-region p3 p4 )
            ) )

        ;; insert new time
        (goto-char p2)
        (search-backward "</div>")
        (insert (format ", <time>%s</time>" (format-time-string "%Y-%m-%d")))

        ;; remove repeated comma separator
        (replace-pairs-region p1 (line-end-position) [ [", , " ", "] ])
        (replace-pairs-region p1 (line-end-position) [ ["</time>, <time>" "</time>, …, <time>"] ])

        (message "%s" (buffer-substring-no-properties p1 (line-end-position)))
        (search-backward "<time>")
        ))
       ) )

(defun xahsite-update-page-tag-old (p1 p2)
  "Update HTML page navigation tags.

The input is a text selection.
Each line should a file name
Update each file's page navigation tag.

Each file name is a file path without dir, and relative to current dir.
Sample text selection for input:
“combowords.html
combowords-2.html
combowords-3.html
combowords-4.html”"
  (interactive "r")
  (let (filez pageNavStr (i 1))
    (setq filez
          (split-string (buffer-substring-no-properties p1 p2) "\n" t)
          )

    (delete-region p1 p2)

    ;; generate the page nav string
    (setq pageNavStr "<div class=\"pgs\">")

    (while (<= i (length filez))
      (setq pageNavStr
            (concat pageNavStr
                    "<a href=\""
                    (nth (- i 1) filez)
                    "\">"
                    (number-to-string i)
                    "</a>, ")
            )
      (setq i (1+ i))
      )

    (setq pageNavStr (substring pageNavStr 0 -2) ) ; remove the last ", "
    (setq pageNavStr (concat pageNavStr "</div>"))

    ;; open each file, insert the page nav string, remove link in the
    ;; nav string that's the current page
    (mapc
     (lambda (thisFile)
       (message "%s" thisFile)
       (find-file thisFile)
       (goto-char (point-min))
       (search-forward "<div class=\"pgs\">")
       (beginning-of-line)
       (kill-line 1)
       (insert pageNavStr "\n")
       (search-backward (file-name-nondirectory buffer-file-name))

       (require 'sgml-mode)
       (sgml-delete-tag 1)
       ;;        (save-buffer)
       ;;        (kill-buffer)
       )
     filez)
    ))

(defun xahsite-update-page-tag ()
  "Update HTML page navigation tags.

The input is a text block or text selection.
Each line should a file name/path (can be relative path)
Update each file's page navigation tag.

Each file name is a file path without dir, and relative to current dir.
Sample text selection for input:

words.html
words-2.html
words-3.html
words-4.html
"
  (interactive)
  (require 'sgml-mode)
  (let (bds p1 p2 inputStr fileList pageNavStr )
    (setq bds (get-selection-or-unit 'block))
    (setq inputStr (elt bds 0) p1 (elt bds 1) p2 (elt bds 2)  )
    (setq fileList (split-string (buffer-substring-no-properties p1 p2) "\n" t) )

    (delete-region p1 p2)

    ;; generate the page nav string
    (setq pageNavStr (format "<nav class=\"page\">\n%s</nav>"
                             (let (ξresult linkPath fTitle (ξi 0) )
                               (while (< ξi (length fileList))
                                 (setq linkPath (elt fileList ξi) )
                                 (setq fTitle (xhm-get-html-file-title linkPath) )
                                 (setq ξresult (concat ξresult "<a href=\"" linkPath "\" title=\"" fTitle "\">" (number-to-string (1+ ξi)) "</a>\n") )
                                 (setq ξi (1+ ξi))
                                 )
                               ξresult
                               )))

    ;; open each file, insert the page nav string
    (mapc
     (lambda (thisFile)
       (message "%s" thisFile)
       (find-file thisFile)
       (goto-char 1)

       (if
           (search-forward "<nav class=\"page\">" nil t)
           (let (p3 p4 )
             (search-backward "<")
             (setq p3 (point))
             (sgml-skip-tag-forward 1)
             (setq p4 (point))
             (delete-region p3 p4)
             (insert pageNavStr)
             )
         (progn
           (search-forward "<script><!--
google_ad_client")
           (progn
             (search-backward "<script>")
             (insert pageNavStr "\n\n")
             ) ) )

       )
     fileList)
    ))

(defun xah-syntax-color-hex ()
"Syntax color hex color spec such as 「#ff1100」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer)
  )

(defun xah-syntax-color-hsl ()
  "Syntax color hex color spec such as 「hsl(0,90%,41%)」 in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
  '(("hsl( *\\([0-9]\\{1,3\\}\\) *, *\\([0-9]\\{1,3\\}\\)% *, *\\([0-9]\\{1,3\\}\\)% *)"
     (0 (put-text-property
         (+ (match-beginning 0) 3)
         (match-end 0)
         'face (list :background
 (concat "#" (mapconcat 'identity 
                        (mapcar
                         (lambda (x) (format "%02x" (round (* x 255))))
                         (color-hsl-to-rgb
                          (/ (string-to-number (match-string-no-properties 1)) 360.0)
                          (/ (string-to-number (match-string-no-properties 2)) 100.0)
                          (/ (string-to-number (match-string-no-properties 3)) 100.0)
                          ) )
                        "" )) ;  "#00aa00"
                      ))))) )
  (font-lock-fontify-buffer)
  )

;; (concat "#" (mapconcat 'identity 
;;                         (mapcar
;;                          (lambda (x) (format "%x" (round (* x 255))))
;;                          (color-hsl-to-rgb
;;                           (/ (string-to-number "0") 360.0)
;;                           (/ (string-to-number "90") 100.0)
;;                           (/ (string-to-number "50") 100.0)
;;                           ) )
;;                         "" ))

;; (format "%2x" (round (* (/ (string-to-number "49") 100.0) 255)))
;; (format "%02x" 10)

(add-hook 'xah-php-mode-hook 'xah-syntax-color-hex)
(add-hook 'xah-php-mode-hook 'xah-syntax-color-hex)

(add-hook 'xah-html-mode-hook 'xah-syntax-color-hsl)
(add-hook 'xah-html-mode-hook 'xah-syntax-color-hsl)


