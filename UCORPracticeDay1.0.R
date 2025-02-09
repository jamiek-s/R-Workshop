3 + 5
12 / 7

weight_kg <- 55

(weight_kg <- 55)
weight_kg

# 2.2  * weight_kg
# weight_kg <-  57.5
# 2.2 * weight_kg
# 
# weight_lb <- 2.2 * weight_kg
# weight_kg <- 100
# weight_lb

# 5 + 5

mass <- 47.5              # 47.5 
age <-  122               # 122
mass <-  mass * 2.0       # 95
age <-  age - 20          # 102
mass_index <- mass/age    # 0.9313... 

weight_kg <- sqrt(10)
weight_kg

round(3.14159)
?round
round(3.14159, 2)

round(digits = 2, x = 3.14159)

round(3.14159, digits = 2)





weight_g <- c(50, 60, 65, 82)
weight_g

animals <- c("mouse", "rat", "dog")
animals

length(weight_g)
length(animals)

class(weight_g)
class(animals)

str(weight_g)
str(animals)

weight_g <- c(weight_g, 90)
weight_g <- c(30, weight_g)
weight_g




num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE )
tricky <- c(1, 2, 3, "4")

class(num_char)
class(num_logical)
class(char_logical)
class(tricky)

combined_logical <- c(num_logical, char_logical)
combined_logical
class(combined_logical)

animals <- c("mouse", "rat", "dog", "cat")
animals[2]
animals[c(3, 2)]

more_animals <- animals[c(1, 2, 3, 2, 1, 4)]
more_animals

weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, FALSE, TRUE, TRUE)]

weight_g > 50

weight_g[weight_g > 50]

weight_g[weight_g > 30 & weight_g < 50]
weight_g[weight_g <= 30 | weight_g == 55]

weight_g[weight_g >= 30 & weight_g == 21]

animals <- c("mouse", "rat", "dog", "cat", "cat")
animals[animals == "cat" | animals == "rat"]

animals[animals %in% c("rat", "cat", "dog", "duck", "goat", "bird", "fish")]

"four" > "five"




heights <- c(2, 4, 4, NA, 6)
mean(height)
max(height)

mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

heights[!is.na(heights)]
na.omit(heights)




heights <- c(63, 69, 60, 65, NA, 68, 61, 70)
heights_no_na <- heights[!is.na(heights)]
heights_no_na <- na.omit(heights)
median(heights, na.rm = TRUE)
heights_above_67 <- heights_no_na[heights_no_na > 67]
length(heights)




install.packages("tidyverse")

library(tidyverse)

read_csv

surveys <- read_csv("data_raw/portal_data_joined.csv")

surveys
print(surveys, n = 50)

head(surveys)

view(surveys)

tail(surveys)

str(surveys)

dim(surveys)
nrow(surveys)
ncol(surveys)

names(surveys)
rownames(surveys)

summary(surveys)




surveys[1,1]
surveys[1,6]

surveys[ ,1]
surveys[1, ]
surveys[1]


surveys[c(1, 2, 3), c(5,6)]

surveys[1:3, 5:6]

head_surveys <- surveys[1:6, ]

surveys[[1]]

surveys[[1,1]]

surveys[, -1]

surveys[-(7:nrow(surveys)), ]

surveys["species_id"]
surveys[, "species_id"]

surveys[["species_id"]]

surveys$species_id




surveys_200 <- surveys[200, ]
n_rows <- nrow(surveys)
surveys_last <- surveys[n_rows, ]
surveys_middle <- surveys[n_rows / 2, ]

surveys_head <- surveys[-(7:n_rows), ]




