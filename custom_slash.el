(require 'web)

;; must have clj-cmd-token in .emacs or .spacemacs
;; (clj-slack-setup :fun-name norby
;;                  :command "/norby-prod"
;;                  :channel-name "prod"
;;                  :token "TODKEN"
;;                  :external-url "URL"
;;                  )
(defmacro clj-slack-setup (&rest plist)
  (let ((fun-name (plist-get plist :fun-name))
        (command (plist-get plist :command))
        (channel-name (plist-get plist :channel-name))
        (token (plist-get plist :token))
        (external-url (plist-get plist :external-url)))
    `(defun ,fun-name ()
       (interactive)
       (labels ((slash-cmd (cmd)
                           (let ((query-data (make-hash-table :test 'equal)))
                             (puthash 'token ,token query-data)
                             (puthash 'command ,command query-data)
                             (puthash 'channel_name ,channel-name query-data)
                             (puthash 'text cmd query-data)
                             (web-http-post
                              (lambda (con header data))
                              :url ,external-url
                              :data query-data
                              ))))
        (save-excursion
          (end-of-defun)
          (backward-sexp)
          (let ((sexp (thing-at-point 'sexp)))
            (slash-cmd sexp))
          )))
    ))
