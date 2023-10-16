◊(require racket/list racket/string pollen/pagetree racket/path)

◊(define (construct-head here title)
	(string-append (if (equal? (string-trim (symbol->string here) ".html") "index")
					   ""
					   (string-trim (symbol->string here) ".html"))
				   " "
				   (if title title "Beat Hagenlocher")))
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta property="og:title" value="◊(select 'h1 doc)">
        <title>◊(construct-head ◊|here| (select 'h1 doc))</title> <!-- or ◊|here| -->
        ◊when/splice[(equal? (symbol->string ◊|here|) "index.html")]{
            <script src="https://cdn.tailwindcss.com"></script>
        }
		<link rel="stylesheet" href="fonts.css">
		<link rel="stylesheet" href="classic.css">
		<link rel="stylesheet" href="print.css">
    </head>
    <body>
        <main>
            ◊(->html doc)
        </main>
    <footer>
        ◊; <p class="copyright">
        ◊;     ◊(get-year)
        ◊; </p>
    </footer>
</body>
</html>

