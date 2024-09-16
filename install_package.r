# For Linux users ####
#
# Before installing these packages, it's recommended to install three specific to Linux
# that, if missing, will prevent functionality. Install them via `bash` in **Ubuntu** using the following steps:
#
# To keep all packages up-to-date in a Debian-based Linux like Ubuntu. 
# More information at <https://www.freecodecamp.org/news/sudo-apt-get-update-vs-upgrade-what-is-the-difference/>
# `$ sudo apt-get update` 
#
# To check which packages have been updated, use:
# `$ sudo apt-get upgrade` 
#
# To install the full version of R, including libraries to compile.
# More info at <https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html>
# `$ sudo apt-get install r-base r-base-dev` 
#
# Installation of main dependencies
# `$ sudo apt-get install libblas-dev liblapack-dev libgfortran-8-dev gfortran`
# 
# Install these other libraries that some R packages may require:
# `$ sudo apt-get install libatlas3-base libssl-dev libclang-14-dev libclang-dev libcurl4-openssl-dev`
# `$ sudo apt-get install libzmq3-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev` 
# `$ sudo apt-get install libtiff5-dev libjpeg-dev build-essential libfontconfig1-dev`
# `$ sudo apt-get install libnlopt-dev libxml2-dev libpoppler-cpp-dev cmake`
#
# Optionally, you can install these other libraries for Java and other languages:
# `$ sudo apt-get install -y r-cran-xml r-cran-rjava openjdk-7-* libgdal-dev libproj-dev libgsl-dev`
# `$ sudo apt-get install -y xml2 default-jre default-jdk mesa-common-dev libglu1-mesa-dev freeglut3-dev`
# `$ sudo apt-get install -y libx11-dev r-cran-rgl r-cran-rglpk r-cran-rsymphony r-cran-plyr`
# `$ sudo apt-get install -y  r-cran-reshape  r-cran-reshape2 r-cran-rmysql`
#
# If some dependencies were not installed, fix it with:
# `$ sudo apt --fix-broken install`

# If you get an error message when installing R packages like 
#    /usr/bin/ld: cannot find -lgfortran
# ensure that this library is in the /usr/bin/ directory by creating a symbolic link with this bash command:
# `$ sudo ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.5 /usr/lib/libgfortran.so`
#
# If you want to change the location of non-base libraries installed, you can globally change the folder with
# 
# `> .libPaths("path-to-the-new-folder")`
#
# or you can install certain libraries in another folder using the `lib` parameter of `install.packages` as
# 
# `> install.packages(new_libs, dependencies = TRUE, lib = "path-to-the-new-folder")`
# 

# //////////////////////////
# How to generate an HTML ####
#
# You can generate an HTML in different ways with this script:
# 1) Press the "Compile Report" button in RStudio 
# 2) Use the keyboard shortcut SHIFT-CMD-K (Mac) or SHIFT-CTRL-K (Windows or Linux)
# 3) Use the command rmarkdown::render("install-libraries_GISa-HAB.R"), provided you have installed the 'rmarkdown' package
#
# However, you may encounter error messages or the process may freeze, so it's better not to try it for now.
#


# ///////////////////////////
# Installed packages ####
# 
# More details <https://www.r-bloggers.com/an-efficient-way-to-install-and-load-r-packages/>

installed_libs <- rownames(installed.packages())
cat("You have ", length(installed_libs), " R packages installed on your computer \n")
cat("New libraries will be installed in the directory \n")
.libPaths()


# ////////////////////////////////////
# CRAN packages installation ####
# 
# We create a vector with the names of the packages needed for the course

cat("\n*** Checking CRAN libraries that must be installed *** \n\n")

