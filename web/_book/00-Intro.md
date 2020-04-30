---
editor_options:
  chunk_output_type: console
---

# Introduction {-}

This is the website hosting all the theories and and practices regarding stochastic simulation and statistics. It has the following features:

- `R` with Tidyverse package families is used to plot graphs and analyze results.
- Some detailed equations are included.




I have encountered following issues:

- [Option to limit the depth of numbered headings](https://github.com/rstudio/bookdown/issues/495). There is no way to set the depth of section numbering, so all small sections have to be followed by `{-}`.
- [Turning off section numbering in Bookdown output](https://community.rstudio.com/t/turning-off-section-numbering-in-bookdown-output/16272).
- [Echo=FALSE and Theorems](https://github.com/rstudio/bookdown/issues/220). Remember to add `echo=T` in `theorem`-family environments, because the default value for `echo` is false.
- Every changed chapters have to be rendered, because I have set "Knit and Merge"" (K-M).

The logic behind the book is:

- All datasets and packages are defined at the beignning of the chapter.
- Usually, multiple datasets are included.
