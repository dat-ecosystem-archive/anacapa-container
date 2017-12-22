# Install packages that are not currently installed -----
# This chunk may need attention, putting it here as a starting point - gsk
.cran_packages  <-  c("ggplot2", "plyr", "dplyr","seqRFLP", "reshape2", "tibble", "devtools", "Matrix", "mgcv")
.bioc_packages <- c("phyloseq", "genefilter", "impute", "Biostrings")

.inst <- .cran_packages %in% installed.packages()
if (any(!.inst)) {
  install.packages(.cran_packages[!.inst], repos = "http://cran.rstudio.com/")
}

.inst <- .bioc_packages %in% installed.packages()
if (any(!.inst)) {
  source("http://bioconductor.org/biocLite.R")
  biocLite(.bioc_packages[!.inst])
}

.dada_version_gh = "v1.6"
if(!("dada2" %in% installed.packages())){
  # if the user doesn't have dada2 installed, install version 1.6 from github
  devtools::install_github("benjjneb/dada2", ref=.dada_version_gh)
}