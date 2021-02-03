--- 
  title: "MSKCC Biostatistics Course"
date: "Last Updated: `r format(Sys.Date(), format='%B %d, %Y')`"
site: bookdown::bookdown_site
output:
  bookdown::gitbook:
  config:
  sharing:
  facebook: false
twitter: false
rmarkdown::pdf_document:
  keep_tex: yes
latex_engine: xelatex
includes:
  in_header: header.tex
documentclass: book
rmd_files: ["index.Rmd", "01-week1.Rmd", "02-week2.Rmd", "03-week3.Rmd", "04-week4.Rmd", "05-week5.Rmd", "06-week6.Rmd", "07-week7.Rmd", "08-week8.Rmd", "09-answers.Rmd"]
bibliography: [packages.bib]
biblio-style: apalike
link-citations: yes
description: "Statistics Course"
always_allow_html: true
---