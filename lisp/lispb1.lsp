
; PR3 Lisp
; Übungsblatt1.pdf

; Schmidt, Mario 1529889
; Kryvoruchko, Sergej 1532130
; https://github.com/pr3-lecture/repo-45/tree/master/lisp


; A1 a)
; 1. Element an letzte Stelle verschieben
(defun rotiere (mylist)
  (append (cdr mylist) (list (car mylist)))
)
(rotiere '(eins zwei drei vier)) ; => (zwei drei vier eins)


; A1 b)
; neues Element vor Letztem einfügen
(defun neues-vorletztes (vorletztes mylist)
  (setq letztes (nth (- (list-length mylist) 1) mylist)) ; letztes Element in Var
  (setf (nth (- (list-length mylist) 1) mylist) vorletztes) ; letztes Element ersetzen
  (append mylist (list letztes)) ; neues Element anhängen
)
(neues-vorletztes 'dreieinhalb '(eins zwei drei vier))
; => (eins zwei drei dreieinhalb vier)


; A1 c)
(defun my-length (mylist)
  (cond
    ((null mylist) 0) ; trivialer Fall: leere Liste
    (t
      (+
        1
        (my-length (cdr mylist))
      )
    )
  )
  
  ; bei jedem Aufruf wird die Liste um ein Element kleiner (bis zur leeren Liste)
  ; für jeden Aufruf (=> für jedes Element) zählen wir hoch

)
(my-length '(a b d e f g h i))
(my-length '(eins zwei drei vier)) ; => 4


; A1 d)
(defun my-lengthR (mylist)
  (cond
    ((null mylist) 0) ; trivialer Fall: leere Liste
    (t

      (cond
        ((listp (car mylist)) ; wenn Element eine (geschachtelte) Liste ist
          (+
            0
            (my-lengthR (car mylist)) ; berechne Länge der geschachtelten Liste
            (my-lengthR (cdr mylist)) ; berechne Rest
          )
        )

        (t
          (+
            1
            (my-lengthR (cdr mylist)) ; berechne Rest
          )
        )
      )

    )
  )
  
  ; bei Atomen, hoch zählen und Rest berechnen
  ; bei Listen, diese berechnen und Rest berechnen

)
(my-lengthR '(a b (c d e (f g) h i j) k l))
(my-lengthR '(eins zwei (zwei (zwei drei) eins) drei vier)) ; => 8


; A1 e)
(defun my-reverse(x)
    (cond 
        (   (null x)
            nil
        )
        (   t
            ( append 
                (my-reverse (cdr x))
                (list (first x)) 
            )
        )
    )
    ; letztes als erstes Element -> rekursiv dasselbe für Rest
)
(my-reverse '(a b c d))
(my-reverse '(eins zwei (zwei (zwei drei) eins) drei vier))
; => (vier drei (zwei (zwei drei) eins) zwei eins)


; A1 f)
(defun my-reverseR(mylist)
    (cond 
           (   (null mylist)
                  nil
           )
           (   (listp (car mylist)) ; wenn Element eine (geschachtelte) Liste ist
                  ( append 
                         (my-reverseR (cdr mylist))
                         (list (append ; als geschachtelte Liste
                                   (my-reverseR (cdr (car mylist)))
                                   (list (first (car mylist)))
                         )) 
                  )
           )
           (   (not (null mylist))
                  ( append (my-reverseR (cdr mylist)) (list (first mylist)) )
           )
    )
)
(my-reverseR '(a (b c) d))
(my-reverseR '(eins zwei (zwei (zwei drei) eins) drei vier)) 
; => (vier drei (eins (drei zwei) zwei) zwei eins)


; -------------------------

; A2 a)
; Binärbaum als Liste:
; - eine (geschachtelte) Liste ist ein Knoten (Liste mit max. 3 Elementen)
; - 1. Element der Liste ist der Wert des Knotens (Atom)
; - 2. und 3. Element sind Kinder (geschachtelte Listen), für die das Gleiche wie oben gilt
; - wenn es nur ein rechtes Kind gibt, muss das linke "()" sein
; - Blatt: Liste mit einem Element
; - Wurzel: äußerste Liste

;       10
;      /  \
;     5    15
;    / \     \
;   2  7      17
;  /
; 1

(setq binbaum 
  '(
;   1  (.....2.......) (...3......)
    10 (5 (2 (1)) (7)) (15 () (17))
  )
)


; A2 b) 1)
(defun inorder (tree) ; sortiert

  (let 
    (
      (left  (car (cdr tree)))
      (right (car (cdr (cdr tree))))
    )


    (cond
      ((not (null left)) (inorder left))
    )

    (cond
      ((null (car tree)) (PRINT tree))
      (t (PRINT (car tree)))
    )

    (cond
      ((not (null right)) (inorder right))
    )


  )

)
;(inorder binbaum)


; A2 b) 2)
(defun postorder (tree) 

  (let 
    (
      (left  (car (cdr tree)))
      (right (car (cdr (cdr tree))))
    )


    (cond
      ((not (null left)) (postorder left))
    )

    (cond
      ((not (null right)) (postorder right))
    )

    (cond
      ((null (car tree)) (PRINT tree))
      (t (PRINT (car tree)))
    )


  )

)
;(postorder binbaum)


; A2 b) 3)
(defun preorder (tree) 

  (let 
    (
      (left  (car (cdr tree)))
      (right (car (cdr (cdr tree))))
    )


    (cond
      ((null (car tree)) (PRINT tree))
      (t (PRINT (car tree)))
    )

    (cond
      ((not (null left)) (preorder left))
    )

    (cond
      ((not (null right)) (preorder right))
    )


  )

)
(preorder binbaum)
