library(tidyverse)
library(dslabs)

##
## dslabs is providede for this edX course and contains several datasets data()
##

data(murders)

murders %>%
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label()
