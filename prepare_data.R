# данные взяты из
# https://fedstat.ru/indicator/33553
# предварительно приведены в обычную табличку :)

library(rio)
library(tidyverse)
library(forecast)
library(tsibble)
library(stringr)
library(skimr)
library(lubridate)

d = import("~/Downloads/data(2).xls", skip = 2)
glimpse(d)

colnames(d)[1:3] = c("region", "unit", "period")
glimpse(d)

d4 = select(d, -unit) %>% filter(nchar(period) < 14)
glimpse(d4)
head(d4, 13)
tail(d4, 13)

d6 = mutate(d4, month= rep(1:12, nrow(d4) / 12))
glimpse(d6)

d7 = select(d6, -period)

d8 = pivot_longer(d7, cols = `2006`:`2020`,
                  names_to = "year", values_to = "marriages")
glimpse(d8)

d9 = mutate(d8, date = ymd(paste0(year, "-", month, "-01")))
glimpse(d9)

final = select(d9, -year, -month)
glimpse(final)

export(final, "monthly_marriages_2020.csv")



