
(beacon-mode 1)
(setq doom-font (font-spec :family "Agave Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "Agave Nerd Font" :size 13))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
(setq user-full-name "aidr"
      user-mail-address "aid****@gmail.com")
(setq
 org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿" "◆")
 )
(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree"  "d n" #'neotree-dir)
(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
              (:map dired-mode-map
               :desc "Dired view file" "d v" #'dired-view-file)))
(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file ; use dired-find-file instead of dired-open.
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-up-directory
  (kbd "% l") 'dired-downcase
  (kbd "% u") 'dired-upcase
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

;;emacs-dashboard setup
(require 'all-the-icons)
(require 'dashboard)
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
      doom-fallback-buffer-name "*dashboard*")
(setq image-scaling-factor 1)

;; emacs-dashboard variables
(setq dashboard-banner-logo-title "Welcome to Nix Doom Emacs")
(setq dashboard-startup-banner "~/Pictures/doom-vapourwave.png")
(setq dashboard-icon-type 'all-the-icons)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-items '())
(setq dashboard-center-content t)
(setq dashboard-footer-messages '("Here to do customizing, or actual work?"
                                  "M-x insert-inspiring-message"
                                  "My software never has bugs. It just develops random features."
                                  "Dad, what are clouds made of? Linux servers, mostly."
                                  "There is no place like ~"
                                  "~ sweet ~"
                                  "sudo chown -R us ./allyourbase"
                                  "I’ll tell you a DNS joke but it could take 24 hours for everyone to get it."
                                  "I'd tell you a UDP joke, but you might not get it."
                                  "I'll tell you a TCP joke. Do you want to hear it?"))

;; Remove basic evil input and cursors from dashboard
(defun disable-cursor()
  (setq-local evil-normal-state-cursor '(bar . 0))
  (hl-line-mode -1)
  )
(add-hook 'dashboard-mode-hook 'disable-cursor)
(evil-define-key 'normal dashboard-mode-map
  "j" 'evil-normal-state
  "k" 'evil-normal-state
  "h" 'evil-normal-state
  "l" 'evil-normal-state)
(setq dashboard-navigator-buttons
      `(;; line1
        ( (,"Roam" "" "" (lambda (&rest _)) 'org-formula)
          (,(all-the-icons-octicon "globe" :height 1.0 :v-adjust 0.0)
           "Notes overview" "" (lambda (&rest _) (org-roam-default-overview)) 'org-formula)
          (,(all-the-icons-fileicon "org" :height 1.0 :v-adjust 0.0)
           "Switch roam db" "" (lambda (&rest _) (org-roam-switch-db)) 'org-formula)
          )
        ;; line 2
        ( (,"Git" "" "" (lambda (&rest _)) 'diredfl-exec-priv)
          (,(all-the-icons-octicon "mark-github" :height 1.0 :v-adjust 0.0)
           "GitHub" "" (lambda (&rest _) (browse-url "https://github.com/aidrzum")) 'diredfl-exec-priv)
          (,(all-the-icons-faicon "gitlab" :height 1.0 :v-adjust 0.0)
           "GitLab" "" (lambda (&rest _) (browse-url "https://gitlab.com/aidrzum")) 'diredfl-exec-priv)
          (,(all-the-icons-faicon "coffee" :height 1.0 :v-adjust 0.0)
           "Gitea" "" (lambda (&rest _) (browse-url my-gitea-domain)) 'diredfl-exec-priv)
          (,(all-the-icons-octicon "triangle-up" :height 1.2 :v-adjust -0.1)
           "Codeberg" "" (lambda (&rest _) (browse-url "https://codeberg.org/aidrzum")) 'diredfl-exec-priv)
          )
        ;; line 3
        ( (,"Agenda" "" "" (lambda (&rest _)) 'dired-warning)
          (,(all-the-icons-octicon "checklist" :height 1.0 :v-adjust 0.0)
           "Agenda todos" "" (lambda (&rest _) (org-agenda-list)) 'dired-warning)
          (,(all-the-icons-octicon "calendar" :height 1.0 :v-adjust 0.0)
           "Agenda calendar" "" (lambda (&rest _) (cfw:open-org-calendar)) 'dired-warning)
          )
        ;; line 4
        ( (,"Config" "" "" (lambda (&rest _)) 'dired-mark)
          (,(all-the-icons-faicon "cogs" :height 1.0 :v-adjust 0.0)
           "System config" "" (lambda (&rest _) (projectile-switch-project-by-name "~/.dotfiles" t)) 'dired-mark)
          (,(all-the-icons-material "help" :height 1.0 :v-adjust -0.2)
           "Doom documentation" "" (lambda (&rest _) (doom/help)) 'dired-mark)
          )))

(setq dashboard-footer-icon
      (all-the-icons-faicon "list-alt"
                            :height 1.0
                            :v-adjust -0.15
                            :face 'font-lock-keyword-face))
(dashboard-setup-startup-hook)

(map! :leader :desc "Open dashboard" "b b" #'dashboard-refresh-buffer)

(setq scroll-conservatively 101)

;; Smooth scrolling
;; requires good-scroll.el
;;(good-scroll-mode 1)
;;(setq good-scroll-duration 0.4
;;      good-scroll-step 270
;;      good-scroll-render-rate 0.03)
;;
;;(global-set-key (kbd "<next>") #'good-scroll-up-full-screen)
;;(global-set-key (kbd "<prior>") #'good-scroll-down-full-screen)

(setq scroll-margin 30)
(setq hscroll-margin 10)

;; Requires for faster loading
(require 'org-agenda)
(require 'dired)
;;(add-hook 'dired-mode-hook 'dired-icon-mode)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
(map! :leader
      :desc "Peep-dired image previews" "d p" #'peep-dired)
(map! :leader
      :desc "Treemacs toggle" "e" #'treemacs)
;;(add-to-list 'default-frame-alist '(width . 30px ))  ; Width set to 80 characters
;;(add-to-list 'default-frame-alist '(height . 70px )) ; Height set to 24 lines
(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq org-hide-emphasis-markers t)
