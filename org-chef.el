;;; org-chef.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 John Doe
;;
;; Author: John Doe <http://github/guancio>
;; Maintainer: John Doe <john@doe.com>
;; Created: maj 30, 2021
;; Modified: maj 30, 2021
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/guancio/org-chef
;; Package-Requires: ((emacs 26.3) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  description
;;
;;; Code:

(defvar org-chef-python-path "")
(defvar org-chef-device-ip "")
(defvar org-chef-device-token "")

(defun org-chef-cook-at-point ()
  "Cook the recipe pointer by cursor."
  (interactive)
  (progn
    (outline-up-heading 100)
    (org-copy-subtree)
    (let ((proc (start-process "org-chef-cli" "org-chef-cli-buffer" org-chef-python-path
                               "--ip" org-chef-device-ip
                               "--token" org-chef-device-token
                               "--start")))
      (process-send-string proc (current-kill 0 t))
      (process-send-eof proc)
      )
    ))


(Provide 'org-chef)
;;; org-chef.el ends here
