# assumes you have loaded the tidyverse

# I have used janitor::clean_names() to ensure the column names are lowercase without spaces and that the year columns have an x in front of them. both these mean I will not need to use backticks around column names such as hdi$`HDI Rank (2018)` and hdi$`1990`
file <- "data-raw/Human-development-index.csv"
hdi <- read_csv(file) %>%
  janitor::clean_names()

# the format of the data would be improved by having a single observation (i.e., index) per row with other columns giving the country, year and 2018 rank.
# this can be done using pivot_longer()
hdi <- hdi %>%
  pivot_longer(names_to = "year",
               values_to = "index",
               cols = -c(hdi_rank_2018, country))
# remove the x from the year and make it numeric
hdi <- hdi %>%
  mutate(year =  str_replace(year, "x", "") %>% as.numeric())


# Filter the dataset to exclude the missing observations.
hdi_no_na <-  hdi %>%
  filter(!is.na(index))


