
; PR3 Lisp
; blatt2.pdf


;       10
;      /  \
;     5    15
;    / \     \
;   2  7      17
;  /
; 1

(setq testTreeA
  '(
    10 (5 (2 (1)) (7)) (15 () (17))
  )
)

;       10
;      /  \
;     5    15
;          /  \
;         12  17
;          \
;          13

(setq testTreeB
  '(
    10 (5) (15 (12 () (13)) (17))
  )
)


(defun leftTree (tree)
  (car (cdr tree))
)
(leftTree testTreeA)


(defun rightTree (tree)
  (car (cdr (cdr tree)))
)
(rightTree testTreeA)


(defun rootValue (tree)
  (car tree)
)
(rootValue testTreeA)


(defun createTree (parent leftChild rightChild)
  ;(append (list parent) leftChild rightChild)
  (list parent leftChild rightChild)
)
(createTree 12 '() '())


(defun my_lengthR (mylist)
  (cond
    ((null mylist) 0) ; trivialer Fall: leere Liste
    (t

      (cond
        ((listp (car mylist)) ; wenn Element eine (geschachtelte) Liste ist
          (+
            0
            (my_lengthR (car mylist)) ; berechne Länge der geschachtelten Liste
            (my_lengthR (cdr mylist)) ; berechne Rest
          )
        )

        (t
          (+
            1
            (my_lengthR (cdr mylist)) ; berechne Rest
          )
        )
      )

    )
  )
  
  ; bei Atomen, hoch zählen und Rest berechnen
  ; bei Listen, diese berechnen und Rest berechnen

)


; -------------------------

