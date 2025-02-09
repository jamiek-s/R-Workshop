library (tidyverse)
surveys <- read_csv ("data_raw/portal_data_joined.csv")

surveys_gw <- surveys %>%
  filter(!is.na (weight)) %>%
  group_by(plot_id,genus) %>%
  summarize(mean_weight = mean(weight))

surveys_wide <- surveys_gw %>%
  pivot_wider (names_from = genus,
               values_from = mean_weight)

surveys_long <- surveys_wide %>%
  pivot_longer(names_to = "genus",
               values_to = "mean weight",
               cols= -plot_id)

surveys_complete <- surveys %>% 
  filter(!is.na(weight),
         !is.na (hindfoot_length),
         !is.na (sex))

species_counts <- surveys_complete %>% 
  count(species_id) %>% 
  filter(n >= 50)

surveys_complete <- surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)

write_csv(surveys_complete, file = "data_complete.csv")

ggplot(data = surveys_complete,
       mapping = aes(x = weight, 
                     y = hindfoot_length)) +
  geom_point(alpha = 0.1,
             aes(color = species_id))

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, 
                     y = weight)) +
  geom_point(alpha = 0.1,
             aes(color = plot_type))

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, 
                     y = weight)) + 
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_boxplot(outlier.shape = NA) 

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, 
                     y = weight)) + 
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_violin(outlier.shape = NA) 

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, 
                     y = weight)) + 
  scale_y_log10() +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_boxplot(outlier.shape = NA) 

ggplot(data = surveys_complete,
       mapping = aes(x = species_id, 
                     y = hindfoot_length)) + 
  geom_jitter(alpha = 0.3,
              aes(color = factor(plot_id))) +
  geom_boxplot(outlier.shape = NA)

class(surveys_complete$plot_id)

yearly_counts <- surveys_complete %>% 
  count(year, genus)

ggplot(data = yearly_counts,
       aes(x = year,
           y = n,
           color = genus)) +
  geom_line()

yearly_counts %>% 
  ggplot(mapping = aes (x = year,
                        y = n,
                        color = genus)) +
  geom_line()

surveys_complete %>% 
  count(year, genus) %>% 
  ggplot(mapping = aes(x = year,
                       y = n,
                       color = genus)) +
  geom_line()

yearly_counts_graph

ggpot(data = yearly_counts,
      aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

yearly_sex_counts <- surveys_complete %>% 
  count(year, genus, sex)

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(sex), 
             cols = vars(genus))

ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(cols = vars(genus))



# # Themes & Customization ------------------------------------------------

ggplot(data = yearly_sex_counts,
       aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  theme_bw() +
  labs(x = "Year of Observation",
       y = "Number of Individuals",
       title = "Observed genera through time",
       color = "Sex") +
  theme(text = element_text(size = 16),
        axis.text.x = element_text(angle = 90, 
                                   size = 12, 
                                   color = "blue"),
        axis.text.y = element_text(color = "green"),
        strip.text = element_text(face = "italic"))


# Arranging plot ----------------------------------------------------------

library(patchwork)

plot_weight <- ggplot(data = surveys_complete,
                      aes(x = species_id,
                          y = weight)) +
  geom_boxplot() +
  labs(x = "Species", 
       y = expression(log[10](Weight))) +
  scale_y_log10()

plot_weight

plot_count <- ggplot(data = yearly_counts,
                     aes(x = year, y = n, color = genus)) +
  geom_line() +
  labs(x = "Year", y = "Abundance")

plot_count

plot_combined <-  plot_weight / plot_count + plot_layout(height = c(3,2))
plot_combined

ggsave("plot_combined.png", plot_combined, width = 10, dpi = 300)
