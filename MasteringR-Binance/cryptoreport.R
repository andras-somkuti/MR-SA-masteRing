library(binancer)
library(jsonlite)
library(logger)
library(checkmate)
log_threshold(TRACE)


BITCOINS <- 0.42
log_info("Number of bitcoins: [BITCOINS]") # GLUE

get_bitcoin_price <- function() {
  tryCatch(
    binance_coins_prices()[symbol == "BTC", usd],
    error = function(e) get_bitcoin_price())
}

btcusdt <- get_bitcoin_price()
log_info('The value of 1 Boitcoin in USD: {btcusdt}')

assert_number(btcusdt, lower =1000)

usdhuf <- fromJSON("https://api.exchangeratesapi.io/latest?base=USD&symbols=HUF")$rates$HUF
log_info("The value of 1 USD in HUF: {usdhuf}")
assert_number(usdhuf, lower = 250, upper = 500)

log_eval(BITCOINS * btcusdt * usdhuf) 
