
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
            (my_lengthR (car mylist)) ; berechne LÃ¤nge der geschachtelten Liste
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
  
  ; bei Atomen, hoch zÃ¤hlen und Rest berechnen
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
(setq testTreeInsertFile  (insertfile testTreeInsertFile "tree.txt"))

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
; Wert kleiner Wurzel => rekursiv contains fÃ¼r linken Teilbaum
; Wert grÃ¶ÃŸer Wurzel => rekursiv contains fÃ¼r rechten Teilbaum


(defun size (tree)
  (my_lengthR tree)
)
(size testTreeA)


(defun heightHelp (tree level)
  (cond
    ((null tree) 0)
    (t 
      (max (+ 1 (heightHelp (leftTree tree) (+ level 1)))
           (+ 1 (heightHelp (rightTree tree) (+ level 1)))
      )
    )
  )
)
(heightHelp '(5 (1)) 0)
(heightHelp testTreeA 0)
(heightHelp testTreeB 0)


(defun height (tree)
  (heightHelp tree 0)
)
(height '())
(height '(10))
(height '(10 (5)))
(height '(10 () (15)))
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

; wenn Knotenwert nil (leerer Baum), gib nil zurÃ¼ck
; wenn es keinen linken Teilbaum gibt, gib Knoten der Wurzel zurÃ¼ck
; ansonsten getMin rekursiv fÃ¼r linken Teilbaum aufrufen


(defun getMax (tree)
  (cond
    ((null (rootValue tree)) nil)
    ((null (rightTree tree)) (rootValue tree))
    (t (getMax (rightTree tree)))
  )
)
(  getMax '(10 (5) (15 (14) (19)))  )
(getMax testTreeA)


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
    ((= level 1) (PRINC (rootValue tree)) (PRINC '+))
    ((> level 1) 
      (printLevelorderHelp (leftTree tree) (- level 1))
      (printLevelorderHelp (rightTree tree) (- level 1))
    )
  )
)
;(printLevelorderHelp testTreeA 3)


(defun printLevelorder (tree)
  (setq height 4)
  (setq i 0)
  (loop while (<= i 4) do
    (printLevelorderHelp tree i)
    (setq i (+ i 1))
    (PRINT '-)
  )
)
;(printLevelorder testTreeA)