libs_HAB_CRAN <- c("R.utils", "digest", "rlang", "fastmap", "htmltools", "xfun", "yaml", 
                   "ggplot2", "ggrepel", "gridExtra", "tidyverse", "tidyquant", "ggpubr",
                   "scales", "reshape2", "plotly", "ggcorrplot", "GGally", "venn", "ggvenn", "gplots", 
              "VennDiagram", "grid", "knitr", "knitcitations", "markdown", "rmarkdown", "bibtex", "DT",
              "kableExtra", "scholar", "rentrez", "igraph", "psych", "corrplot", "cluster", "NbClust",
              "dendextend", "factoextra", "tidytext", "tm", "wordcloud", "wordcloud2", "SnowballC",
              "ggwordcloud", "caret", "devtools", "parallel", "pryr", "beepr", "reactable", "gt", "gtExtras", "statmod",
              "fpc", "mclust", "amap", "ggfortify", "gptstudio", "randomForest", "LogicReg", "elasticnet", 
              "visNetwork", "rpart.plot", "GWalkR", "quarto")

# Compare installed libraries with those to be installed, downloading only the ones that need installation
new_libs_CRAN <- libs_HAB_CRAN[!(libs_HAB_CRAN %in% installed_libs)]

cat(length(new_libs_CRAN), " libraries to be installed from CRAN: \n", paste(new_libs_CRAN, collapse = ", "), "\n\n")


# Actual installation of the libraries in the `new_libs_CRAN` vector, 
# provided it's not empty (indicating all are installed), 
# which is checked with `length(new_libs_CRAN) > 0`.

# set default repository 
CRAN_REPOS <- getOption("repos") # use default repository
# or select a repository from https://cran.r-project.org/mirrors.html
# CRAN_REPOS <- "http://cran.rstudio.com/"

if (length(new_libs_CRAN)) {
  # install absent packages
  install.packages(new_libs_CRAN, dependencies = TRUE, repos = CRAN_REPOS)
  cat("\n*** The following", length(new_libs_CRAN), "CRAN libraries were installed at\n    ", R.home(), "\n")
  cat(toString(new_libs_CRAN))
} else {
  message("CRAN packages were already installed")
}

# remove needless variables
rm(libs_HAB_CRAN, new_libs_CRAN, CRAN_REPOS)


# ////////////////////////////////////////////
# Bioconductor packages installation ####
# 
# You'll find more information at <https://www.bioconductor.org/install/>. 
# First, we will check which packages are necessary and not yet installed 
# (absent in the `installed_libs` vector). Along the way, we'll install the 
# `BiocManager` package needed to install these libraries.

cat("\n*** Checking Bioconductor libraries that must be installed  ***\n\n")

# Install last version of 'BiocManager' before installing any BioConductor library
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
# BiocManager::install(version = "3.16") # for R > 4.3
BiocManager::install(ask = FALSE)

# If using an older version of R, you'll receive an error message like:
# 
# Bioconductor version '3.18' is out-of-date; the current release version '3.19' is available with R version '4.4'; see
# https://bioconductor.org/install
# Error: Bioconductor version '3.17' requires R version '4.3'; 
# use `BiocManager::install(version = '3.16')` with R version 4.2; see https://bioconductor.org/install
# Error: Bioconductor version '3.16' requires R version '4.2'; use `version = '3.18'` with R version 4.3; see
# https://bioconductor.org/install
# 
# In that case, modify the code to the recommended version compatible with your R. You can also perform a basic installation with:
# 
# > BiocManager::install(ask = FALSE)

# New vector with the required Bioconductor libraries.
libs_HAB_BioC <- c("edgeR", 
               "limma", 
               "RColorBrewer",
               "phyloseq",
               "chromPlot",
               "pathview",
               "Biostrings")

# Obtain the list of libraries to install, as before, if there's anything to install
new_BioC <- libs_HAB_BioC[!(libs_HAB_BioC %in% installed_libs)]

cat("Libraries to be installed from Bioconductor: \n", paste(new_BioC, collapse = ", "), "\n\n")
    
# installation provided that 'new_BioC' vector is not empty
if (length(new_BioC)) {
    BiocManager::install(new_BioC, ask = FALSE)
    cat("INSTALLED ", length(new_BioC), " BioConductor ", BiocManager::version(), " libraries for ", R.version.string, "\n")
    cat(toString(new_BioC)) 
} else {
	message(paste(sep="", "BioConductor ", BiocManager::version(), " update not required"))
}

# remove needless variables
rm(installed_libs, libs_HAB_BioC, new_BioC)

# //////////////////////
# Final information ####

message("\n All required libraries for ", R.version.string, " in ", R.version$platform, " were installed\n")
