;;---------------------=={ Segment Curve }==------------------;;
 
;; ;;
 
;; Divides selected objects into an LWPolyline with a ;;
 
;; specified number of segments of equal length. ;;
 
;;------------------------------------------------------------;;
 
;; Author: Lee Mac, Copyright © 2011 - www.lee-mac.com ;;
 
;;------------------------------------------------------------;;
 
(defun c:Segs ( / *error* _StartUndo _EndUndo acdoc ss j ) (vl-load-com)
 
(defun *error* ( msg ) (and acdoc (_EndUndo acdoc))
 
(or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
 
(princ (strcat "\n** Error: " msg " **")))
 
(princ)
 
)
 
(defun _StartUndo ( doc ) (_EndUndo doc)
 
(vla-StartUndoMark doc)
 
)
 
(defun _EndUndo ( doc )
 
(if (= 8 (logand 8 (getvar 'UNDOCTL)))
 
(vla-EndUndoMark doc)
 
)
 
)
 
(setq acdoc (vla-get-ActiveDocument (vlax-get-acad-object)) *segs (cond ( *segs ) ( 10 )))
 
(if
 
(and (setq ss (ssget "_:L" '((0 . "ARC,CIRCLE,LWPOLYLINE,SPLINE,LINE,ELLIPSE"))))
 
(progn (initget 6)
 
(setq *segs (cond ( (getint (strcat "\nSpecify Number of Segments <" (itoa *segs) "> : ")) ) ( *segs )))
 
)
 
)
 
(progn (_StartUndo acdoc)
 
(repeat (setq j (sslength ss))
 
(
 
(lambda ( e / k l i p )
 
(setq k (/ (vlax-curve-getDistatParam e (vlax-curve-getEndParam e)) (float *segs))
 
l (entget e)
 
i -1
 
)
 
(repeat (1+ *segs)
 
(setq p (cons (cons 10 (trans (vlax-curve-getPointatDist e (* (setq i (1+ i)) k)) 0 e)) p))
 
)
 
(if
 
(entmake
 
(append
 
(list
 
(cons 0 "LWPOLYLINE")
 
(cons 100 "AcDbEntity")
 
(cons 100 "AcDbPolyline")
 
(cons 90 (length p))
 
(cons 38 (last (car p)))
 
(cons 70 (if (vlax-curve-isClosed e) 1 0))
 
)
 
(apply 'append
 
(mapcar '(lambda ( a ) (if (assoc a l) (list (assoc a l)))) '(6 8 39 48 62 210))
 
)
 
p
 
)
 
)
 
(entdel e)
 
)
 
)
 
(ssname ss (setq j (1- j)))
 
)
 
)
 
(_EndUndo acdoc)
 
)
 
)
 
(princ)
 
)