### Merging published metadata sheets for EXCHANGE-S data compilation 

#download metadata folder from ESS-DIVE: https://data.ess-dive.lbl.gov/view/doi%3A10.15485%2F1960313

library(tidyverse)
library(googledrive)
getwd()

site_level_metadata <- read_csv("./data-do-not-commit/ec1_metadata_v2/ec1_metadata_kitlevel.csv")

transect_level_metadata <- read_csv("./data-do-not-commit/ec1_metadata_v2/ec1_metadata_collectionlevel.csv")

all_metadata <- transect_level_metadata %>%
  full_join(site_level_metadata, by="kit_id") %>%
  select(kit_id, site_name, state, region, transect_location, latitude, longitude, collection_date, collection_time_utc) %>%
  drop_na()

site_level_metadata_clean <- site_level_metadata %>%
  select(kit_id, site_name, state, region, collection_date)

## Export metadata to EXCHANGE-S

all_metadata %>% write.csv(paste0("./ec1_kit_metadata_clean_", Sys.Date(), ".csv"), row.names = FALSE)

directory = "https://drive.google.com/drive/folders/1MaLe3ZTGbC_Qm0R9aEGoLsb6H2CzDOOJ"

drive_upload(media = paste0("./ec1_kit_metadata_clean_", Sys.Date(), ".csv"), name= paste0("ec1_kit_metadata_clean_", Sys.Date(), ".csv"), path = directory )

file.remove(paste0("./ec1_kit_metadata_clean_", Sys.Date(), ".csv"))

#

site_level_metadata_clean %>% write.csv(paste0("./ec1_site_level_metadata_clean_", Sys.Date(), ".csv"), row.names = FALSE)

directory = "https://drive.google.com/drive/folders/1MaLe3ZTGbC_Qm0R9aEGoLsb6H2CzDOOJ"

drive_upload(media = paste0("./ec1_site_level_metadata_clean_", Sys.Date(), ".csv"), name= paste0("ec1_site_level_metadata_clean_", Sys.Date(), ".csv"), path = directory )

file.remove(paste0("./ec1_site_level_metadata_clean_", Sys.Date(), ".csv"))
