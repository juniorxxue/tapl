#lang plai-typed

(define-type-alias nat-array
  (boxof (number -> number)))

(define (zero [n : number])
  0)

;; wraps a function which always return 0 at any indexes
;; (boxof (number -> number)))
(define newarray
  (box zero))

;; natarray -> num -> num
(define (lookup [a : nat-array]
                [n : number])
  ((unbox a) n))

;; (lookup newarray 0)

(define (update [a : nat-array]
                [m : number]
                [v : number])
  (let ([oldf (unbox a)])
    (set-box! a
              (lambda (n) (if (= m n)
                              v
                              (oldf n))))))

;; (update newarray 1 9999)
;; (lookup newarray 1)