#lang racket/base

(require txexpr
         pollen/core pollen/setup pollen/tag pollen/decode
         racket/date)
(provide (all-defined-out))


(define (get-date)
  (date->string (current-date)))
(define (get-year)
  (number->string (date-year (current-date))))

(define (splice? tag var varname)
	(if (equal? var "") "" `(,tag [[class ,varname]] ,var)))

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
(define (ul . elements)
	`(ul ,@elements))
(define (ol . elements)
	`(ol ,@elements))
(define (li . elements)
	`(li ,@elements))
(define (code . elements)
	`(code ,@elements))
(define c code)

(define (sub . elements)
  `(h4 [[class "subhead"]] ,@elements))

(define (title #:street [street ""] 
			   #:city [city ""] 
	  		   #:phone [phone ""]
			   #:email [email ""]
			   . elements)
  `(div [[class "title"]]
		(h1 ,@elements)
	    ,(splice? 'span street "street")
		,(splice? 'span city "city")
		"\n"
		,(splice? 'span phone "phone")
		,(splice? 'span email "email")))

(define (section title . elements)
	`(div [[class "section"]] 
		(div [[class "name"]] ,title)
		(div [[class "content"]] ,@elements)))

(define (par #:org [org ""]
			 #:area [area ""]
			 #:role [role ""] 
			 #:date [date ""]
			 #:loc [loc ""]
			 #:topics [topics ""]
			 . elements)
	`(div [[class "paragraph"]]
		,(splice? 'span org "org")
		,(splice? 'span area "area")
		,(splice? 'span role "role")
		,(splice? 'span date "date")
		,(splice? 'span loc "loc")
		,(splice? 'span topics "topics")
		(p ,@elements)))