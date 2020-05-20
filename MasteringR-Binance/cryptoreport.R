library(binancer)
library(jsonlite)
library(logger)
library(checkmate)
library(andras)
library(tidyverse)
log_threshold(TRACE)

btcusdt <- binance_klines('BTCUSDT', interval = '1d', limit = 30)
BITCOINS <- 0.42
log_info("Number of bitcoins: [BITCOINS]") # GLUE

library(httr)

usdhuf <- GET("https://api.exchangeratesapi.io/history",
              query = list(
                start_at = Sys.Date() -30,
                end_at = Sys.Date(),
                base = "USD",
                symbols = "HUF"
              ))
usdhuf <- content(usdhuf)$rates

library(data.table)

usdhuf <- data.table(date = as.Date(names(usdhuf)),
                     usdhuf = unlist(usdhuf))[order(date)]

balance <- btcusdt[, .(date = as.Date(close_time),
                       btcusdt = close)]

merge(balance, usdhuf, all.x = TRUE)

balance[, value = BITCOINS * btchuf]
  


btcusdt <- get_bitcoin_price()
log_info('The value of 1 Boitcoin in USD: {btcusdt}')

assert_number(btcusdt, lower =1000)

usdhuf <- fromJSON("https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF")$rates$HUF
log_info("The value of 1 USD in HUF: {usdhuf}")
assert_number(usdhuf, lower = 250, upper = 500)

log_eval(BITCOINS * btcusdt * usdhuf) 
