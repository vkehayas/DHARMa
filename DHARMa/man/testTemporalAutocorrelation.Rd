% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tests.R
\name{testTemporalAutocorrelation}
\alias{testTemporalAutocorrelation}
\title{Test for temporal autocorrelation}
\usage{
testTemporalAutocorrelation(simulationOutput, time = NULL,
  alternative = c("two.sided", "greater", "less"), plot = T)
}
\arguments{
\item{simulationOutput}{an object with simulated residuals created by \code{\link{simulateResiduals}}}

\item{time}{the time, in the same order as the data points. If set to "random", random values will be created}

\item{alternative}{a character string specifying whether the test should test if observations are "greater", "less" or "two.sided" compared to the simulated null hypothesis}

\item{plot}{whether to plot output}
}
\description{
This function performs a standard test for temporal autocorrelation on the simulated residuals
}
\details{
The function performs a Durbin-Watson test on the uniformly scaled residuals, and plots the residuals against time. The DB test was originally be designed for normal residuals. In simulations, I didn't see a problem with this setting though. The alternative is to transform the uniform residuals to normal residuals and perform the DB test on those.
}
\note{
The sense of being able to run the test with time = NULL (random values) is to test the rate of false positives under the current residual structure (random time corresponds to H0: no spatial autocorrelation), e.g. to check if the test has noninal error rates for particular residual structures (note that Durbin-Watson originally assumes normal residuals, error rates seem correct for uniform residuals, but may not be correct if there are still other residual problems).
}
\examples{
testData = createData(sampleSize = 40, family = gaussian())
fittedModel <- lm(observedResponse ~ Environment1, data = testData)
res = simulateResiduals(fittedModel)

# Standard use
testTemporalAutocorrelation(res, time =  testData$time)

# If no time is provided, random values will be created
testTemporalAutocorrelation(res)

}
\seealso{
\code{\link{testResiduals}}, \code{\link{testUniformity}}, \code{\link{testDispersion}}, \code{\link{testZeroInflation}}, \code{\link{testGeneric}}, \code{\link{testSpatialAutocorrelation}}
}
\author{
Florian Hartig
}
