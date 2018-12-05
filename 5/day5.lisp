; Advent of code 2018 - Åsmund Ødegård

(defun process-internal (l)
  (let ((flag 'nil))

    (labels ((gidx (idx)
                   (if (< idx (length l))
                     (string (aref l idx)))))

      (loop for idx from 0 to (- (length l) 1)
            when
            (let* ((c (gidx idx))
                   (n (gidx (1+ idx)))
                   (lc (string-downcase c))
                   (ln (string-downcase n)))
              (if flag
                (psetf flag 'nil)
                (if (not (and (string= lc ln) 
                              (not (string= c n))))
                  c
                  (psetf flag 't)))) collect it))))

(defun process-to-string (l)
  (format nil "~{~A~}" (process-internal l)))

(defun process-line (l)
  (let* ((len (length l))
        (lp (process-to-string l))
        (lplen (length lp)))

    (if (< lplen len)
      (process-line lp)
      lp)))

(defun process (l uc maxl)
  (let ((cm maxl)
        (cl l))
    (loop for c across uc 
          do
          (let* ((lc (remove (char-upcase c) (remove c l)))
                 (lpc (process-line lc))
                 (lpclen (length lpc)))

            (if (< lpclen cm)
              (progn
                (setf cl lpc)
                (setf cm lpclen)))))
    cl))


(defun main() 
    (let* ((l (read-line))
           (maxl (length l))
           (uniqc (remove-duplicates (string-downcase l)))
           (lp (process l uniqc maxl))
           (len (length lp))
           (flag 'nil))

      (if flag 
        (progn
          (format t "Line: ~A.~%" l)
          (format t "Uniq: ~A~%" uniqc)))

      (format t "Line: ~A~%" lp)
      (format t "Length: ~A~%" len)))

(main)
