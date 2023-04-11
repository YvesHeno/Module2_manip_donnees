library(tidyverse)
library(mapview)
library(sf)
library(readr)

# qqs fonctions utiles ----
#facteur simple
monfacteur <- factor(c('A','B','A','C'))
#facteur ordonné
monfacteuro <- factor(c('A','A','B','A','C'),ordered=T)
monfacteuro
#exporter en rdata
save(monfacteur,monfacteuro,file='output/donnees_sauvees.RData')
#exporter en XLSX"
#openxlsx::write.xlsx(montableau,file ...)
#export en csv
#write.table
#données geof
#sf::write_sf()


#charge table_bufo ----
load(file="Data/oison/table_bufo.Rdata")
oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv")
View(oison_taxon,"oison taxon")

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(nom_vernaculaire,nom_scientifique,nom)
View(oison_taxon,"oison taxon sélectionné")

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(observation_id:date) %>% view()

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(observation_id:date) %>%
  select(-date) %>% #exclusion
  view()

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(!(observation_id:date)) %>%
  view() #exclusion d'une plage

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(c(observation_id,date)) %>%
  view() #exclusion d'une plage



