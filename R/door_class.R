library(R6)

#' @title Door class
#' 
#' The Door class in Monty Hall settings. W
#' 
Door <- R6Class("Door", list(
  car = 0,
  number = NULL,
  probability = 1/3,
  initialize = function(number, probability) {
    self$number = number
    self$probability = probability
  },
  close = function() {
    rand_num = runif(1)
    if (rand_num < self$probability) 
      self$car = 1
  }
))

# door1 <- Door$new(1, probability = 1/3)
# door1$close()
# door1$car

