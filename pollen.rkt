#lang racket

(require txexpr
         pollen/core pollen/setup pollen/tag pollen/decode
         racket/date racket/string)
(provide (all-defined-out))


(define (get-date)
  (date->string (current-date)))
(define (get-year)
  (number->string (date-year (current-date))))

(define (splice-tag? tag class-name content)
	(if (equal? content "") "" `(,tag [[class ,class-name]] ,content)))

(define-syntax-rule (splice? tag var)
	(splice-tag? tag (symbol->string 'var) var))

(define-syntax-rule (if-var var content)
	(if (not (equal? var ""))
		content
		""))

(define (root . elements)
	`(root ,@elements))

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
			   #:git [git ""]
			   . elements)
  `(div [[class "header"]]
		(div [[class "title"]]
			 (h1 ,@elements))
	    (div [[class "info"]]
			 ,(splice? 'span street)
			 ,(splice? 'span city)
			 (div [[class "contact"]]
			 	  ,(if-var phone `(a [[href ,(string-append "tel:" phone)]] ,phone))
			 	  ,(if-var email `(a [[href ,(string-append "mailto:" email)]] ,email))
				  ,(if-var git `(a [[href ,git]] "Github"))
				))))

(define (statement . elements)
	`(div [[class "statement"]]
		  ,@elements))

(define (section title . elements)
	`(div [[class "section"]] 
		(div [[class "sec-title"]] (span ,title))
		(div [[class "paragraphs"]] ,@elements)))

(define (or-exists? . vars)
	(ormap 
		(λ (var)
			(if (equal? var "")
				#f
				#t))
		vars))

(define (themes tops)
  (let ([top-list (map (curry string-trim #:left? #t) 
  					   (string-split tops ","))])
	`(div [[class "topics"]]
		  ,@(map (curry splice-tag? 'span "topic") top-list))))

(define (par #:org [org ""]
			 #:area [area ""]
			 #:role [role ""] 
			 #:date [date ""]
			 #:loc [loc ""]
			 #:topics [topics ""]
			 . elements)
	`(div [[class "paragraph"]]
		,(if-var org 
				 `(div [[class "par-head"]]
					   (div [[class "organization"]]
							,(splice? 'span org)
							,(splice? 'span area))
					   (div [[class "spacetime"]]
							,(splice? 'span date)
							,(splice? 'span loc))))
		,(if-var role
				 `(div [[class "role_n_topics"]]
					   ,(splice? 'span role)
					   ,(if (equal? topics "") "" (themes topics))))
		(div [[class "content"]] ,@elements)))

(define (table . rows)
  `(table
	,@(map (λ (row)
        	  `(tr ,@(map
			          (λ (data)
					  	 `(td ,data))
					  (filter (λ (data) (not (equal? data "\n")))
							  (string-split row ",")))))
		   rows)))