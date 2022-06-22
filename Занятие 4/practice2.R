# Time Series в R

# ---- Форматы ----

# ts (1 time - 1 value)
# zoo (NANs, Mon, Tue, Wed --- Sun)
# xts = ts + zoo + несколько значения для одного времени
some_ts = ts(seq(1, 100, 1), start = c(2000, 1), frequency = 12)

# ---- Чтение данных ----

library(tidyverse)
unemploy = read_csv("USUnemployment.csv")

# Работает плохо:
# ts(select(unemploy, -c(Year)), start = c(1948, 1), frequency = 12)

names(unemploy) = c("Year", seq(1:12))
unemploy %>% 
  gather(month, rate, '1':'12') %>% 
  mutate(month = as.numeric(month)) %>% 
  arrange(Year, month) -> unemploy

rate = ts(unemploy$rate, start = c(1948, 1), frequency = 12)

# ---- Шаг 1: Подбор лагов ----

install.packages("forecast")
library(forecast)

autoplot(rate)

ggAcf(rate) # автокор, q
ggPacf(rate) # частная автокор, p

# Оценка моделей
model1 = Arima(rate, order = c(6, 0, 5), include.constant = TRUE)
model2 = Arima(rate, order = c(7, 0, 6), include.constant = TRUE)

# Статистика:
# 1. Значимость коэффициентов (нормальность и некорр остатков)
# 2. AIC, AICc, BIC
model1$aic

auto.arima(rate, d = 0, seasonal = FALSE)

# ---- Шаг 2: Прогнозирование ----
forecast(model1, h = 12)
autoplot(forecast(model1, h = 12))

# Для веры в дов. интервалы нужно проверить:
# 1. Некоррелированность остатков
# 2. Нормальность остатков

# 1. Portemanteau test: H0: pho_1 = pho_2 = ... = pho_h = 0 H1: otherwise
Box.test(residuals(model1), lag = 12, fitdf = 11, type = "Ljung")
# p + q

# 2. Jarque-Bera: H0: 3 и 4 моменты соотв. моментам N(0, 1) H1: otherwise
library(tseries)
jarque.bera.test(residuals(model1))

# Качество предсказаний
train = window(rate, end = c(2018, 12))
test = window(rate, start = c(2019, 1))

autoplot(cbind(train, test), facets = TRUE)
model3 = Arima(train, order = c(5, 0, 6), include.constant = TRUE)
accuracy(forecast(model3, h = 12), test)

# Отступление: тестирование на белый шум
ar1 = arima.sim(model = list(ar = 0.5, order = c(1, 0, 0)), n = 1000) # y_t = 0.5y_t-1 + eps_t
autoplot(ar1)

wn = arima.sim(model = list(order = c(0, 0, 0)), n = 1000) # y_t = eps_t, 
autoplot(wn)

Box.test(rate, lag = 12, fitdf = 0, type = "Ljung")

# ---- Тренды ----

# Детерминированный: y_t = 3 + 4t + 0.5y_t-1 + ...
# Стохастический: y_t = 3 + y_t-1 + ...
# d = y_t - y_t-1
# dy_t = ... 0.3dy_t-2 ...

autoplot(rate)
autoplot(diff(rate))
autoplot(diff(rate, 2))

# ADF
# KPSS
