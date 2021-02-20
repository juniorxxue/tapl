#lang racket


;; church booleans
(define tru
  (lambda (t)
    (lambda (f)
      t)))

(define fls
  (lambda (t)
    (lambda (f)
      f)))

(define test
  (lambda (l)
    (lambda (m)
      (lambda (n)
        ((l m) n)))))


((tru 1) 2)
((fls 1) 2)
(((test tru) 1) 2)
(((test fls) 1) 2)

(define pair
  (lambda (f)
    (lambda (s)
      (lambda (b)
        ((b f) s)))))

(define fst
  (lambda (p)
    (p tru)))

(define snd
  (lambda (p)
    (p fls)))


(fst ((pair 1) 2))
(snd ((pair 1) 2))
