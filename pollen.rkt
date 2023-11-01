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
			   #:website [website ""]
			   #:github [github ""]
			   #:linkedin [linkedin ""]
			   . elements)
  `(div [[class "header"]]
		(div [[class "title"]]
			 (h1 ,@elements))
	    (div [[class "info"]]
			 (div [(class "address")]
			 	  ,(splice? 'span street)
			 	  ,(splice? 'span city))
			 (div [[class "contact"]]
			 	  ,(if-var phone `(a [[class "phone"] [href ,(string-append "tel:" phone)]] ,phone))
			 	  ,(if-var email `(a [[class "email"] [href ,(string-append "mailto:" email)]] ,email))
				))
		(div [[class "links"]]
			,(if-var website `(a [[class "link"] [href ,website]] (svg ([xmlns "http://www.w3.org/2000/svg"] [viewBox "-2 -2 26 26"] [fill "none"] [stroke "currentColor"] [stroke-width "2.3"] [class "link-icon"] [aria-hidden "true"])
			(path ([stroke-linecap "round"] [stroke-linejoin "round"] [d "M13.19 8.688a4.5 4.5 0 011.242 7.244l-4.5 4.5a4.5 4.5 0 01-6.364-6.364l1.757-1.757m13.35-.622l1.757-1.757a4.5 4.5 0 00-6.364-6.364l-4.5 4.5a4.5 4.5 0 001.242 7.244"])))))
			,(if-var github `(a [[class "link"] [href ,github]]
								(svg ([xmlns "http://www.w3.org/2000/svg"] [viewBox "0 0 16 16"] [fill "currentColor"] [class "link-icon"] [aria-hidden "true"])
			(path ([d "M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"])))))
			,(if-var linkedin `(a [[class "link"] [href ,linkedin]]
								(svg ([xmlns "http://www.w3.org/2000/svg"] [viewBox "0 0 24 24"] [fill "currentColor"] [class "link-icon"] [aria-hidden "true"])
			(path ([d "M20.5 2h-17A1.5 1.5 0 002 3.5v17A1.5 1.5 0 003.5 22h17a1.5 1.5 0 001.5-1.5v-17A1.5 1.5 0 0020.5 2zM8 19H5v-9h3zM6.5 8.25A1.75 1.75 0 118.3 6.5a1.78 1.78 0 01-1.8 1.75zM19 19h-3v-4.74c0-1.42-.6-1.93-1.38-1.93A1.74 1.74 0 0013 14.19a.66.66 0 000 .14V19h-3v-9h2.9v1.3a3.11 3.11 0 012.7-1.4c1.55 0 3.36.86 3.36 3.66z"])))))
		)))

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

(define (to-roles roles)
  (for/splice ([r roles])
  `(span [[class "role"]] ,r)))

(define (themes tops)
  (let ([top-list (map (curry string-trim #:left? #t) 
  					   (string-split tops ","))])
	`(div [[class "topics"]]
		  ,@(map (curry splice-tag? 'span "topic") top-list))))

(define (par #:org [org ""]
			 #:area [area ""]
			 #:roles [roles ""] 
			 #:date [date ""]
			 #:loc [loc ""]
			 #:topics [topics ""] #:show-tops? [show-tops #t]
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
		,(if-var roles
				 `(div [[class "roles"]]
					   ,(if-var roles (to-roles roles))
					   #;,(if-var topics (themes topics))))
		(div [[class "content"]] 
			 ,@elements 
			 ,(if show-tops
			 	  (if-var topics (themes topics))
				  ""))))

(define (table . rows)
  `(table
	,@(map (λ (row)
        	  `(tr ,@(map
			          (λ (data)
					  	 `(td ,data))
					  (filter (λ (data) (not (equal? data "\n")))
							  (string-split row ",")))))
		   rows)))