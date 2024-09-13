# Actualizar paquetes disponibles y sus versiones
sudo apt update

# Actualizar los paquetes instalados en el sistema a sus versiones más recientes
sudo apt -y upgrade

# Para instalar el R más completo, incluso con librerías a compilar. 
# Más info en <https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html>
`$ sudo apt-get install r-base r-base-dev` 
#sudo apt -y install r-base

# Asegurarse de que wget esté instalado para descargar archivos desde la web
sudo apt -y install wget

# Descargar el archivo .deb de RStudio desde la URL proporcionada
wget https://download1.rstudio.org/electron/focal/amd64/rstudio-2024.04.2-764-amd64.deb

# Instalar el archivo .deb descargado de RStudio
sudo apt install -f ./rstudio-2024.04.2-764-amd64.deb

# Lanzar RStudio desde el terminal
rstudio


##### Paquetes que usare en herramientas 

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