(defun insert (tree val)
  (cond
    (
      (null (rootValue tree))
        (list val)
    )
    (
      (= val (rootValue tree))
        tree
    )
    (
      (< val (rootValue tree))
        (createTree (rootValue tree) (insert (leftTree tree) val) (rightTree tree))
    )
    (
      (> val (rootValue tree))
        (createTree (rootValue tree) (leftTree tree) (insert (rightTree tree) val))
    )
  )
)
(setq testTreeInsert '())
(setq testTreeInsert (insert testTreeInsert 10))
(setq testTreeInsert (insert testTreeInsert 5))
(setq testTreeInsert (insert testTreeInsert 15))
(setq testTreeInsert (insert testTreeInsert 2))
(setq testTreeInsert (insert testTreeInsert 7))
(setq testTreeInsert (insert testTreeInsert 1))
(setq testTreeInsert (insert testTreeInsert 17))
;(printLevelOrder testTreeA)
;(printLevelOrder testTreeInsert)


(defun insertfile (tree filename)
  (setq in (open filename))          ; Datei die gelesen werden soll

  ; "nil nil" damit am Ende der Datei nil zurueck gegeben wird (statt Fehler)
  (setq num (read in nil nil))       ; ersten Wert aus Datei in num zw.speichern
  (setq tree (insert tree num))      ; ersten Wert im Baum einfuegen

  (loop while (not (null num)) do    ; abbrechen wenn nil statt Zahl
    (setq num (read in nil nil))     ; naechsten Wert lesen und zw.speichern

    ; num nur in Baum einfuegen wenn nicht nil
    (cond
      ((not (null num)) (setq tree (insert tree num)))
      (t nil)
    )
  )

  tree                               ; Baum zurueckgeben
)
(setq testTreeInsertFile '(10))
;(setq testTreeInsertFile  (insertfile testTreeInsertFile "tree.txt"))

; Dateiinhalt tree.txt: 5 15 2 7 1 17


(defun contains (tree val)
  (cond
    ((null tree) nil) ; trivialer Fall: nicht gefunden
    ((= val (rootValue tree)) t) ; trivialer Fall: gefunden
    ((< val (rootValue tree)) (contains (leftTree tree) val))
    ((> val (rootValue tree)) (contains (rightTree tree) val))
  )
)
(contains '() 5)
(contains testTreeA 7)

; leerer Baum => Wert nicht im Baum
; gesuchter Wert = Wert von Wurzel => ist im Baum
; Wert kleiner Wurzel => rekursiv contains für linken Teilbaum
; Wert größer Wurzel => rekursiv contains für rechten Teilbaum


(defun size (tree)
  (my_lengthR tree)
)
(size testTreeA)


(defun height (tree)
  (cond
    ((null tree) 0)
    (t 
      (max (+ 1 (height (leftTree tree)))
           (+ 1 (height (rightTree tree)))
      )
    )
  )
)
(height '())
(height '(10))
(height '(10 (5)))
(height '(10 () (15)))
(height testTreeA)
(height testTreeB)


(defun getMin (tree)
  (cond
    ((null (rootValue tree)) nil)
    ((null (leftTree tree)) (rootValue tree))
    (t (getMin (leftTree tree)))
  )
)
(getMin '(10 (5)))
(getMin testTreeA)

; wenn Knotenwert nil (leerer Baum), gib nil zurück
; wenn es keinen linken Teilbaum gibt, gib Knoten der Wurzel zurück
; ansonsten getMin rekursiv für linken Teilbaum aufrufen


(defun getMax (tree)
  (cond
    ((null (rootValue tree)) nil)
    ((null (rightTree tree)) (rootValue tree))
    (t (getMax (rightTree tree)))
  )
)
(  getMax '(10 (5) (15 (14) (19)))  )
(getMax testTreeA)


(defun removeVal (tree val)
  (cond
    (
      (null (rootValue tree))
        nil
    )
    (
      (and (= val (rootValue tree)) (= (height tree) 1))
        nil
    )
    (
      ( and (= val (rootValue tree)) (null (rightTree tree)) )
        (createTree (getMax (leftTree tree)) (removeVal (leftTree tree) (getMax (leftTree tree))) nil)
    )
    (
      (= val (rootValue tree))
        (createTree (getMin (rightTree tree)) (leftTree tree) (removeVal (rightTree tree) (getMin (rightTree tree))) )
    )
    (
      (< val (rootValue tree))
        (createTree (rootValue tree) (removeVal (leftTree tree) val) (rightTree tree))
    )
    (
      (> val (rootValue tree))
        (createTree (rootValue tree) (leftTree tree) (removeVal (rightTree tree) val))
    )
  )
)
(removeVal '() 5)
(setq testTreeRemoveVal '(10 (5 (2 (1) NIL) (7)) (15 NIL (17))))
(setq testTreeRemoveVal (removeVal testTreeRemoveVal 10))
(setq testTreeRemoveVal (removeVal testTreeRemoveVal 5))
(setq testTreeRemoveVal (removeVal testTreeRemoveVal 15))
(setq testTreeRemoveVal (removeVal testTreeRemoveVal 2))
(setq testTreeRemoveVal (removeVal testTreeRemoveVal 7))
(setq testTreeRemoveVal (removeVal testTreeRemoveVal 1))
(setq testTreeRemoveVal (removeVal testTreeRemoveVal 17))


(defun isEmpty (tree)
  (cond
    ((not (null tree)) nil)
    (t t)
  )
)
(isEmpty testTreeA)
(isEmpty '())


(defun printLevelorderHelp (tree level)
  (cond
    ((null tree) nil)
    ((= level 1) (PRINC (rootValue tree)) (PRINC " "))
    ((> level 1) 
      (printLevelorderHelp (leftTree tree) (- level 1))
      (printLevelorderHelp (rightTree tree) (- level 1))
    )
  )
)
;(printLevelorderHelp testTreeA 3)


(defun printLevelorder (tree)
  (setq i 0)
  (loop while (<= i (height tree)) do
    (printLevelorderHelp tree i)
    (setq i (+ i 1))
    (format t "~%")
  )
)
;(printLevelorder testTreeA)


(setq testTreeMenu '())

(defun menu ()
  (setq bed 1)
  (loop while (= bed 1) do
    (format t "~%")
    (format t "=====================================~%")
    (format t "1 insert~%")
    (format t "2 insertfile~%")
    (format t "3 contains~%")
    (format t "4 size~%")
    (format t "5 height~%")
    (format t "6 getMin~%")
    (format t "7 getMax~%")
    (format t "8 removeVal~%")
    (format t "9 isEmpty~%")
    (format t "10 addAll~%")
    (format t "11 printLevelorder~%")
    (format t "0 exit~%")
    (format t "---~%")
    (format t "choose ")
    (setq num (read))
    (format t "---~%")
    (case num
      (1 (PRINC "insert number: ") (PRINC (setq testTreeMenu (insert testTreeMenu (read)))))
      (2 (PRINC "file: ") (PRINC (setq testTreeMenu (insertfile testTreeMenu (read)))))
      (3 (PRINC "contains number: ") (PRINC (contains testTreeMenu (read))))
      (4 (PRINC "size => ") (PRINC (size testTreeMenu)))
      (5 (PRINC "height => ") (PRINC (height testTreeMenu)))
      (6 (PRINC "min => ") (PRINC (getMin testTreeMenu)))
      (7 (PRINC "max => ") (PRINC (getMax testTreeMenu)))
      (8 (PRINC "remove number: ") (setq testTreeMenu (PRINC (removeVal testTreeMenu (read)))))
      (9 (PRINC "is empty => ") (PRINC (isEmpty testTreeMenu)))
      (10 (PRINC (addAll testTreeMenu testTreeB)))
      (11 (PRINC (printLevelorder testTreeMenu)))
      
      (0 (PRINC "exit") (setq bed 0))
      (t (PRINC "error"))
    )
  )
)
(menu)

