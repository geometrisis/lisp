 
;; 
;; Original routine : 3dfto3dp2  (Rhymone) - Convert 3DFace to 3DPline 
;;
;; 
;; Patch by Patrice to get (and draw) 3D Points from 3D Faces ...
;; WARNING : THEN you will get many duplicate 3 Points !
;; 
;; US      - Please RUN into the GCS NOT into an UCS 
;; French  - SVP : veuillez lancer dans le SCG 
;; 


(defun c:3DF_to_3DPoint ()
  (setq cmdecho (getvar "CMDECHO"))
  (setvar "CMDECHO" 0)
  (command "_UNDO" "_G")

  (setq sset (ssget '((0 . "3DFACE")))) 

  (if sset
    (progn
      (setq itm 0 num (sslength sset))
      (while (< itm num)
        (setq hnd (ssname sset itm))
        (setq ent (entget hnd))
        (setq pt1 (cdr (assoc 10 ent)))
        (setq pt2 (cdr (assoc 11 ent)))
        (setq pt3 (cdr (assoc 12 ent)))
        (setq pt4 (cdr (assoc 13 ent)))

;;;; Keep or Erase/Del original 3DFace entity/object ;;;; 
;       (entdel hnd) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;       (command "_3dpoly" pt1 pt2 pt3 pt4 "_C") 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        (command "_point" pt1) 
        (command "_point" pt2) 
        (command "_point" pt3) 
        (command "_point" pt4) 

        (setq itm (1+ itm))
      )
      (princ ", Done.")
    )
  )

  (setq sset nil)
  (command "_UNDO" "_E")
  (setvar "CMDECHO" cmdecho)
  (princ)
)

(princ "DS> 3DF_to_3DPoint.LSP loaded ... type 3DF_to_3DPoint to run ")
 
