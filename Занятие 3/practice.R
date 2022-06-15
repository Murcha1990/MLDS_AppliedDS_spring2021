# Практика по временным рядам (начало)

library(tidyverse)

unemploy = read_csv("USUnemployment.csv")
names(unemploy) = c("Year", seq(1, 12))

unemploy %>% 
  gather(month, rate, "1":"12") %>%
  mutate(month = as.numeric(month)) %>% 
  arrange(Year, month) -> unemploy
