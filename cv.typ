// Pollen-style helpers for a Typst CV.
// Mirrors the API of pollen.rkt so authoring stays declarative:
//   #title(...)[Name], #statement[...], #section("Work Experience")[...],
//   #par(org: ..., url: ..., area: ..., roles: (...), date: ..., loc: ...,
//        topics: "a, b, c")[body content].

#let _website-svg = (
  "<svg xmlns='http://www.w3.org/2000/svg' viewBox='-2 -2 26 26'"
  + " fill='none' stroke='currentColor' stroke-width='2.3'>"
  + "<path stroke-linecap='round' stroke-linejoin='round'"
  + " d='M13.19 8.688a4.5 4.5 0 011.242 7.244l-4.5 4.5a4.5 4.5"
  + " 0 01-6.364-6.364l1.757-1.757m13.35-.622l1.757-1.757a4.5 4.5 0"
  + " 00-6.364-6.364l-4.5 4.5a4.5 4.5 0 001.242 7.244'/></svg>"
)

#let _github-svg = (
  "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'"
  + " fill='currentColor'>"
  + "<path d='M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17"
  + ".55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48"
  + "-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21"
  + " 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95"
  + " 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64"
  + "-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44"
  + " 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95"
  + ".29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013"
  + " 8.013 0 0016 8c0-4.42-3.58-8-8-8z'/></svg>"
)

#let _linkedin-svg = (
  "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'"
  + " fill='currentColor'>"
  + "<path d='M20.5 2h-17A1.5 1.5 0 002 3.5v17A1.5 1.5 0 003.5 22h17a1.5"
  + " 1.5 0 001.5-1.5v-17A1.5 1.5 0 0020.5 2zM8 19H5v-9h3zM6.5 8.25A1.75"
  + " 1.75 0 118.3 6.5a1.78 1.78 0 01-1.8 1.75zM19 19h-3v-4.74c0-1.42-.6"
  + "-1.93-1.38-1.93A1.74 1.74 0 0013 14.19a.66.66 0 000 .14V19h-3v-9h2.9"
  + "v1.3a3.11 3.11 0 012.7-1.4c1.55 0 3.36.86 3.36 3.66z'/></svg>"
)

#let _icon(svg, url) = link(url, box(
  baseline: 0.2em,
  height: 1.1em,
  image(bytes(svg), format: "svg"),
))

#let cv-doc(body) = {
  set page(
    paper: "a4",
    margin: (x: 1.6cm, top: 1.2cm, bottom: 1.6cm),
  )
  set text(
    font: ("Charter", "Source Serif Pro"),
    size: 10pt,
    lang: "en",
    hyphenate: true,
  )
  set par(justify: false, leading: 0.8em)
  show link: underline.with(stroke: 0.4pt + rgb("#000000a0"), offset: 2pt)
  body
}

#let _sans = "Source Sans Pro"

#let title(
  name,
  street: "",
  city: "",
  phone: "",
  email: "",
  website: none,
  github: none,
  linkedin: none,
) = block(width: 100%, above: 1em, below: 1.5em, {
  set align(center)
  set text(font: _sans, tracking: 0.17em)
  // Name
  text(size: 1.7em, weight: 500, upper(name))
  // Address
  v(-0.6em)
  text(size: 0.95em, weight: 500, upper({
    [#street  #city]
  }))
  // Contact row
  v(0em)
  block(width: 100%, {
    set text(size: 0.95em, weight: 500)
    let parts = ()
    if phone != "" {
      parts.push(link("tel:" + phone, upper(phone)))
    }
    if email != "" {
      parts.push(link("mailto:" + email, upper(email)))
    }
    if website != none and website != "" {
      parts.push(_icon(_website-svg, website))
    }
    if github != none and github != "" {
      parts.push(_icon(_github-svg, github))
    }
    if linkedin != none and linkedin != "" {
      parts.push(_icon(_linkedin-svg, linkedin))
    }
    parts.join(h(1.5em))
  })
})

#let statement(body) = block(
  width: 100%,
  above: 2.5em,
  below: 2em,
  emph(body),
)

#let section(name, body) = block(
  width: 100%,
  above: 0.5em,
  below: 2.5em,
  {
    line(length: 100%, stroke: 0.4pt + black)
    v(0.5em, weak: true)
    block(inset: (left: 0.2em), text(
      font: _sans,
      weight: 800,
      size: 0.8em,
      tracking: 1.7pt,
      upper(name),
    ))
    body
    v(1.5em, weak: true)
  },
)

#let themes(s) = {
  let items = s.split(",").map(t => t.trim()).filter(t => t != "")
  block(above: 1.2em, below: 0em, {
    set text(size: 0.92em, weight: 400, font: _sans)
    items
      .map(t => box(t))
      .join(text(size: 0.85em)[ #h(0.3em) • #h(0.3em) ])
  })
}

#let e(body) = emph(body)

#let _role(r) = text(
  style: "italic",
  weight: 600,
  size: 0.95em,
  r,
)

#let par(
  body,
  org: "",
  url: "",
  area: "",
  roles: (),
  date: "",
  loc: "",
  topics: "",
  show-tops: true,
) = block(above: 1.5em, below: 0em, width: 100%, {
  // Head row: organization (linked) on the left, date on the right.
  if org != "" or date != "" or loc != "" {
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      column-gutter: 1em,
      {
        let org-text = text(weight: 500, size: 1.3em, org)
        if url != "" and url != none {
          link(url, org-text)
        } else {
          org-text
        }
        if area != "" {
          // hidden in classic.css (.area { display: none }) — keep parity
        }
      },
      {
        let parts = ()
        if date != "" { parts.push(text(weight: 500, size: 1.2em, date)) }
        // loc is also display:none in classic.css
        parts.join(h(0.5em))
      },
    )
  }
  // Roles column
  if type(roles) == array and roles.len() > 0 {
    v(0.8em, weak: true)
    for r in roles { block(spacing: 0.2em, _role(r)) }
  } else if type(roles) == str and roles != "" {
    v(1em, weak: true)
    block(spacing: 0.2em, _role(roles))
  }
  // Body content
  block(inset: (left: 1em), above: 1.2em, below: 0em, width: 95%, body)
  // Topics
  if show-tops and topics != "" {
    block(inset: (left: 1em), above: 1em, themes(topics))
  }
})

// `break` mirrors ◊break{} in pollen.rkt — a page break.
#let break-page() = pagebreak(weak: true)
