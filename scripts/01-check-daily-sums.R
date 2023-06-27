# Initial QA/QC script
library(tidyverse)
library(janitor)

dat <- read_csv("data_raw/saguaro_flowering_2014.csv") %>%
  janitor::clean_names() %>%
  mutate(date = mdy(date))

str(dat)

length(unique(dat$date))

daily_total <- dat %>%
  group_by(date) %>%
  summarize(total_blooms = sum(number_blooms))
