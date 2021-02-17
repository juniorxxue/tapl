#lang typed/racket
(require datatype)

(define-datatype Term
  [TTrue (Symbol)]
  [TFalse (Symbol)]
  [TIf (Symbol Term Term Term)]
  [TZero (Symbol)]
  [TSucc (Symbol Term)]
  [TPred (Symbol Term)]
  [TIsZero (Symbol Term)])

(: is-numerical? : Term -> Boolean)
(define (is-numerical? e)
  (match e
    [(TZero _) #t]
    [(TSucc _ t1) (is-numerical? t1)]
    [else #f]))

(: eval1 : Term -> Term)
(define/match (eval1 e)
  [((TIf _ (TTrue _) t2 t3)) t2]
  [((TIf _ (TFalse _) t2 t3)) t3]
  [((TIf fi t1 t2 t3)) (TIf fi (eval1 t1) t2 t3)]
  [((TSucc fi t1)) (TSucc fi (eval1 t1))]
  [((TPred _ (TZero _))) (TZero 'dummyinfo)]
  [((TPred _ (TSucc _ nv1))) #:when (is-numerical? nv1) nv1]
  [((TPred fi t1)) (TPred fi (eval1 t1))]
  [((TIsZero _ (TZero _))) (TTrue 'dummyinfo)]
  [((TIsZero _ (TSucc _ nv1))) #:when (is-numerical? nv1) (TFalse 'dummyinfo)]
  [((TIsZero fi t1)) (TIsZero fi (eval1 t1))])
