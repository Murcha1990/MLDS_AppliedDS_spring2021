# EDA

# ==== Подгрузка пакета ====

install.packages("tidyverse") # ggplot2, dplyr, readr, ...
library(tidyverse)

# ==== Датасеты ====

df = LifeCycleSavings # встроенный
head(df)
is.na(df)

# ==== ggplot2 ====

ggplot(data = df) + geom_point(mapping = aes(x = dpi, y = sr, color = pop75))

# ==== dplyr ====

filter(df, pop75 < 3)
filter(df, sr > 3 | sr < 5)

select(df, sr, pop15)

# Ещё в dplyr: arrange, mutate, summarise, group_by

