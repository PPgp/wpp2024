\name{misc}
\alias{misc}
\alias{misc1dt}
\alias{miscproj1dt}
\alias{age5categories}

\docType{data}
\title{
Miscellaneous demographic indicators
}
\description{
Datasets containing annual estimates and projections from various demographic indicators.
}
\usage{
# estimates
data(misc1dt)

# projections
data(miscproj1dt)
}
\format{
  Data frames with one observation per country and year. They contain the following variables:
  \describe{
    \item{\code{country_code}}{Numerical Location Code (3-digit codes following ISO 3166-1 numeric standard) - see \url{http://en.wikipedia.org/wiki/ISO_3166-1_numeric}.}
    \item{\code{name}}{Name of country or region (following ISO 3166 official short names in English - see \url{https://www.iso.org/obp/ui/#search/code/} and United Nations Multilingual Terminology Database - see \url{http://unterm.un.org}).}
    \item{\code{year}}{Corresponding year.}
    \item{\code{births}}{Annual number of live births in 1,000.}
    \item{\code{cbr}}{Annual number of live births per 1,000 population.}
    \item{\code{deaths}}{Annual number of deaths in 1,000.}
    \item{\code{cdr}}{Annual number of deaths per 1,000 population.}
    \item{\code{growthrate}}{Annual rate of population change (as \%) computed as the average exponential rate of growth of the population over a given period. It is calculated as ln(P2/P1)/n where P1 and P2 are the populations on 1 January of subsequent years, and n is the length of the period between t1 and t2 (n=1 for annual data).}
    \item{\code{PopChange}}{Annual population change (difference between the population at the end of the period and that at the beginning of the period. Refers to annual civil calendar years from 1 January to 31 December). Data are presented in thousands.}
    \item{\code{cnmr}}{Annual crude net migration rate which corresponds to the  number of immigrants minus the number of emigrants over a period, divided by the person-years lived by the population of the receiving country over that period. It is expressed as net number of migrants per 1,000 population.}
    \item{\code{NatChangeRT}}{Rate of natural change (crude birth rate minus the crude death rate) per 1,000 population. Represents the portion of population growth (or decline) determined exclusively by births and deaths.}
  }
}
%\details{
%%  ~~ If necessary, more details than the __description__ above ~~
%}
\source{
 These datasets are based on estimates and projections of United Nations, Department of Economic and Social Affairs, Population Division (2024). 
}
\references{
World Population Prospects: The 2024 Revision. \url{http://population.un.org/wpp}.
}
\examples{
data(misc1dt)
misc1dt
}
\keyword{datasets}
