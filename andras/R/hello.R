#' Hitting the binance API to get the most recent price of Bitcoin in USD
#' @export
#' @param retried the number of retries previously done before the exponential backoff sleep
#' @importFrom binancer binance_coins_prices
#' @import data.table
get_bitcoin_price <- function(retried = 0) {
  tryCatch(
    binance_coins_prices()[symbol == "BTC", usd],

    error = function(e) {
      Sys.sleep(1 + retried^2)
      # get_bitcoin_price(retried = retried + 1)
      return(e)
    })
}

#' @export
#' @rdname get_bitcoin_price
#' @importFrom scales dollar
#' @param x amount
forint <- function(x) {
  dollar(x, prefix = '', suffix = 'Ft')
}
#' @rdname get_bitcoin_price

#' #' @export
#' #' @param target target currency
#' #' @param base base currency
#' #' @param days number of days from today for historical conversion rates
#' #' @importFrom httr GET
#'
#'
#' convert_currency <- function(target, base, days) {
#'   response <- httr::GET(
#'     'https://api.exchangeratesapi.io/history',
#'     query = list(
#'       start_at = Sys.Date() - days,
#'       end_at   = Sys.Date(),
#'       base     = base,
#'       symbols  = target
#'     ))
#'
#'   exchange_rates <- content(response)$rates
#'
#'   tmp <- data.table(
#'     date = as.Date(names(exchange_rates)),
#'     pair = as.numeric(unlist(exchange_rates)))
#'
#'   colnames(tmp)[2] <- paste0(base, target)
#'   tmp
#' }
#'
