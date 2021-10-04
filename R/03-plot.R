# pipeline that takes the `hdi` dataframe through to the plot
# without creating any intermediate data structures.

hdi %>%
  filter(!is.na(index)) %>%
  group_by(country) %>%
  summarise(mean_index = mean(index),
            se_index = sd(index)/sqrt(length(index))) %>%
  filter(rank(mean_index) < 11) %>%
  ggplot() +
  geom_point(aes(x = country,
                 y = mean_index)) +
  geom_errorbar(aes(x = country,
                    ymin = mean_index - se_index,
                    ymax = mean_index + se_index)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()
