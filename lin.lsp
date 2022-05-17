;Tip1677:  LIN.LSP   Best-fit Line   (c)2001, Jorn Anke
; PURPOSE: You can select several points and the routine will calculate (using
;          Least Square Method) the line that fits best between the points, and 
;          then draw  the line.

(defun C:LIN ( / xmin  xmax )

; Select points

;;;  (print)
;;;  (princ
;;;    "Vil du gi inndata som punkter eller objekter ? (For objekter benyttes"
;;;  ) ;_ end of princ
;;;  (print)
;;;  (setq SVAR
;;;         (getstring
;;;           "innsettingspunktene til blokker, sirkler etc.) (P/O) <O> ?"
;;;         ) ;_ end of getstring
;;;  ) ;_ end of setq
;;;
;;;  (print)
;;;  (princ
;;;    "Do you vant to select points by snapping - or by selecting objects ?"
;;;  ) ;_ end of princ

 (print)
 (setq SVAR (getstring
              "Do you vant to select points or objects? (P/O) <O> ?"
            ) ;_ end of getstring
 ) ;_ end of setq

 (setq SVAR (strcase SVAR))
 (setq X 0)
 (setq I 0)
 (setq SX 0)
 (setq SY 0)
 (setq SXY 0)
 (setq SX2 0)
 (if (= SVAR "P")
   (progn ; Svar = Points
     (while X ; while X <> nil, e.g. X has got a value
       (setq PUNKT (getpoint "Select point, <Return> to end ...\n"))
       (setq X (car PUNKT)   Y (cadr PUNKT))
       (if X
         (progn
           (setq SX (+ SX X)    SY (+ SY Y)  
                 SXY (+ SXY (* X Y)) 
                 SX2 (+ SX2 (* X X)) )
           (if (= I 0)    (setq XMIN X   XMAX X)  ) ;_ end of if
           (if (> XMIN X) (setq XMIN X) ) ;_ end of if
           (if (< XMAX X) (setq XMAX X) ) ;_ end of if
           (setq I (+ I 1))
         ) ;_ end of progn
       ) ;_ end of if
     ) ;_ end of while
   ) ;_ end of progn
   (progn ; Svar = Objects
     (setq LISTE (ssget)    LISTELENGDE (sslength LISTE))
     (while (<= I (- LISTELENGDE 1))
       (setq ELEMENT (entget (ssname LISTE I)))
       (setq X (cadr (assoc 10 ELEMENT)))
       (setq Y (caddr (assoc 10 ELEMENT)))
       (setq SX (+ SX X))
       (setq SY (+ SY Y))
       (setq SXY (+ SXY (* X Y)))
       (setq SX2 (+ SX2 (* X X)))
       (if (= I 0)
         (progn
           (setq XMIN X)
           (setq XMAX X)
         ) ;_ end of progn
       ) ;_ end of if
       (if (> XMIN X)
         (setq XMIN X)
       ) ;_ end of if
       (if (< XMAX X)
         (setq XMAX X)
       ) ;_ end of if
       (setq I (+ I 1))
     ) ;_ end of while
   ) ;_ end of progn
 ) ;_ end of if
 (setq A (/ (- SXY (/ (* SX SY) I)) (- SX2 (/ (* SX SX) I))))
 (setq B (- (/ SY I) (* A (/ SX I))))
 (setq X1 XMIN)
 (setq Y1 (+ (* A X1) B))
 (setq X2 XMAX)
 (setq Y2 (+ (* A X2) B))
 (command "line" (list X1 Y1) (list X2 Y2) "")
) ;_ end of defun
;***** END RUTINE: LIN




; Linear Least square fit of 2D points 
(defun Lsq_pL (  pL  / xmin  xmax  kA  kB )
  (setq X 0   i 0   kX 0  kY 0  kXY 0  kX2 0
        XMiN  (car p)   XMAX  XMiN  )   
  (foreach p pL 
    (setq x   (car p)    kX (+ kX X) 
          y   (cadr p)   kY (+ kY Y)  
          kXY (+ kXY (* X Y))    i (+ i 1)
          kX2 (+ kX2 (* X X))  )
    (if (> XMiN X) (setq XMiN X) )    ; X min-max vaLs 
    (if (< XMAX X) (setq XMAX X) )  ) ; pL
  (setq kA (/ (- kXY (/ (* kX kY) i)) 
              (- kX2 (/ (* kX kX) i))))
  (setq kB (- (/ kY i) (* kA (/ kX i))))
  (List (List XMiN (+ (* kA XMiN) kB)) 
        (List XMAX (+ (* kA XMAX) kB)) )   ) 

