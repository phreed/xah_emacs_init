;; -*- coding: utf-8 -*-
;; some custome functions to syntax color source code for publishing in HTML. i.e. htmlize
;; 2011-05-29
;;   Xah Lee
;; ∑ http://xahlee.org/



(require 'htmlize)

(defvar ξ-language-name-map nil "a alist that maps lang name. Each element has this form 「(‹lang code› . [‹emacs major mode name› ‹file_extension›])」")
(setq ξ-language-name-map
'(
           ("ahk" . ["ahk-mode" "ahk"])

           ("code" . ["fundamental-mode" "txt"])
           ("output" . ["fundamental-mode" "txt"])

           ("bash" . ["sh-mode" "sh"])
           ("bash-output" . ["sh-mode" "sh"])
           ("unix-config" . ["conf-space-mode" "conf"])
           ("cmd" . ["dos-mode" "bat"])

           ("bbcode" . ["xbbcode-mode" "bbcode"])
           ("c" . ["c-mode" "c"])
           ("cpp" . ["c++-mode" "cpp"])
           ("cl" . ["lisp-mode" "lisp"])

           ("org-mode" . ["org-mode" "org"])

           ("clojure" . ["clojure-mode" "clj"])
           ("css" . ["css-mode" "css"])
           ("elisp" . ["emacs-lisp-mode" "el"])
           ("haskell" . ["haskell-mode" "hs"])
           ("html" . ["html-mode" "html"])
           ("mysql" . ["sql-mode" "sql"])
           ("xml" . ["sgml-mode"])
           ("html6" . ["xah-html6-mode" "html6"])
           ("java" . ["java-mode" "java"])
           ("js" . ["js-mode" "js"])
           ("lsl" . ["xlsl-mode" "lsl"])
           ("ocaml" . ["tuareg-mode" "ocaml"])
           ("org" . ["org-mode" "org"])
           ("perl" . ["cperl-mode" "pl"])
           ("php" . ["php-mode" "php"])
           ("povray" . ["pov-mode" "pov"])
           ("powershell" . ["powershell-mode" "ps1"])
           ("python" . ["python-mode" "py"])
           ("python3" . ["python-mode" "py3"])
           ("qi" . ["shen-mode" "qi"])
           ("ruby" . ["ruby-mode" "rb"])
           ("scala" . ["scala-mode" "scala"])
           ("scheme" . ["scheme-mode" "scm"])
           ("yasnippet" . ["snippet-mode" "yasnippet"])
           ("vbs" . ["visual-basic-mode" "vbs"])
           ("visualbasic" . ["visual-basic-mode" "vbs"])
           ("mma" . ["fundamental-mode" "m"])
           ) )

(defun get-pre-block-langCode ()
  "Get the langCode and boundary of current HTML pre block.
A pre block is text of this form
<pre class=\"‹langCode›\">…▮…</pre>.

Returns a vector [langCode pos1 pos2], where pos1 pos2 are the boundary of the text content."
  (interactive)
  (let (langCode p1 p2)
    (if (region-active-p)
        (progn
          (setq p1 (region-beginning) )
          (setq p2 (region-end) )
          (setq langCode (read-string "langcode:"))
          (vector langCode p1 p2)
          )
      (save-excursion
        (re-search-backward "<pre class=\"\\([-A-Za-z0-9]+\\)\"") ; tag begin position
        (setq langCode (match-string 1))
        (setq p1 (search-forward ">"))    ; text content begin
        (search-forward "</pre>")
        (setq p2 (search-backward "<"))   ; text content end
        (vector langCode p1 p2)
 ) ) ))

