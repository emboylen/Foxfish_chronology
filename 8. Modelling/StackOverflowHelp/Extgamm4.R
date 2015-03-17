# Extending MuMIn for gamm4

library(gamm4)
gamm <- function(...) structure(c(mgcv::gamm(...), list(call = match.call())),class = c("gamm", "list"))
gamm4 <- function(...) structure(c(gamm4::gamm4(...), list(call = match.call())),class = c("gamm", "list"))
logLik.gamm <- function(object, ...) logLik(object[[if (is.null(object$lme)) "mer" else "lme"]], ...)
formula.gamm <- function(x, ...) formula(x$gam, ...)
nobs.gamm <- function(object, ...) nobs(object$gam, ...)
nobs.gam <- function(object, ...) stats:::nobs.glm(object, ...)
coeffs.gamm <- function(model) coef(model$gam)
getAllTerms.gamm <- function(x, ...) getAllTerms(x$gam)
tTable.gamm <- function(model, ...) tTable(model$gam)
