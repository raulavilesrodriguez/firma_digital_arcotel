library(tidyverse)
library(rvest)
library(httr)
library(readxl)
library(stringr)
library(purrr) # to split strings
library(hrbrthemes)
library(viridis) # pallette of colors
library(viridisLite) # pallette of colors
library(fs)

# definir carpeta principal
main_folder <- "./2020"

# Definir las nuevas carpetas de destino
dir_formulario_01 <- file.path(main_folder, "formularios_01")
dir_formulario_02 <- file.path(main_folder, "formularios_02")
dir_formulario_03 <- file.path(main_folder, "formularios_03")

# Crear las nuevas carpetas
dir_create(dir_formulario_01)
dir_create(dir_formulario_02)
dir_create(dir_formulario_03)


# Listar todas las subcarpetas en la carpeta principal
subfolders <- dir_ls(main_folder, type = "directory")
subfolders

# Función para mover archivos a las nuevas carpetas
mover_archivos <- function(subfolder, pattern, new_folder) {
  archivos <- dir_ls(subfolder, regexp = pattern, recurse = TRUE)
  file_move(archivos, new_folder)
}

# Mover los archivos a sus respectivas carpetas nuevas
for (subfolder in subfolders) {
  mover_archivos(subfolder, "FORMULARIO 01", dir_formulario_01)
  mover_archivos(subfolder, "FORMULARIO 02", dir_formulario_02)
  mover_archivos(subfolder, "FORMULARIO 03", dir_formulario_03)
}








