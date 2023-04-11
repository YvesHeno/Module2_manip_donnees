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


#select ----
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

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(starts_with(("nom"))) %>%
  view()


oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(ends_with(("id"))) %>%
  view()

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(contains("recherche")) %>%
  view()

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(contains("recherche")|contains("obs")) %>%
  view()

#avec la fct any_of
vecteur_nom <- c("nom_vernaculaire","nom_PMCC","date")
oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::select(any_of(vecteur_nom)) %>%
  view()

#pour voir autres cheat sheet dplyr

#select(where(is.numeric))

#filter ----
oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::filter(nom_scientifique=="Canis lupus") %>%
  dplyr::select(observation_id:nom_vernaculaire) %>%
  view()

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::filter(email=='camille.riviere@ofb.gouv.fr' | email=='didier.pujo@ofb.gouv.fr') %>%
  view()

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  dplyr::filter(presence=='Absent' & !is.na(nombre_individu)) %>%
  select(observation_id,
         date,
         nom_scientifique,
         nom_vernaculaire,
         presence,
         nombre_individu) %>%
  filter(nombre_individu>0) %>% view()



# utilisation de mutate ----
oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
  select(observation_id,nom:email) %>%
  mutate(nom_complet_observateur=paste(nom,prenom,sep=', '),addition=1+10,racine_carree=sqrt(observation_id))%>% view()

oison_taxon <- readr::read_csv(file="Data/oison/oison_taxon.csv") %>%
dplyr::select(nom_scientifique,nom_vernaculaire,nombre_individu) %>%
  dplyr::filter(nom_scientifique=='Bufo bufo' | nom_scientifique=='Elona quimper') %>%
  group_by(nom_scientifique) %>%
  summarise(nb_total_oison=sum(nombre_individu,na.rm=T),
            nb_max_oison=max(nombre_individu,na.rm=T)) %>% view()

