#lang typed/racket
(require datatype)
(require typed-map)

(define-datatype Term
  [TVar (Symbol Integer Integer)]
  [TAbs (Symbol String Term)]
  [TApp (Symbol Term Term)])

(define-datatype Binding
  [NameBind ()])

(define-type Context (Listof (Pairof String Binding)))

(: pick-freshname : Context String -> (Pairof Context String))
(define (pick-freshname ctx x)
  (if (member x (map car ctx))
      (pick-freshname ctx (string-append x "'"))
      (cons (cons (cons x (NameBind)) ctx) x)))

(: index->name : Symbol Context Integer -> String)
(define (index->name fi ctx n)
  (car (list-ref ctx n)))

(: print-term : Context Term -> (Listof String))
(define (print-term ctx t)
  (match t
    [(TAbs fi x t1) (let ([new-ctx-x (pick-freshname ctx x)])
                      `("(lambda " ,(cdr new-ctx-x) ". " ,@(print-term (car new-ctx-x) t1) ")"))]
    [(TApp fi t1 t2) `("(" ,@(print-term ctx t1) " " ,@(print-term ctx t2) ")")]
    [(TVar fi x n) (if (equal? (length ctx) n)
                       `(,(index->name fi ctx x))
                       '("bad index"))]))
