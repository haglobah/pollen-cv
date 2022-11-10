#lang racket

(require txexpr
         pollen/core pollen/setup pollen/tag pollen/decode
         racket/date)
(provide (all-defined-out))


(define (get-date)
  (date->string (current-date)))

(define (get-year)
  (number->string (date-year (current-date))))

(define (root . elements)
  (let 
    ([output (decode-elements elements 
							  #:txexpr-elements-proc decode-paragraphs)])
	(txexpr 'root empty output)))

(define (link url . elements)
  `(a [[href ,url]] ,@elements))
(define l link)

(define (b . elements)
	`(b ,@elements))
(define (e . elements)
	`(i ,@elements))

(define (sub . elements)
  `(h4 [[class "subhead"]] ,@elements))

(define (title #:sub [subtitle ""] . elements)
  `(div [[class "title"]]
		  (h1 ,@elements)
		  ,(sub subtitle)))

(define (ul . elements)
	`(ul ,@elements))
(define (ol . elements)
	`(ol ,@elements))
(define (li . elements)
	`(li ,@elements))
(define (code . elements)
	`(code ,@elements))
(define c code)

(define (section #:title [title ""] . elements)
	`(div [[class "section"]] ,@elements))



(define (par #:org [org ""] 
			 #:role [role ""] 
			 #:date [date ""]
			 #:loc [loc ""]
			 #:topics [topics ""]
			 . elements)
	`(div [[class "paragraph"]]
		,(if (equal? org "") "" `(span [[class "org"]] ,org))
		(p ,@elements)))