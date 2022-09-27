;; -*- lexical-binding: t; -*-
(package-initialize)					;

(setq-default tab-width 4) ; set tab width to 4 for all buffers
(global-display-line-numbers-mode) ; line numbers
(menu-bar-mode -1) ; remove menu
(tool-bar-mode -1) ; remove tool bar
(scroll-bar-mode -1) ; remove scroll bar

(add-to-list 'exec-path "~/.local/lib")
(add-to-list 'custom-theme-load-path "~/.config/emacs/.emacs.d")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(mano))
 '(custom-safe-themes
   '("c47acb4cb9cf256550fe87d898faf1a7b75dbd63c6e7b7c44621dca7bc8f1c45" "01ab7d3b65b1cb57c38f3501e8051ecc6597abd10fec6d8620bac2db29dd18ec" "ec65f679d1618899fd3ddf6f0beda1f5ebf6047b388cbc05b9ce1b46d8d4d3ef" "65e61db7f10eecaf79e523c39b2554ff0544d7529ecba28438181e4acea5c18c" "883862a79d4701a48e16edf14ac300dc6e8afaa971ffcb07d4f0707b400cbf1d" "d011fd8fa3987ba00526803e897d1779c385d8854d113b6f3d76eac9e375ae9c" "e7b02b0490f265febdc5bee9486a7446bfdff72e1760182aaee1d9f18ad7c7d2" "29a655fe569f37b852fd6e9831e5053676800cedcf59c5cb3ac732ce0cec96da" "7deeec15979767556a2dc5e99fe6bd35579cbcd7dc10e19a9c4363aa57e523a7" "eef360d46867f20c59fa78754d579b6eecf621931b51dddfa23d0f87f5a9d7f5" "a005e507b0947ffc4f80278fbc666eae5ad3b1e08a6f452074f244d082fff8d1" "902b261c407d1afe8277292694b3d1475b8175b6453cfad365cc0838f4a11ce9" "1f975a68482a7c9386c69100f2f80f1fc87dd5ef48353fda850df58b5c0f4f9f" "89c57a9a98321b4210c2abfaf6781444b73d63e8f6926d99a9bcde876c56fa39" "6ca5f925de5c119694dbe47e2bc95f8bad16b46d154b3e2e0ae246fec4100ec5" default))
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
	 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
	 ("melpa" . "https://melpa.org/packages/")
	 ("melpa-stable" . "https://stable.melpa.org/packages/")))
 '(package-selected-packages
   '(lsp-mode auctex dante haskell-mode autothemer use-package elpy))
 '(warning-suppress-types
   '((emacs)
	 (use-package)
	 ((flymake flymake))
	 ((flymake flymake)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;;;;;;;;;;;;;;;;;;;;;;;; LANGUAGE
;; LSP


;; Python
(add-hook 'python-mode-hook 'lsp)

;; Color Scheme
(use-package autothemer
  :ensure t)

;; Haskell
(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  ;; OR for flymake support:
  (add-hook 'haskell-mode-hook 'flymake-mode)
  (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

  (add-hook 'haskell-mode-hook 'dante-mode))

;; LaTeX
(use-package auctex
  :ensure t
  :defer t
  :hook (LaTeX-mode .
					(lambda ()
					  (push (list 'output-pdf "Zathura")
							TeX-view-program-selection))))




