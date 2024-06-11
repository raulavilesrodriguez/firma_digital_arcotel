library(tidyverse)
library(rvest)
library(httr)
library(readxl)
library(writexl)
library(stringr)
library(purrr) # to split strings
library(hrbrthemes)
library(viridis) # pallette of colors
library(viridisLite) # pallette of colors
library(fs)

form1.prueba <- read_excel('./2020/formularios_01/FORMULARIO 01- RPEC-CO ABRIL 2020.xlsx')


wrangling.form1 <- function(form1){
  form1 <- form1[12:nrow(form1),]
  colnames(form1) <- form1[1,]
  colnames(form1)[3] <- 'fecha'
  colnames(form1)[4] <- 'trámite'
  form1 <- form1[-1,]
  
}

form1.prueba <- wrangling.form1(form1.prueba)

xlsx_files1 <- dir_ls('./2020/formularios_01', regexp = "\\.xlsx$")

combined_data <- xlsx_files1 |>
  lapply(function(file) {
    data <- read_xlsx(file)
    wrangled_data <- wrangling.form1(data)
    return(wrangled_data)
  }) |>
  bind_rows()

combined_data <- combined_data |> mutate(MES = toupper(MES))
combined_data <- combined_data |> mutate(MES = stri_trans_general(MES, "Latin-ASCII"))
combined_data <- combined_data |> mutate(MES = str_squish(MES))

combined_data$fecha <- as.numeric(combined_data$fecha)
combined_data$fecha <- as.Date(combined_data$fecha, origin = "1899-12-30")


resumen_form1 <- combined_data |> group_by(trámite, MES) |>
  summarise(
    conteo = n()
  ) 
resumen_form1

write_xlsx(resumen_form1, './resultados_2020/resumen_formulario1.xlsx')
