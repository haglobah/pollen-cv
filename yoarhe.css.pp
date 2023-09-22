#lang pollen

◊(define light? #f)
◊(define (insert color #:strong? [strong #f])
(let ([intensity (if light?
						 (if strong "dark" "light")
						 (if strong "light" "dark"))])
		 (string-append "var(--" color "-" intensity ")")))
◊(define dark "#282D3F")
/*
  1. Use a more-intuitive box-sizing model.
*/
*, *::before, *::after {
	box-sizing: border-box;
  }
  /*
	2. Remove default margin
  */
  * {
	margin: 0;
  }
  /*
	3. Allow percentage-based heights in the application
  */
  html, body {
	height: 100%;
  }
  /*
	Typographic tweaks!
	4. Add accessible line-height
	5. Improve text rendering
  */
  body {
	line-height: 1.5;
	-webkit-font-smoothing: antialiased;
  }
  /*
	6. Improve media defaults
  */
  img, picture, video, canvas, svg {
	display: block;
	max-width: 100%;
  }
  /*
	7. Remove built-in form typography styles
  */
  input, button, textarea, select {
	font: inherit;
  }
  /*
	8. Avoid text overflows
  */
  p, h1, h2, h3, h4, h5, h6 {
	overflow-wrap: break-word;
  }
  /*
	9. Create a root stacking context
  */
  #root, #__next {
	isolation: isolate;
  }

/* End of CSS Reset */

body {
	background-color: ◊(insert "bg");
}

main {
	margin: 75px 10px;
}

:root {
    font-family: "Fira Sans", sans-serif;
    font-size: 16px;
	font-weight: 400;
    line-height: 1.5;
    color: ◊(insert "font" #:strong? #t);
    hyphens: auto;
	max-width: 650px;
	margin: auto;
	
	--cv1: #a00;
	--cv2: #ccc;
	--fst-clr-bg: #f1f5ff;
	--fst-light: #97b6f0;
    --fst-dark: #6E98E8;
    --snd-light: #ecb1a2;
    --snd-dark: #DC755C;

    --bg-dark: ◊|dark|;
	--bg-light: white;
	--font-dark: ◊|dark|;
	--font-light: #e5e9f0;
	--tag-light: #f9f9f9;
	--tag-dark: #383d4f;
	/*--bg-clr: #F9F4F5;*/ --bg-color: #F3F3F3;

    --hover-transition: all ease-in-out 75ms;

    --shadow-normal: rgba(0, 0, 0, 0.2) 2px 5px 10px -4px;
    --border-top-normal: 1px solid rgba(255, 255, 255, 0.1);
    --border-bottom-normal: 1px solid rgba(0, 0, 0, 0.1);
}

a {
	color: ◊(insert "fst");
	text-decoration: none;
	height: 1rem;
	line-height: 1rem;
	border-bottom: 2px transparent ◊(insert "bg");
	opacity: inherit;
}

a:hover {
	color: ◊(insert "fst" #:strong? #t);
	height: 1rem;
	line-height: 1rem;
	border-bottom: 2px solid ◊(insert "fst" #:strong? #f);
}

span {
	white-space: nowrap;
}


ul {
	margin: 0 0 0 1rem;
	padding: 0;
}

/*uncomment to get dashes in the list*/
/*li:before {
	content: "-";
	position: relative;
	left: -0.25em;
}*/

h1,h2,h3,h4, .sec-title, .topics, .info{
	font-family: 'Fira Sans';
}

/* .par-head, .org, .area, .role {
	
} */

h1 {
	font-size: 2rem;
	line-height: 2.3rem;
	font-weight: 400;
}

.header {
	margin: 1.6rem auto;
	width: 82%;
	text-transform: uppercase;
	text-align: center;
	letter-spacing: 0.15em;
}

.info {
	margin: 1rem 0;
	font-weight: 600;
	text-transform: uppercase;
}

.contact {
	display: flex;
	justify-content: space-around;
	flex-flow: row wrap;
	margin: 0.4rem;
}

.street, .city, .phone, .email, .git, .contact{
	margin: 0.2rem;
	white-space: nowrap;
	font-size: 0.87rem;
	font-weight: 400;
}

.street {
	margin: 0 0.8rem 0 0;
}

.statement {
	font-style: italic;
	
}

.section {
	margin: 1.5rem;
	padding-top: 0.2rem;
	border-top: 2px solid ◊(insert "snd");
}

.sec-title {
	color: ◊(insert "snd");
	font-weight: 500;
	font-size: 0.95rem;
	letter-spacing: 2px;
	text-transform: uppercase;
	margin: 0.2rem 0 0 0.2rem;
}

.paragraph {
	margin: 0.3rem 0;
}

.par-head, .role_n_topics{
	display: flex;
	flex-flow: row wrap;
	justify-content: space-between;
	align-items: center;
	margin: 0 0.5rem;
}

.organization, .spacetime {
	display: flex;
	flex-flow: row wrap;
	align-items: center;
}

.spacetime {
	justify-content: flex-end;
}

.org, .area, .role, .date, .loc {
	padding: 0 0.5rem 0 0;
}

.org {
	color: ◊(insert "fst" #:strong? #t);
	font-family: 'Fira Code';
	font-weight: 400;
	font-size: 1.4rem;
}

.area {
	display: none;

	font-weight: 300;
}

.date, .loc {
	font-family: 'Fira Code';
	font-size: 1.05rem;
	letter-spacing: -0.1rem;
	font-weight: 400;
}

.loc {
	display: none;
}

.role {
	font-weight: 400;
	font-style: italic;
	font-size: 90%;
}

.topics {
	display: flex;
	flex-flow: row wrap;
	justify-content: flex-start;
	text-transform: lowercase;
	margin: 0.1rem 0 0.35rem 0;
	font-size: 82%;
	font-weight: 400;
	color: ◊(insert "snd");
}

.topic {
	margin: 0.1rem 0.6rem 0.1rem 0;
	padding: 0 4px 0 4px;
	background-color: ◊(insert "tag");
	border-radius: 6px;
	line-height: 1.3em;
}

.topic::before {
	font-size: 85%;
	content: "#";
	padding: 0 0.1em 0 0;
}

.topic:nth-last-child(1) {
	margin-right: 0;
}

.content {
	margin: 1rem auto;
	width: 90%;
}

tr td:nth-child(1) {
	white-space: nowrap;
	padding: 0 0.5rem 0 0;
}


footer {
    text-align: center;
    padding: 2em;
	/* border-top: 1px solid var(--fst-clr-bg); */
    /* background-color: var(--fst-clr-bg); */

}