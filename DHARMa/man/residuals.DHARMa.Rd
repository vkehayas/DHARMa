% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DHARMa.R
\name{residuals.DHARMa}
\alias{residuals.DHARMa}
\title{Return residuals of a DHARMa simulation}
\usage{
\method{residuals}{DHARMa}(object, ...)
}
\arguments{
\item{object}{an object with simulated residuals created by \code{\link{simulateResiduals}}}

\item{...}{optional arguments for compatibility with the generic function, no function implemented}
}
\description{
Return residuals of a DHARMa simulation
}
\details{
the function accesses the slot $scaledResiduals in a fitted DHARMa object
}
\examples{
library(lme4)

testData = createData(sampleSize = 200, overdispersion = 0.5, family = poisson())
fittedModel <- glmer(observedResponse ~ Environment1 + (1|group), 
                     family = "poisson", data = testData,
                     control=glmerControl(optCtrl=list(maxfun=20000) ))

simulationOutput <- simulateResiduals(fittedModel = fittedModel)

# plot residuals, quantreg = T is better but costs more time
plot(simulationOutput, quantreg = FALSE)

# the calculated residuals can be accessed via 
residuals(simulationOutput)
simulationOutput$scaledResiduals

# calculating summaries per group
simulationOutput = recalculateResiduals(simulationOutput, group = testData$group)
plot(simulationOutput, quantreg = FALSE)

# create simulations with refitting, n=5 is very low, set higher when using this
simulationOutput <- simulateResiduals(fittedModel = fittedModel, 
                                      n = 10, refit = TRUE)
plot(simulationOutput, quantreg = FALSE)

# grouping per random effect group works as above
simulationOutput = recalculateResiduals(simulationOutput, group = testData$group)
plot(simulationOutput, quantreg = FALSE)

}
