# What are the top five Canadian provinces with the most recorded COVID-19
# cases?

library(tidyverse)

data <- read_csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv")

data |>
  # Filter these out as they are not provinces!
  filter(prname != "Canada" & prname != "Repatriated travellers") |>
  transform(totalcases = as.numeric(totalcases)) |>
  group_by(prname) |>
  summarize(cases = max(totalcases, na.rm = TRUE)) |>
  slice_head(n = 5) |>
  rename_at('prname',  ~ 'Province') |>
  rename_at('cases',  ~ 'Cases')