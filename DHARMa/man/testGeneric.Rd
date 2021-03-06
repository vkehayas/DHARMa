% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tests.R
\name{testGeneric}
\alias{testGeneric}
\title{Generic simulation test of a summary statistic}
\usage{
testGeneric(simulationOutput, summary, alternative = c("two.sided", "greater",
  "less"), plot = T, methodName = "DHARMa generic simulation test")
}
\arguments{
\item{simulationOutput}{a DHARMa object with simulated residuals created with \code{\link{simulateResiduals}}}

\item{summary}{a function that can be applied to simulated / observed data. See examples below}

\item{alternative}{a character string specifying whether the test should test if observations are "greater", "less" or "two.sided" compared to the simulated null hypothesis}

\item{plot}{whether to plot the simulated summary}

\item{methodName}{name of the test (will be used in plot)}
}
\description{
This function tests if a user-defined summary differs when applied to simulated / observed data.
}
\details{
This function tests if a user-defined summary differs when applied to simulated / observed data. the function can easily be remodeled to apply summaries on the residuals, by simply defining f = function(x) summary (x - predictions), as done in \code{\link{testDispersion}}
}
\note{
The function that you supply is applied on the data as it is represented in your fitted model, which may not always correspond to how you think. This is important in particular when you use k/n binomial data, and want to test for 1-inflation. As an example, if have k/20 observations, and you provide your data via cbind (y, y-20), you have to test for 20-inflation (because this is how the data is represented in the model). However, if you provide data via y/20, and weights = 20, you should test for 1-inflation. In doubt, check how the data is internally represented in model.frame(model), or via simulate(model)
}
\examples{
# creating test data

testData = createData(sampleSize = 200, overdispersion = 0.5, randomEffectVariance = 0)
fittedModel <- glm(observedResponse ~ Environment1 , family = "poisson", data = testData)
simulationOutput <- simulateResiduals(fittedModel = fittedModel)

plot(simulationOutput, quantreg = FALSE)

###### Distribution tests #####

testUniformity(simulationOutput)

###### Dispersion tests #######

testDispersion(simulationOutput, alternative = "less") # underdispersion

###### Both together###########

testResiduals(simulationOutput)

###### Special tests ##########

# testing zero inflation
testZeroInflation(simulationOutput)

# testing generic summaries
countOnes <- function(x) sum(x == 1)  # testing for number of 1s
testGeneric(simulationOutput, summary = countOnes) # 1-inflation
testGeneric(simulationOutput, summary = countOnes, alternative = "less") # 1-deficit

means <- function(x) mean(x) # testing if mean prediction fits
testGeneric(simulationOutput, summary = means) 

spread <- function(x) sd(x) # testing if mean sd fits
testGeneric(simulationOutput, summary = spread) 

###### Refited ##############

# if model is refitted, a different test will be called

simulationOutput <- simulateResiduals(fittedModel = fittedModel, refit = TRUE, seed = 12)
testDispersion(simulationOutput)

###### Test per group ##############

simulationOutput = recalculateResiduals(simulationOutput, group = testData$group)
testDispersion(simulationOutput)


}
\seealso{
\code{\link{testResiduals}}, \code{\link{testUniformity}}, \code{\link{testDispersion}}, \code{\link{testZeroInflation}}, \code{\link{testTemporalAutocorrelation}}, \code{\link{testSpatialAutocorrelation}}
}
\author{
Florian Hartig
}
