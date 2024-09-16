# Para usuarios de Linux ####
#
# Antes de instalar estos paquetes, conviene instalar tres que son específicos de linux
# y que, si no los tienes, no va a funcionar. Se instalan desde `bash` en **Ubuntu**, en los siguientes pasos:
#
# Para mantener actualizados todos los paquetes en un linux basado en Debian, como Ubutuntu. 
# Más información en <https://www.freecodecamp.org/news/sudo-apt-get-update-vs-upgrade-what-is-the-difference/>
# `$ sudo apt-get update` 
#
# Para ver cuáles son los que se han actualizado, usa
# `$ sudo apt-get upgrade` 
#
# Para instalar el R más completo, incluso con librerías a compilar. 
# Más info en <https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html>
# `$ sudo apt-get install r-base r-base-dev` 
#
# Instalación de las dependencias principales
# `$ sudo apt-get install libblas-dev liblapack-dev libgfortran-8-dev gfortran`
# 
# Instala estas otras librerías que podrían requerir algunos paquetes de R
# `$ sudo apt-get install libatlas3-base libssl-dev libclang-14-dev libclang-dev libcurl4-openssl-dev`
# `$ sudo apt-get install libzmq3-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev` 
# `$ sudo apt-get install libtiff5-dev libjpeg-dev build-essential libfontconfig1-dev`
# `$ sudo apt-get install libnlopt-dev libxml2-dev libpoppler-cpp-dev cmake`
#
# Optativamente, puedes instalar también estas otras librerías para java y otros lenguajes:
# `$ sudo apt-get install -y r-cran-xml r-cran-rjava openjdk-7-* libgdal-dev libproj-dev libgsl-dev`
# `$ sudo apt-get install -y xml2 default-jre default-jdk mesa-common-dev libglu1-mesa-dev freeglut3-dev`
# `$ sudo apt-get install -y libx11-dev r-cran-rgl r-cran-rglpk r-cran-rsymphony r-cran-plyr`
# `$ sudo apt-get install -y  r-cran-reshape  r-cran-reshape2 r-cran-rmysql`
#
# Si no se han conseguido instalar todas las dependencias, corrígelo con 
# `$ sudo apt --fix-broken install`

# Si al instalar los paquetes de R posteriores obtienes un mensaje de error de tipo 
#    /usr/bin/ld: cannot find -lgfortran
# habrás de asegurarte que esa librería está en el directorio /usr/bin/ con el siguiente comando de bash para crear un enlace simbólico en dicho directorio:
# `$ sudo ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.5 /usr/lib/libgfortran.so`
#
# If you want to change the location of non-base libraries installes, you can change globally the forder with
# 
# `> .libPaths("path-to-the-new-folder")`
#
# or you can install only certain libraries in another folder using the `lib` parameter of `install.packages` as
# 
# `> install.packages(new_libs, dependencies = TRUE, lib = "path-to-the-new-folder")`
# 

# //////////////////////////
# Cómo generar un HTML ####
#
# Con este script puedes generar un HTML de varias maneras:
# 1) pulsando el botón de la libretita  denominado "Compile Report" de RStudio 
# 2) Con el atajo de teclado MAY-CMD-K (mac) o MAY-CTRL-K (windows o linux)
# 3) Con el comando rmarkdown::render("install-libraries_GISa-HAB.R"), siempre que ya tengas instalada la librería 'rmarkdown'
#
# Pero igual te da mensajes de error o se queda pillado, así que mejor no lo intentes por ahora.
#


# ///////////////////////////
# Paquetes ya instalados ####
# 
# More details <https://www.r-bloggers.com/an-efficient-way-to-install-and-load-r-packages/>

installed_libs <- rownames(installed.packages())
cat("Tienes instaladas ", length(installed_libs), " paquetes de R en tu ordenador \n")
cat("Las nuevas librerías se instalarán en el directorio \n")
.libPaths()


# ////////////////////////////////////
# Instalación de paquetes de CRAN ####
# 
# Creamos un vector con el nombre de los paquetes necesarios para el curso


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

# Comparar las librerías instaladas con las librerías a instalar para descargar solo las que necesiten instalación
new_libs_CRAN <- libs_HAB_CRAN[!(libs_HAB_CRAN %in% installed_libs)]

cat(length(new_libs_CRAN), " libraries to be installed from CRAN: \n", paste(new_libs_CRAN, collapse = ", "), "\n\n")


# Instalación propiamente dicha de las librerías que haya en el vector `new_libs_CRAN`, 
# siempre que este no esté vacío (señal de que ya están todas instaladas), 
# que se mira con `length(new_libs_CRAN) > 0`.

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
# Instalación de paquetes de Bioconductor ####
# 
# Encontrarás más información al respecto en <https://www.bioconductor.org/install/>. 
# Lo primero será comprobar qué paquetes son necesarios y no están todavía instalados 
# (o sea, ausentes en el vector `installed_libs`). De paso, instalaremos el paquete 
# `BiocManager` necesario para instalar estas librerías.

cat("\n*** Checking Bioconductor libraries that must be installed  ***\n\n")

# Install last version of 'BiocManager' before installing any BioConductor library
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
# BiocManager::install(version = "3.16") # for R > 4.3
BiocManager::install(ask = FALSE)

# Si usar un R más antiguo, recibirás un mensaje de error del tipo
# 
# Bioconductor version '3.18' is out-of-date; the current release version '3.19' is available with R version '4.4'; see
# https://bioconductor.org/install
# Error: Bioconductor version '3.17' requires R version '4.3'; 
# use `BiocManager::install(version = '3.16')` with R version 4.2; see https://bioconductor.org/install
# Error: Bioconductor version '3.16' requires R version '4.2'; use `version = '3.18'` with R version 4.3; see
# https://bioconductor.org/install
# 
# En tal caso, modifica el código para la versión que te recomiendan, que es la compatible con tu R. También puedes hacer una instalación básica con:
# 
# > BiocManager::install(ask = FALSE)

# Nuevo vector con las librerías de Bioconductor que nos harán falta.
libs_HAB_BioC <- c("edgeR", 
               "limma", 
               "RColorBrewer",
               "phyloseq",
               "chromPlot",
               "pathview",
               "Biostrings")

# Obtenemos la lista de las librerías que hay que instalar, como antes, siempre que haya algo que instalar
nuevos_BioC <- libs_HAB_BioC[!(libs_HAB_BioC %in% installed_libs)]

cat("Libraries to be installed from Bioconductor: \n", paste(nuevos_BioC, collapse = ", "), "\n\n")
    
# installation provided that 'nuevos_BioC' vector is not empty
if (length(nuevos_BioC)) {
    BiocManager::install(nuevos_BioC, ask = FALSE)
    cat("INSTALLED ", length(nuevos_BioC), " BioConductor ", BiocManager::version(), " libraries for ", R.version.string, "\n")
    cat(toString(nuevos_BioC)) 
} else {
	message(paste(sep="", "BioConductor ", BiocManager::version(), " update not required"))
}

# remove needless variables
rm(installed_libs, libs_HAB_BioC, nuevos_BioC)

# //////////////////////
# Información final ####

message("\n All required ibraries for ", R.version.string, " in ", R.version$platform, " were installed\n")
