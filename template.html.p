◊(require racket/list racket/string pollen/pagetree racket/path)
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta property="og:title" value="◊(select 'h1 doc)">
        <title>◊(select 'h1 doc)</title> <!-- or ◊|here| -->
		<link rel="stylesheet" href="fonts.css">
		<link rel="stylesheet" href="style.css">
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