(defun get-pre-block-make-new-file (ξlangNameMap)
  "Create a new file on current dir with text inside pre code block.
For example, if the cursor is somewhere between the tags:
<pre class=\"…\">…▮…</pre>

after calling, all a new file of name 「xx-‹random›.‹suffix›」 is created in current dir, with content from the block.

If there's a text selection, use that region as content."
  (interactive (list ξ-language-name-map))
  (let* (
        (ξxx (get-pre-block-langCode))
        (ξlangCode (elt ξxx 0))
        (p1 (elt ξxx 1))
        (p2 (elt ξxx 2))
        (ξyy (cdr (assoc ξlangCode ξlangNameMap)))
        (ξfileSuffix (elt ξyy 1))
        (ξtextContent (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" (buffer-substring-no-properties p1 p2))) )
        )
    (delete-region p1 p2 )
    (split-window-vertically)
    (find-file (format "xx-testscript-%d.%s" (random 9008000 ) ξfileSuffix) )
    (insert ξtextContent)
    ;; (save-buffer )
    )
  )

(defun ξhtmlize-string (ξsourceCodeStr ξmajorModeName)
  "Take ξsourceCodeStr and return a htmlized version using major mode ξmajorModeName.
The purpose is to syntax color source code in HTML.
This function requires the `htmlize-buffer' from 〔htmlize.el〕 by Hrvoje Niksic."
  (interactive)
  (let (htmlizeOutputBuffer resultStr)
    ;; put code in a temp buffer, set the mode, fontify
    (with-temp-buffer
      (insert ξsourceCodeStr)
      (funcall (intern ξmajorModeName))
      (font-lock-fontify-buffer)
      (setq htmlizeOutputBuffer (htmlize-buffer))
      )
    ;; extract the fontified source code in htmlize output
    (with-current-buffer htmlizeOutputBuffer
      (let (p1 p2 )
        (setq p1 (search-forward "<pre>"))
        (setq p2 (search-forward "</pre>"))
        (setq resultStr (buffer-substring-no-properties (+ p1 1) (- p2 6))) ) )
    (kill-buffer htmlizeOutputBuffer)
    resultStr ) )

(defun htmlize-pre-block (ξlangCodeMap)
  "Replace text enclosed by “pre” tag to htmlized code.
For example, if the cursor is somewhere between the pre tags <pre class=\"‹langCode›\">…▮…</pre>, then after calling, the text inside the pre tag will be htmlized.  That is, wrapped with many span tags.

The opening tag must be of the form <pre class=\"‹langCode›\">.  The ‹langCode› determines what emacs mode is used to colorize the text. See `ξ-language-name-map' for possible ‹langCode›.

See also: `dehtmlize-pre-block', `htmlize-or-dehtmlize-pre-block'.
This function requires the `htmlize-buffer' from 〔htmlize.el〕 by Hrvoje Niksic."
  (interactive (list ξ-language-name-map))
  (let (ξlangCode p1 p2 inputStr ξmodeName )

    (save-excursion
      (let (( ξxx (get-pre-block-langCode)))
        (setq ξlangCode (elt ξxx 0))
        (setq p1 (elt ξxx 1))
        (setq p2 (elt ξxx 2))
        (setq inputStr (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" (buffer-substring-no-properties p1 p2))) )
        (setq ξmodeName (elt (cdr (assoc ξlangCode ξlangCodeMap)) 0))
        )
      (delete-region p1 p2 )
      (goto-char p1)
      (insert (ξhtmlize-string inputStr ξmodeName))
      )
    ) )

(defun dehtmlize-pre-block ()
  "Delete span tags between pre tags.

Note: only span tags of the form 「<span class=\"…\">…</span>」 are deleted.

This command does the reverse of `htmlize-pre-block'."
  (interactive)
  (let (( ξxx (get-pre-block-langCode)))
    (xhm-remove-span-tag-region (elt ξxx 1) (elt ξxx 2))
    )
  )

(defun htmlize-or-dehtmlize-pre-block (langCodeMap)
  "Call `htmlize-pre-block' or `dehtmlize-pre-block'."
  (interactive (list ξ-language-name-map))
  (let* (
         (ξxx (get-pre-block-langCode))
         (langCode (elt ξxx 0))
         (p1 (elt ξxx 1))
         (p2 (elt ξxx 2))
         (inputStr (buffer-substring-no-properties p1 p2) )
         )

    (message "%s" langCode)
    (if (string-match "<span class=\\|&amp;\\|&lt;\\|&gt;" inputStr)
        (xhm-remove-span-tag-region p1 p2)
      (progn               ;; do htmlize
        (let (
              langCodeResult
              ξmode-name)
          (setq langCodeResult (assoc langCode langCodeMap))
          (if (eq langCodeResult nil)
              (progn (error "Your lang code 「%s」 is not recognized." langCode))
            (progn
              (save-excursion
                (setq ξmode-name (elt (cdr langCodeResult) 0))
                (delete-region p1 p2)
(let ((tempstr inputStr))
 (setq tempstr (replace-regexp-in-string "\\`[ \t\n]*" "\n" tempstr) ) ; trim beginning
 (setq tempstr (replace-regexp-in-string "[ \t\n]+\\'" "\n" tempstr) ) ; trim trailing
 (insert (ξhtmlize-string tempstr ξmode-name))
)
                 
                )) )) )) ))







