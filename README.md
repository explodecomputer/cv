# Gibran Hemani's CV

Academic CV built using R - updated automatically from [Google Scholar](https://scholar.google.com/citations?user=6fC0BYYAAAAJ&hl=en). 

## Structure

- `cv/cv.Rmd`: CV structure implemented as an [`{rmarkdown}`](https://rmarkdown.rstudio.com) document.
- `data/*.csv`: Data on each CV subcategory.
- `scripts/install.R`: Installs/loads all `R` dependencies using the [`{pacman}`](https://github.com/trinker/pacman) :package:.

## Tools

- The [`{vitae}`](https://docs.ropensci.org/vitae/) :package: is used to provide a CV template.
- [`{tidyverse}`](https://www.tidyverse.org) :tool: are used for data read in and manipulation.
- [`{here}`](https://here.r-lib.org) :package: for path management.
- [`{scholar}`](https://github.com/jkeirstead/scholar) :package: is used to pull papers from Google Scholar.
- [`{bib2df}`](https://cran.r-project.org/web/packages/bib2df/vignettes/bib2df.html) :package: is used to organise Google Scholar results into bibtex format for easier manipulation.

## Notes

Uses the `cv/nature.csl` file to format the citation styles. This is an edited version of the standard Nature format. It was edited using https://editor.citationstyles.org/visualEditor/ - allowing multiple named authors and the addition of the `note` field.

## To run

```
Rscript pubs.r
render cv.Rmd
```



