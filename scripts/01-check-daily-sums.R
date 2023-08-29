# Initial QA/QC script
library(tidyverse)
library(janitor)

dat <- read_csv("data_raw/saguaro_data_2015.csv") %>%
  janitor::clean_names() %>%
  mutate(date = mdy(date))

str(dat)

length(unique(dat$date))

daily_total <- dat %>%
  group_by(date) %>%
  summarize(total_blooms = sum(number_blooms))


write_csv(daily_total, "data_raw/daily_sums_2015.csv")

### Combine datasets so far
ds14 <- read_csv("data_raw/daily_sums_2014.csv")
ds15 <- read_csv("data_raw/daily_sums_2015.csv")

comb <- ds14 |> 
  bind_rows(ds15)

comb |> 
  mutate(year = lubridate::year(date)) |> 
ggplot(aes(x = date, y = total_blooms)) + 
  geom_point() +
  facet_wrap(~year, scales = "free",
             ncol = 1)
