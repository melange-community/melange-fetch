(lang dune 3.8)

(using melange 0.1)

(generate_opam_files true)

(name melange-fetch)

(source
 (github melange-community/melange-fetch))

(authors "Antonio Nuno Monteiro <anmonteiro@gmail.com>")

(maintainers "Antonio Nuno Monteiro <anmonteiro@gmail.com>")

(homepage "https://github.com/melange-community/melange-fetch")

(bug_reports "https://github.com/melange-community/melange-fetch")

(license "MIT")

(package
 (name melange-fetch)
 (synopsis "Fetch API support for Melange")
 (depends
  ocaml
  (melange
   (>= "2.0.0"))))
