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
library(stringi) # to remove accents

wrangling.form2 <- function(form1){
  form1 <- form1[12:nrow(form1),]
  colnames(form1) <- form1[1,]
  colnames(form1)[3] <- 'fecha'
  colnames(form1)[4] <- 'estado'
  form1 <- form1[-1,]
}

xlsx_files2 <- dir_ls('./2020/formularios_02', regexp = "\\.xlsx$")

combined_data2 <- xlsx_files2 |>
  lapply(function(file) {
    data <- read_xlsx(file)
    wrangled_data <- wrangling.form2(data)
    return(wrangled_data)
  }) |>
  bind_rows()

combined_data2 <- combined_data2 |> mutate(MES = toupper(MES))
combined_data2 <- combined_data2 |> mutate(MES = stri_trans_general(MES, "Latin-ASCII"))
combined_data2 <- combined_data2 |> mutate(MES = str_squish(MES))

combined_data2$fecha <- as.numeric(combined_data2$fecha)
combined_data2$fecha <- as.Date(combined_data2$fecha, origin = "1899-12-30")

resumen_form2 <- combined_data2 |> group_by(estado, MES) |>
  summarise(
    conteo = n()
  ) 
resumen_form2


resumen_form2.1 <- combined_data2 |> group_by(estado) |>
  summarise(
    conteo = n()
  ) 

write_xlsx(resumen_form2, './resultados_2020/resumen_formulario2.xlsx')
