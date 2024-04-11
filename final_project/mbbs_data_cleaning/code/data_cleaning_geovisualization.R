## Processing MBBS data to produce map of results!

## First load in all sheets .RDA files in MBBS folder

# load libraries
library(dplyr)
library(tidyr)

# FOR COUNTY LEVEL DATA MAPS
# Take each county and find unique combos of common name, sci name, and year
# Find the total counts for each year for each species

mbbs_chat_sorted <- mbbs_chatham %>%
     group_by(common_name, sci_name, year) %>%
    summarize(count = sum(count)) %>%
    ungroup()

mbbs_durham_sorted <-  mbbs_durham %>%
  group_by(common_name, sci_name, year) %>%
  summarize(count = sum(count)) %>%
  ungroup()

mbbs_orange_sorted <- mbbs_orange %>%
  group_by(common_name, sci_name, year) %>%
  summarize(count = sum(count)) %>%
  ungroup()

# get rid of sp. counts

mbbs_chat_sorted <- mbbs_chat_sorted %>%
  filter(!grepl("sp.", sci_name)) %>%
  filter(!grepl("sp.", common_name))

mbbs_durham_sorted <- mbbs_durham_sorted %>%
  filter(!grepl("sp.", sci_name)) %>%
  filter(!grepl("sp.", common_name))

mbbs_orange_sorted <- mbbs_orange_sorted %>%
  filter(!grepl("sp.", sci_name)) %>%
  filter(!grepl("sp.", common_name))

mbbs_chat_sorted$County <- c("Chatham")
mbbs_orange_sorted$County <- c("Orange")
mbbs_durham_sorted$County <- c("Durham")

mbbs_sorted <- rbind(mbbs_chat_sorted, mbbs_orange_sorted, mbbs_durham_sorted)

mbbs_sorted$Species_Scientific <- paste(mbbs_sorted$common_name, " (", mbbs_sorted$sci_name, ")", sep ="")


# write out CSVs of data

write.csv(mbbs_chat_sorted, "../CSV/mbbs_chatham.csv")
write.csv(mbbs_orange_sorted, "../CSV/mbbs_orange.csv")
write.csv(mbbs_durham_sorted, "../CSV/mbbs_durham.csv")
write.csv(mbbs_sorted, "../CSV/mbbs_sorted.csv")
