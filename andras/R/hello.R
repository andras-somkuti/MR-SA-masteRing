#' @name forint
#' @title forint
#' @export
#' @importFrom scales dollar
#' @param x amount
forint <- function(x) {
  dollar(x, prefix = '', suffix = ' Ft')
}
