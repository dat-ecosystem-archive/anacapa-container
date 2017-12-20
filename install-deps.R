# Install packages that are not currently installed -----
# This chunk may need attention, putting it here as a starting point - gsk
 .cran_packages  <-  c("ggplot2", "plyr", "dplyr","seqRFLP", "reshape2", "tibble")
 .bioc_packages <- c("phyloseq", "genefilter", "impute", "Biostrings", "dada2")
 
 .inst <- .cran_packages %in% installed.packages()
 if (any(!.inst)) {
   install.packages(.cran_packages[!.inst], repos = "http://cran.rstudio.com/")
 }
# 
 .inst <- .bioc_packages %in% installed.packages()
 if (any(!.inst)) {
   source("http://bioconductor.org/biocLite.R")
   biocLite(.bioc_packages[!.inst])
 }