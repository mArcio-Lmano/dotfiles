(require 'autothemer)

(autothemer-deftheme
 mano "A theme to set the mood for Mano"

 ((((class color) (min-colors #xFFFFFF))) ;; We're only concerned with graphical Emacs

  ;; Define our color palette
  (mano-black      "#000000")
  (mano-sf-green   "#dcffd6")
  (mano-orange     "#f97acc")
  (mano-sf-black   "#101010")
  (mano-purple     "MediumPurple2")
  (mano-dk-purple  "MediumPurple4")
  (mano-green      "#a7d407"))

 ;; Customize faces
 ((default                   (:foreground mano-sf-green :background mano-sf-black))
  (cursor                    (:background mano-green))
  (region                    (:background mano-dk-purple))
  (mode-line                 (:background mano-dk-purple))
  (font-lock-keyword-face    (:foreground mano-purple))
  (font-lock-constant-face   (:foreground mano-green))
  (font-lock-string-face     (:foreground mano-orange))
  (font-lock-builtin-face    (:foreground mano-green))
  (font-latex-sedate-face    (:foreground mano-dk-purple))
  ))

(provide-theme 'mano)
