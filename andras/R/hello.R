#' Hitting the binance API to get the most recent price of Bitcoin in USD
#' @export
#' @param retried the number of retries previously done before the exponential backoff sleep
#' @importFrom binancer binance_coins_prices
get_bitcoin_price <- function() {
  tryCatch(
    binance_coins_prices()[symbol == "BTC", usd],

    error = function(e) {
      sys.sleep(1 + retried^2)
      get_bitcoin_price(retried = retried + 1)
    })
}

#' @export
#' @importFrom scales dollar
#' @param x amount
forint <- function(x) {
  dollar(x, prefix = '', suffix = 'Ft')
}
