;; -*- coding: utf-8 -*-
;; some font related emacs commands

;; 2011-03-08
;;   Xah Lee
;; ∑ http://xahlee.org/

;; Emacs: How to List ＆ Set Font
;; http://ergoemacs.org/emacs/emacs_list_and_set_font.html

;; Emacs: How to Quickly Switch Fonts
;; http://ergoemacs.org/emacs/emacs_switching_fonts.html


;; specify font for all unicode characters
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))


;; set default font
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (when (member "DejaVu Sans Mono" (font-family-list))
    (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10")))
  )
 ((string-equal system-type "darwin")   ; Mac OS X
  (when (member "DejaVu Sans Mono" (font-family-list))
    (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10")))
  )
 ((string-equal system-type "gnu/linux") ; linux
  (when (member "DejaVu Sans Mono" (font-family-list))
    (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-10")))
  )
 )



;; use variable-width font for some modes
(defun xah-font-change ()
  "Set current buffer to use variable-width font."
  (variable-pitch-mode 1)
  ;; (text-scale-increase 0.5 )
)

(add-hook 'html-mode-hook 'xah-font-change)
(add-hook 'xah-html-mode-hook 'xah-font-change)
(add-hook 'nxml-mode-hook 'xah-font-change)



(defun xah-set-font-to-monospace ()
  "Change font in current window to a monospaced font."
  (interactive)
  (set-frame-font "DejaVu Sans Mono" t)
  )

(defun xah-set-font-to-variable-width ()
  "Change font in current window to a variable-width font."
  (interactive)
  (set-frame-font "DejaVu Sans" t)
  )



(defun xah-cycle-font-2 (εn)
  "Change font in current window between 2 fonts."
  (interactive "p")
  ;; this function sets a property “state”. It is a integer. Possible values are any index to the fontList.
  (let (
        (ξ-font-list (list "DejaVu Sans Mono-10" "DejaVu Sans-10" ))
        fontToUse
        stateBefore
        stateAfter )

    (setq stateBefore (if (get 'xah-cycle-font-2 'state) (get 'xah-cycle-font-2 'state) 0))
    (setq stateAfter (% (+ stateBefore (length ξ-font-list) εn) (length ξ-font-list)))
    (put 'xah-cycle-font-2 'state stateAfter)

    (setq fontToUse (nth stateAfter ξ-font-list))
    ;; (set-frame-font fontToUse t)
    (set-frame-parameter nil 'font fontToUse)
    (message "Current font is: %s" fontToUse )
    )
  )



(defcustom ξ-font-list nil "A list of fonts for `xah-cycle-font' to cycle from." :group 'font)

(set-default 'ξ-font-list
             (cond
              ((string-equal system-type "windows-nt") ; Windows
               '(
                 "Courier New-10"
                 "DejaVu Sans Mono-9"
                 "Lucida Console-10"
                 "Segoe UI Symbol-12"

                 "DejaVu Sans-10"
                 "Lucida Sans Unicode-10"
                 )
               )
              ((string-equal system-type "gnu/linux")
               '(
                 "DejaVu Sans Mono-9"
                 "DejaVu Sans-9"
                 "Symbola-13"
                 )
               )
              ((string-equal system-type "darwin") ; Mac
               '(
                 "DejaVu Sans Mono-9"
                 "DejaVu Sans-9"
                 "Symbola-13"
                 ) ) )
             )

(defun xah-cycle-font (εn)
  "Change font in current frame.
Each time this is called, font cycles thru a predefined list of fonts in the variable `ξ-font-list' .
If εn is 1, cycle forward.
If εn is -1, cycle backward.
See also `xah-cycle-font-next', `xah-cycle-font-previous'."
  (interactive "p")
  ;; this function sets a property “state”. It is a integer. Possible values are any index to the fontList.
  (let (fontToUse stateBefore stateAfter )
    (setq stateBefore (if (get 'xah-cycle-font 'state) (get 'xah-cycle-font 'state) 0))
    (setq stateAfter (% (+ stateBefore (length ξ-font-list) εn) (length ξ-font-list)))

    (setq fontToUse (nth stateAfter ξ-font-list))
    (set-frame-font fontToUse t)
    ;; (set-frame-parameter nil 'font fontToUse)
    (message "Current font is: %s" fontToUse )
    (put 'xah-cycle-font 'state stateAfter) ) )

(defun xah-cycle-font-next ()
  "Switch to the next font, in current window.
See `xah-cycle-font'."
  (interactive)
  (xah-cycle-font 1) )

(defun xah-cycle-font-previous ()
  "Switch to the previous font, in current window.
See `xah-cycle-font'."
  (interactive)
  (xah-cycle-font -1) )



(defun xah-unfontify-selection-or-block ()
  "Unfontify text selection or current block of text.
See also: `font-lock-fontify-block', `font-lock-fontify-buffer'."
  (interactive)
  (let (bds p1 p2 )
    (setq bds (get-selection-or-unit 'block))
    (setq p1 (elt bds 1) p2 (elt bds 2)  )
    (font-lock-unfontify-region p1 p2)
    )
  )

(defun xah-toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height."
  (interactive)
  (if (eq line-spacing nil)
      (setq-default line-spacing 0.5) ; add 0.5 height between lines
    (setq-default line-spacing nil)   ; no extra heigh between lines
    )
  (redraw-display))

(defun xah-toggle-margin-right ()
  "Toggle the right margin between `fill-column' or window width.
This command is convenient when reading novel, documentation."
  (interactive)
  (if (eq (cdr (window-margins)) nil)
      (set-window-margins nil 0 (- (window-body-width) fill-column))
    (set-window-margins nil 0 0) ) )

(defun xah-toggle-read-novel-mode ()
  "make current window in a easy reading moder for article/novel text."
  (interactive)
  (let (
        ;; (thisFrame (make-frame '( (nam . "xah reading frame") (width . 70) )))
        )
    (if (equal (get this-command 'state) nil)
        (progn
          (set-frame-width (window-frame) 70)
          (variable-pitch-mode 1)
          (setq word-wrap t)
          (put this-command 'state t)
          )
      (progn
        (set-frame-width (window-frame) 100)
        (variable-pitch-mode 0)
        (setq word-wrap nil)
        (put this-command 'state nil)
        ) ) ) )

;; correct syntax for some fonts (tested on Windows Vista)
;; "-*-Courier New-normal-r-*-*-14-112-96-96-c-*-iso8859-1"
;; "-outline-Lucida Sans Unicode-normal-normal-normal-sans-13-*-*-*-p-*-iso8859-1"
;; "-outline-Code2000-normal-normal-normal-*-15-*-*-*-p-*-iso8859-1"
;; "-raster-Fixedsys-normal-normal-normal-mono-15-*-*-*-c-*-iso8859-1"
;; "-outline-FixedsysTTF-semi-bold-normal-normal-mono-16-*-*-*-c-*-iso8859-1"

;; fixed-width "Courier New" "Unifont"  "FixedsysTTF" "Miriam Fixed" "Lucida Console" "Lucida Sans Typewriter" "DejaVu Sans Mono-10" "Lucida Console-10"
;; variable-width "Arial Unicode MS-10" "Code2000" "STIXGeneral" "Lucida Console-10"
