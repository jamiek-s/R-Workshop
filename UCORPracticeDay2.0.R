surveys$sex <- factor(surveys$sex)
summary(surveys$sex)
levels(surveys$sex)
nlevels(surveys$sex)
levels(surveys$sex)[3] <- "undetermined"
plot(surveys$sex)

vec <- factor(c("high", "medium", "low", "high"))
levels(vec)
vec <- factor (vec, levels = c ("low",
                                "medium",
                                "high"))
levels (vec)

# Ctrl + Shift + R

# Dates -------------------------------------------------------------------

my_date <-ymd("2015-01-01")

surveys$date <- ymd(paste(surveys$year, 
                          surveys$month,
                          surveys$day,
                          sep = "-"))

# Ctrl + Shift + R


# Data manipulation -------------------------------------------------------

# dplyr & tidyr

surveys <- read_csv("data_raw/portal_data_joined.csv")

# keep columns
select(surveys, plot_id, species_id)

# delete columns
select(surveys, -plot_id, -species_id)

# keep only 1995
filter(surveys, year == 1995)

# PIPE operator %>% - Ctrl + Shift + M
surveys2 <- filter(surveys, weight < 5)
surveys3 <- select(surveys2, species_id, sex, weight)
rm(surveys2, surveys3)

surveys_small <- surveys %>% 
  filter(weight <5) %>% 
  select(species_id, sex, weight)

surv_1995 <- surveys %>% 
  filter(year <= 1995) %>% 
  select(year, sex, weight)

surv_wt <- surveys %>% 
  # filter(is.na(weight)) %>% 
  filter(is.na(weight)) %>%
  mutate(weight_kg = weight / 1000)

surveys_hindfoot <- surveys %>% 
  mutate(hindfoot_cm = hindfoot_length / 10) %>% 
  filter(!is.na (hindfoot_cm),
         hindfoot_cm < 3) %>% 
  select(species_id, hindfoot_cm)
# range(surveys_hindfoot$hindfoot_cm)

surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  tail()

aggregated <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight), 
            min_weight = min(weight)) %>%
  filter(!is.na(sex)) %>% 
  arrange(desc(min_weight))

surveys %>% 
  group_by(sex) %>%
  summarize(count = n())

surveys %>% 
  count(sex, species) %>% 
  arrange(species, -n)

surveys %>% 
  count(plot_type)

aggregated <- surveys %>% 
  filter(is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarize(mean_hindfoot_length = mean(hindfoot_length),
            min_hindfoot_length = min(hindfoot_length),
            max_hindfoot_length = max(hindfoot_length),
            n = n())

surveys_gw <- surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(plot_id, genus) %>% 
  summarize(mean_weight = mean(weight))

str(surveys_gw)

surveys_wider <- surveys_gw %>%
  pivot_wider(names_from = genus, values_from = mean_weight)
