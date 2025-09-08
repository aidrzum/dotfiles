(beacon-mode 1)
(setq doom-font (font-spec :family "Agave Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Agave Nerd Font" :size 14))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))
(setq user-full-name "l33tboi"
      user-mail-address "aidrzum@gmail.com")
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


(setq scroll-margin 30)
(setq hscroll-margin 10)

;;(add-hook 'dired-mode-hook 'dired-icon-mode)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)
(add-hook 'org-mode-hook 'org-bullets-mode)
(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
(map! :leader
      :desc "Peep-dired image previews" "d p" #'peep-dired)
(map! :leader
      :desc "Treemacs toggle" "e" #'treemacs)
(setq doom-theme 'doom-one)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq org-hide-emphasis-markers t)
(setq display-line-numbers-type 'relative)


;; Requires for faster loading
(require 'org-agenda)
(require 'dired)

;; custom dashboard
(require 'all-the-icons)
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; Set the title
(setq dashboard-banner-logo-title "Welcome to NixOS DoomEmacs")
;; Set the banner
(setq dashboard-startup-banner "~/Pictures/nix-dark.png")
;; Value can be
;; - nil to display no banner
;; - 'official which displays the official emacs logo
;; - 'logo which displays an alternative emacs logo
;; - 1, 2 or 3 which displays one of the text banners
;; - "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer
;; - a cons of '("path/to/your/image.png" . "path/to/your/text.txt")

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)

;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts nil)

(setq dashboard-items '((recents   . 2)
                        (bookmarks . 2)
                        (agenda    . 3)))

(setq dashboard-item-names '(("Recent Files:"               . "What's Going on?:")
                             ("Agenda for today:"           . "Today's agenda:")
                             ("Bookmarks:"                  . "Bookie:")
                             ("Projects:"                   . "Proj:")
                             ("Agenda for the coming week:" . "Agenda boi:")))


(setq dashboard-icon-type 'all-the-icons)  ; use `all-the-icons' package
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(dashboard-modify-heading-icons '((recents . "file-text")
                                  (bookmarks . "book")
                                  (agenda . "globe")))

;;(dashboard-modify-heading-icons '((recents   . "nf-oct-file-text")
;;                                  (bookmarks . "nf-oct-book")))

(setq dashboard-set-navigator t)



;; Format: "(icon title help action face prefix suffix)"
(setq dashboard-navigator-buttons
      `(;; line1
        ((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0)
         "Homepage"
         "Browse homepage"
         (lambda (&rest _) (browse-url "homepage")))
        ("★" "Star" "Show stars" (lambda (&rest _) (show-stars)) warning)
        ("?" "" "?/h" #'show-help nil "<" ">"))
         ;; line 2
        ((,(all-the-icons-faicon "linkedin" :height 1.1 :v-adjust 0.0)
          "Linkedin"
          ""
          (lambda (&rest _) (browse-url "homepage")))
         ("⚑" nil "Show flags" (lambda (&rest _) (message "flag")) error))))

(setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
                                                   :height 1.1
                                                   :v-adjust -0.05
                                                   :face 'font-lock-keyword-face))







(dashboard-setup-startup-hook)

(map! :leader :desc "Open dashboard" "b b" #'dashboard-refresh-buffer)

(setq scroll-conservatively 101)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'org-roam)
(require 'org-roam-dailies)
(setq user-default-roam-dir "~/Org/")

(setq org-roam-directory (concat "~/Org/" user-default-roam-dir "/Notes")
      org-roam-db-location (concat "~/Org/" user-default-roam-dir "/Notes/org-roam.db"))

(setq org-roam-node-display-template
      "${title:65}📝${tags:*}")

(org-roam-db-autosync-mode)

(setq mode-line-misc-info '((which-function-mode
  (which-func-mode
   ("" which-func-format " ")))
 ("" so-long-mode-line-info)
 (global-mode-string
  ("" global-mode-string))
 " "
 org-roam-db-choice)
)

(setq org-roam-list-files-commands '(rg))

;;Multi org-roam mode
(setq full-org-roam-db-list nil)

(setq full-org-roam-db-list (directory-files "~/Org" t "\\.[p,s]$"))
(dolist (item full-org-roam-db-list)
  (setq full-org-roam-db-list
        (append (directory-files item t "\\.[p,s]$") full-org-roam-db-list)))

(setq org-roam-db-choice user-default-roam-dir)
(setq full-org-roam-db-list-pretty (list))
(dolist (item full-org-roam-db-list)
  (setq full-org-roam-db-list-pretty
       (append (list
             (replace-regexp-in-string (concat "\\/home\\/" user-username "\\/Org\\/") "" item)) full-org-roam-db-list-pretty)))

(defun org-roam-open-dashboard ()
  "Open ${org-roam-directory}/dashboard.org (I use this naming convention to create dashboards for each of my org roam maps)"
  (interactive)
  (if (org-roam-node-from-title-or-alias "Overview")
      (org-roam-node-open (org-roam-node-from-title-or-alias "Overview"))
      (dired org-roam-directory))
)

(defun org-roam-open-inbox ()
  "Open ${org-roam-directory}/dashboard.org (I use this naming convention to create dashboards for each of my org roam maps)"
  (interactive)
  (if (org-roam-node-from-title-or-alias "Inbox")
      (org-roam-node-open (org-roam-node-from-title-or-alias "Inbox"))
      (message "No inbox found, capture something with M-x org-roam-capture-inbox"))
)

(defun org-roam-capture-inbox ()
  (interactive)
  (org-roam-capture- :node (org-roam-node-from-title-or-alias "Inbox")
                     :templates '(("i" "inbox" plain "* %?"
                                  :if-new (file+head "%<%Y%m%d%H%M%S>-inbox.org" "#+title: Inbox\n")))))

(defun org-roam-switch-db (&optional arg silent)
  "Switch to a different org-roam database, arg"
  (interactive)
  (when (not arg)
  (setq full-org-roam-db-list nil)
;; Multi Org-roam mode
  (setq full-org-roam-db-list (directory-files "~/Org" t "\\.[p,s]$"))
  (dolist (item full-org-roam-db-list)
    (setq full-org-roam-db-list
        (append (directory-files item t "\\.[p,s]$") full-org-roam-db-list)))

  (setq full-org-roam-db-list-pretty (list))
  (dolist (item full-org-roam-db-list)
    (setq full-org-roam-db-list-pretty
        (append (list
                 (replace-regexp-in-string (concat "\\/home\\/" user-username "\\/Org\\/") "" item)) full-org-roam-db-list-pretty)))

  (setq org-roam-db-choice (completing-read "Select org roam database: "
                          full-org-roam-db-list-pretty nil t)))
  (when arg
    (setq org-roam-db-choice arg))

      (setq org-roam-directory (file-truename (concat "~/Org/" org-roam-db-choice "/Notes"))
            org-roam-db-location (file-truename (concat "~/Org/" org-roam-db-choice "/Notes/org-roam.db"))
            org-directory (file-truename (concat "~/Org/" org-roam-db-choice "/Notes")))
  (when (not silent)
  (org-roam-open-dashboard))

  (org-roam-db-sync)

  (message (concat "Switched to " org-roam-db-choice " org-roam database!")))

(defun org-roam-default-overview ()
  (interactive)
  (org-roam-switch-db user-default-roam-dir))

(defun org-roam-switch-db-id-open (arg ID &optional switchpersist)
  "Switch to another org-roam db and visit file with id arg"
  "If switchpersist is non-nil, stay in the new org-roam db after visiting file"
  (interactive)
  (setq prev-org-roam-db-choice org-roam-db-choice)
  (org-roam-switch-db arg 1)
  (org-roam-id-open ID)
  (when (not switchpersist)
    (org-roam-switch-db prev-org-roam-db-choice 1)))

;;org-roam todo configutation

(defun text-in-buffer-p (TEXT)
(save-excursion (goto-char (point-min)) (search-forward TEXT nil t)))

(defun apply-old-todos-tag-maybe (&optional FILE)
   (interactive)
   (if (stringp FILE)
   (setq the-daily-node-filename FILE)
   (setq the-daily-node-filename buffer-file-name))
   (if (org-roam-dailies--daily-note-p the-daily-node-filename)
    (if (<= (nth 2 (org-roam-dailies-calendar--file-to-date the-daily-node-filename)) (nth 2 org-agenda-current-date))
      (if (<= (nth 1 (org-roam-dailies-calendar--file-to-date the-daily-node-filename)) (nth 1 org-agenda-current-date))
        (if (<= (nth 0 (org-roam-dailies-calendar--file-to-date the-daily-node-filename)) (nth 0 org-agenda-current-date))
          (funcall (lambda ()
            (with-current-buffer (get-file-buffer the-daily-node-filename) (org-roam-tag-add '("old-todos")))
            (with-current-buffer (get-file-buffer the-daily-node-filename) (org-roam-tag-remove '("todos")))
            )
          )
        )
      )
    )
  )
)

(defun apply-old-todos-tag-maybe-and-save (FILE)
  (interactive)
  (find-file-noselect FILE)
  (apply-old-todos-tag-maybe FILE)
  (with-current-buffer (get-file-buffer the-daily-node-filename) (save-buffer))
  (with-current-buffer (get-file-buffer the-daily-node-filename) (kill-buffer))
)

(defun org-current-buffer-has-todos ()
  "Return non-nil if current buffer has any todo entry."

  (org-element-map                          ; (2)
       (org-element-parse-buffer 'headline) ; (1)
       'headline
     (lambda (h)
       (eq (org-element-property :todo-type h)
           'todo))
     nil 'first-match))                     ; (3)

(defun org-has-recent-timestamps (OLD-DAYS)
  "Return non-nil only if current buffer has entries with timestamps
   more recent than OLD-DAYS days"
  (interactive)
  (if (org-element-map (org-element-parse-buffer) 'timestamp
    (lambda (h)
      (org-element-property :raw-value h)))
      (org-element-map                          ; (2)
         (org-element-parse-buffer) ; (1)
          'timestamp
         (lambda (h)
           (time-less-p (time-subtract (current-time) (* 60 60 24 OLD-DAYS)) (date-to-time (org-element-property :raw-value h))))
         nil 'first-match) nil))

(setq org-timestamps-days-for-old 21)

; This has a bug where it won't sync a new agenda file
; if I'm editing an org roam node file while set to another
; org roam db
(defun add-todos-tag-on-save-org-mode-file()
  (interactive)
  (when (string= (message "%s" major-mode) "org-mode")
    (if (org-roam-node-p (org-roam-node-at-point))
    (funcall (lambda()
      (if (or (org-current-buffer-has-todos) (org-has-recent-timestamps org-timestamps-days-for-old))
        (org-roam-tag-add '("todos"))
        (org-roam-tag-remove '("todos"))
      )
      (apply-old-todos-tag-maybe)
     )
    )
  )
 )
)

(add-hook 'before-save-hook 'add-todos-tag-on-save-org-mode-file)


;;; Setup Org Agenda from Org Roam
;;;
(defun org-roam-filter-by-tag (tag-name)
  (lambda (node)
    (member tag-name (org-roam-node-tags node))))

(defun org-roam-list-notes-by-tag (tag-name)
  (mapcar #'org-roam-node-file
          (seq-filter
           (org-roam-filter-by-tag tag-name)
           (org-roam-node-list))))

(defun org-roam-dailies-apply-old-todos-tags-to-all ()
;  (dolist (daily-node org-roam-dailies-files)
;           (apply-old-todos-tag-maybe-and-save daily-node)
;  )
  (setq num 0)
  (while (< num (list-length (org-roam-list-notes-by-tag "todos")))
    (apply-old-todos-tag-maybe-and-save (nth num (org-roam-list-notes-by-tag "todos")))
  (setq num (1+ num))
  )
)

;; Refreshing org roam agenda
(defun org-roam-refresh-agenda-list ()
  (interactive)
  (setq prev-org-roam-db-choice org-roam-db-choice)
  (setq org-agenda-files '())
  (setq org-id-files '())
  (setq org-roam-directory (file-truename "~/Org")
        org-roam-db-location (file-truename "~/Org/org-roam.db")
        org-directory (file-truename "~/Org/"))
  (org-roam-db-sync)
  (setq org-agenda-files (org-roam-list-notes-by-tag "todos"))
  (setq org-id-files (org-roam-list-files))
  (setq org-agenda-files (-uniq org-agenda-files))
  (org-roam-switch-db prev-org-roam-db-choice 1)
)

;; Build agenda only when org agenda first opened for session
(setq org-roam-agenda-initialized nil)
(defun org-roam-refresh-agenda-list-init ()
  (if (not org-roam-agenda-initialized)
    (funcall
      (lambda ()
        (org-roam-refresh-agenda-list)
        (setq org-roam-agenda-initialized t)
      )
    )
  )
)
(add-hook 'org-agenda-mode-hook 'org-roam-refresh-agenda-list-init)

(map! :leader
      :prefix ("o a")

      :desc "Refresh org agenda from roam dbs"
      "r" 'org-roam-refresh-agenda-list)

;;; org-mode keybindings
;;;
(map! :leader
      :prefix ("N" . "org-roam notes")

      :desc "Capture new roam node"
      "c" 'org-roam-capture

      :desc "Open org roam inbox"
      "I o" 'org-roam-open-inbox

      :desc "Capture stuff in inbox"
      "I c" 'org-roam-capture-inbox

      :desc "Insert roam node link at point"
      "i" 'org-roam-node-insert

      :desc "Find roam node"
      "." 'org-roam-node-find

      :desc "Switch org-roam database"
      "s" 'org-roam-switch-db

      :desc "Update current org-roam database"
      "u" 'org-roam-db-sync

      :desc "Re-zoom on current node in org-roam-ui"
      "z" 'org-roam-ui-node-zoom

      :desc "Visualize org-roam database with org-roam-ui"
      "O" 'org-roam-default-overview

      :desc "Visualize org-roam database with org-roam-ui"
      "o" 'org-roam-open-dashboard)

;;org-mode UI Setup

(setq org-roam-ui-browser-function 'browse-url) ; wayland

(defun open-org-roam-ui ()
  (interactive)
  (+evil/window-vsplit-and-follow)
  (org-roam-ui-open)
  (evil-window-left 1))

(defun kill-org-roam-ui ()
  (interactive)
;;  (delete-window (get-buffer-window "ORUI" t)) ; xorg
;;  (kill-buffer "ORUI") ; xorg
  (kill-buffer "*httpd*")
)

; xorg
;;(map! :leader
;;      :prefix ("N" . "org-roam notes")
;;      :desc "Visualize org-roam database with org-roam-ui"
;;      "v" 'open-org-roam-ui)

; wayland
(map! :leader
      :prefix ("N" . "org-roam notes")
      :desc "Visualize org-roam database with org-roam-ui"
      "v" 'org-roam-ui-open)

(map! :leader
      :prefix ("N" . "org-roam notes")
      :desc "Kill all org roam ui buffers"
      "V" 'kill-org-roam-ui)





;;##############################################
;;

;;;;emacs-dashboard setup
;;(require 'all-the-icons)
;;(require 'dashboard)
;;(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*"))
;;      doom-fallback-buffer-name "*dashboard*")
;;(setq image-scaling-factor 1)
;;
;;
;;;; emacs-dashboard variables
;;(setq dashboard-banner-logo-title "Welcome to Nix Doom Emacs")
;;(setq dashboard-startup-banner "~/Pictures/nix-dark.png")
;;(setq dashboard-icon-type 'all-the-icons)
;;(setq dashboard-set-heading-icons t)
;;(setq dashboard-set-file-icons t)
;;(setq dashboard-set-navigator t)
;;(setq dashboard-items '())
;;(setq dashboard-center-content t)
;;(setq dashboard-footer-messages '("Here to do customizing, or actual work?"
;;                                  "M-x insert-inspiring-message"
;;                                  "My software never has bugs. It just develops random features."
;;                                  "Dad, what are clouds made of? Linux servers, mostly."
;;                                  "There is no place like ~"
;;                                  "~ sweet ~"
;;                                  "sudo chown -R us ./allyourbase"
;;                                  "I’ll tell you a DNS joke but it could take 24 hours for everyone to get it."
;;                                  "I'd tell you a UDP joke, but you might not get it."
;;                                  "I'll tell you a TCP joke. Do you want to hear it?"))
;;
;;;; Remove basic evil input and cursors from dashboard
;;(defun disable-cursor()
;;  (setq-local evil-normal-state-cursor '(bar . 0))
;;  (hl-line-mode -1)
;;  )
;;(add-hook 'dashboard-mode-hook 'disable-cursor)
;;(evil-define-key 'normal dashboard-mode-map
;;  "j" 'evil-normal-state
;;  "k" 'evil-normal-state
;;  "h" 'evil-normal-state
;;  "l" 'evil-normal-state)
;;(setq dashboard-navigator-buttons
;;      `(;; line1
;;        ( (,"Roam" "" "" (lambda (&rest _)) 'org-formula)
;;          (,(all-the-icons-octicon "globe" :height 1.0 :v-adjust 0.0)
;;           "Notes overview" "" (lambda (&rest _) (org-roam-default-overview)) 'org-formula)
;;          (,(all-the-icons-fileicon "org" :height 1.0 :v-adjust 0.0)
;;           "Switch roam db" "" (lambda (&rest _) (org-roam-switch-db)) 'org-formula)
;;          )
;;        ;; line 2
;;        ( (,"Git" "" "" (lambda (&rest _)) 'diredfl-exec-priv)
;;          (,(all-the-icons-octicon "mark-github" :height 1.0 :v-adjust 0.0)
;;           "GitHub" "" (lambda (&rest _) (browse-url "https://github.com/aidrzum")) 'diredfl-exec-priv)
;;          (,(all-the-icons-faicon "gitlab" :height 1.0 :v-adjust 0.0)
;;           "GitLab" "" (lambda (&rest _) (browse-url "https://gitlab.com/aidrzum")) 'diredfl-exec-priv)
;;          (,(all-the-icons-faicon "coffee" :height 1.0 :v-adjust 0.0)
;;           "Gitea" "" (lambda (&rest _) (browse-url my-gitea-domain)) 'diredfl-exec-priv)
;;          (,(all-the-icons-octicon "triangle-up" :height 1.2 :v-adjust -0.1)
;;           "Codeberg" "" (lambda (&rest _) (browse-url "https://codeberg.org/aidrzum")) 'diredfl-exec-priv)
;;          )
;;        ;; line 3
;;        ( (,"Agenda" "" "" (lambda (&rest _)) 'dired-warning)
;;          (,(all-the-icons-octicon "checklist" :height 1.0 :v-adjust 0.0)
;;           "Agenda todos" "" (lambda (&rest _) (org-agenda-list)) 'dired-warning)
;;          (,(all-the-icons-octicon "calendar" :height 1.0 :v-adjust 0.0)
;;           "Agenda calendar" "" (lambda (&rest _) (cfw:open-org-calendar)) 'dired-warning)
;;          )
;;        ;; line 4
;;        ( (,"Config" "" "" (lambda (&rest _)) 'dired-mark)
;;          (,(all-the-icons-faicon "cogs" :height 1.0 :v-adjust 0.0)
;;           "System config" "" (lambda (&rest _) (projectile-switch-project-by-name "~/.dotfiles" t)) 'dired-mark)
;;          (,(all-the-icons-material "help" :height 1.0 :v-adjust -0.2)
;;           "Doom documentation" "" (lambda (&rest _) (doom/help)) 'dired-mark)
;;          )))
;;
;;(setq dashboard-footer-icon
;;      (all-the-icons-faicon "list-alt"
;;                            :height 1.0
;;                            :v-adjust -0.15
;;                            :face 'font-lock-keyword-face))
;;(dashboard-setup-startup-hook)
;;
;;(map! :leader :desc "Open dashboard" "b b" #'dashboard-refresh-buffer)
;;
;;(setq scroll-conservatively 101)
;;
;;;; Smooth scrolling
;;;; requires good-scroll.el
;;;;(good-scroll-mode 1)
;;;;(setq good-scroll-duration 0.4
;;;;      good-scroll-step 270
;;;;      good-scroll-render-rate 0.03)
;;;;
;;;;(global-set-key (kbd "<next>") #'good-scroll-up-full-screen)
;;;;(global-set-key (kbd "<prior>") #'good-scroll-down-full-screen)
