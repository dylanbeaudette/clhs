\name{clhs}

\docType{methods}

\alias{clhs}
\alias{clhs.data.frame}
\alias{clhs,data.frame-method}
\alias{clhs.SpatialPointsDataFrame}
\alias{clhs,SpatialPointsDataFrame-method}
\alias{clhs.Raster}
\alias{clhs,Raster-method}

\title{Conditioned Latin Hypercube Sampling}

\description{
Implementation of the conditioned Latin hypercube sampling, as published by Minasny and McBratney (2006). This method proposes to stratify sampling in presence of ancillary data. An extension of this method, which propose to associate a cost to each individual and take it into account during the optimisation process, is also proposed (Roudier et al., 2012).
}

\usage{
clhs(x, ...)
}

\arguments{
  \item{x}{A \code{data.frame}, \code{SpatialPointsDataFrame} or \code{Raster} object.}
  \item{...}{Additional arguments, see under Details.}
}

\details{
Below are the additional arguments that can be used:

- \code{size}: A non-negative integer giving the number of samples to pick.

- \code{cost}: A character giving the name or an integer giving the index of the attribute in \code{x} that gives a cost that can be use to constrain the cLHS sampling. If NULL (default), the cost-constrained implementation is not used.

- \code{track}: A character giving the name or an integer giving the index of the attribute in \code{x} that gives a cost associated with each individual. However, this method will only track the cost - the sampling prrocess will not be constrained by this attribute. If NULL (default), this option is not used.

- \code{iter}: A positive number, giving the number of iterations for the Metropolis-Hastings annealing process. Defaults to 10000.

- \code{temp}: The initial temperature at which the simulated annealing begins. Defaults to 1.

- \code{tdecrease}: A number betwen 0 and 1, giving the rate at which temperature decreases in the simulated annealing process. Defaults to 0.95.

- \code{weights}: A list a length 3, giving the relative weights for continuous data, categorical data, and correlation between variables. Defaults to \code{list(numeric = 1, factor = 1, correlation = 1)}.

- \code{obj.limit}: The minimal value at which the optimisation is stopped. Defaults to \code{-Inf}.

- \code{length.cycle}: The duration (number of iterations) of the isotemperature steps. Defaults to 10.

- \code{progress}: TRUE or FALSE, displays a progress bar.

- \code{simple}: TRUE or FALSE. If set to TRUE, only the indices of the selected samples are returned, as a numeric vector. If set to FALSE, a cLHS_result object is returned (takes more memory but allows to make use of cLHS_results methods such as \code{plot.cLHS_result}).
}

\value{
* If the \code{simple} option is set to TRUE (default behaviour): A numeric vector containing the indices of the selected samples is returned

* If the \code{simple} option is set to FALSE: An object of class \code{cLHS_result}, with the following elements:
  \item{index_samples}{a vector giving the indices of the chosen samples.}
  \item{sampled_data}{the sampled data.frame.}
  \item{obj}{a vector giving the evolution of the objective function throughout the Meropolis-Hastings iterations.}
\item{cost}{a vector giving the evolution of the cost function throughout the Meropolis-Hastings iterations (if available).}
}

\references{
*For the initial cLHS method:

Minasny, B. and McBratney, A.B. 2006. A conditioned Latin hypercube method for sampling in the presence of ancillary information. Computers and Geosciences, 32:1378-1388.

*For the cost-constrained implementation:

Roudier, P., Beaudette, D.E. and Hewitt, A.E. 2012. A conditioned Latin hypercube sampling algorithm incorportaing operational constraints. In: Digital Soil Assessments and Beyond. Proceedings of the 5th Golobal Workshop on Digital Soil Mapping, Sydney, Australia.
}

\author{Pierre Roudier}

\seealso{\code{\link{plot.cLHS_result}}}

\examples{
df <- data.frame(
  a = runif(1000), 
  b = rnorm(1000), 
  c = sample(LETTERS[1:5], size = 1000, replace = TRUE)
)

# Returning the indices of the sampled points
res <- clhs(df, size = 50, iter = 100, progress = FALSE, simple = TRUE)
str(res)

# Returning a cLHS_result object for plotting
res <- clhs(df, size = 50, iter = 100, progress = FALSE, simple = FALSE)
str(res)
plot(res)
}
