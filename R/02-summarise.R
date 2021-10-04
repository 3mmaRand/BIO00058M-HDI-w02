# summarise the index by country
hdi_summary <- hdi_no_na %>%
  group_by(country) %>%
  summarise(mean_index = mean(index),
            n = length(index),
            sd_index = sd(index),
            se_index = sd_index/sqrt(n))

