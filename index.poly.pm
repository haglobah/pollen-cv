#lang pollen

◊`(div ([class "mx-auto"])

	(section ([id "welcome"]
			  [class "flex flex-col-reverse justify-center sm:flex-row items-center mb-12 bg-cover bg-center scroll-mt-[12vh]"]
			  [style "background-image: url('./assets/dina_portrait.jpg')"])
	  (article ([class "flex flex-col justify-between items-center min-h-[88vh] w-full py-10 bg-black/30"])
		(div ([class "max-w-xl text-5xl p-8 text-center text-slate-100"])
			(p ([class "p-1"]) "Hi!"))
		(div ([class "max-w-xl text-5xl p-8 text-center text-slate-100"])
			(p ([class "p-1"]) "I'm Beat Hagenlocher."))
	  ))

	(section ([id "about"] [class "p-6 my-12 scroll-mt-[12vh]"])
	  (h2 ([class "text-5xl text-center mb-6 text-slate-900 dark:text-slate-200"])
			"Über mich")
	  (div ([class "flex flex-col items-center justify-around"])
		(p ([class "max-w-xl text-xl p-4 text-center text-slate-700 dark:text-slate-200"])
			"paragraph.")))

	(section ([id "methods"] [class "p-6 my-12 scroll-mt-[12vh]"])
	  (div ([class "flex flex-col items-center justify-around"])
		(h2 ([class "text-5xl text-center mb-6 text-slate-900 dark:text-slate-200"])
			"Behandlung")
		(p ([class "max-w-xl text-xl p-4 text-center text-slate-700 dark:text-slate-200"])
			" D")
		)
	)
  )
