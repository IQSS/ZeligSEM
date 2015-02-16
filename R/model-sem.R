zsem <- setRefClass("Zelig-sem",
                        contains = "Zelig")

zlavaan <- function(formula, ...) lavaan::lavaan(model = formula, ...)

zsem$methods(
  initialize = function() {
    callSuper()
    .self$name <- "sem"
    .self$fn <- zlavaan
    .self$authors <- "Christine Choirat"
    .self$description <- "Structural Equation Model"
    .self$year <- 2015
    .self$category <- "continuous"
    .self$wrapper <- "sem"
  }
)

zsem$methods(
  zelig = function(formula, data, ..., weights = NULL, by = NULL) {
    .self$zelig.call <- match.call(expand.dots = TRUE)
    .self$model.call <- .self$zelig.call
    callSuper(formula = formula, data = data, ...,
              weights = NULL, by = by)
  }
)

##----- A specific setx method needs to be written

## Model matrics in lavaan: http://lavaan.ugent.be/tutorial/inspect.html

zsem$methods(
  set = function(z.out) {
    return()
  }
)

##----- QI's need to be defined

zsem$methods(
  param = function(z.out) {
    return(mvrnorm(.self$num, coef(z.out), vcov(z.out)))
  }
)

zsem$methods(
  qi = function(simparam, mm) {
    ev <- simparam %*% t(mm)
    pv <- ev
    return(list(ev = ev, pv = pv))
  }
)

