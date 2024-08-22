\name{migration}
\alias{migration}
\alias{migration1}
\alias{migration5}
\alias{migration1dt}
\alias{migration5dt}
\alias{mig1dt}
\alias{mig5dt}
\alias{migproj1dt}
\alias{migproj5dt}
\alias{migrationM1}
\alias{migrationM5}
\alias{migrationF1}
\alias{migrationF5}
\alias{migrationM}
\alias{migrationF}
\alias{migprojAge1dt}
\alias{migprojAge5dt}

\docType{data}
\title{
Datasets on Migration
}
\description{
Annual and 5-year estimates and projections of net migration.
}
\usage{
# long format
data(mig1dt) # annual estimates
data(mig5dt) # 5-year estimates

data(migproj1dt) # annual projections (median and bounds)
data(migproj5dt) # 5-year projections (median and bounds)

data(migration1dt) # annual (estimates and median projections)
data(migration5dt) # 5-year (estimates and median projections)

data(migprojAge1dt) # annual age-specific projections
data(migprojAge5dt) # 5-year age-specific projections

# wide format (estimates and median projections)
data(migration1) # annual
data(migration5) # 5-year
data(migration)  # 5-year; legacy

# wide format age-specific projections
data(migrationM1) # annual male
data(migrationF1) # annual female
data(migrationM5) # 5-year male
data(migrationF5) # 5-year female
data(migrationM)  # 5-year male; legacy
data(migrationF)  # 5-year female; legacy

}
\format{
  Datasets in wide format are data frames with one row per country.  They contain the following variables:
  \describe{
  	\item{\code{country_code}}{Numerical Location Code (3-digit codes following ISO 3166-1 numeric standard) - see \url{http://en.wikipedia.org/wiki/ISO_3166-1_numeric}.}
    \item{\code{name}}{Country name.}
    \item{\code{1950}, (\code{1951}, \dots,) \code{1955}, \dots}{(Applies to annual data) Net migration (in thousand) for the specific year.}
    \item{\code{1950-1955}, \code{1955-1960},  \dots}{(Applies to 5-year data) Net migration (in thousand) for the specific five-year time period (i.e., from 1 January in year t to 31 December in year t+4 such as the period 1950-1955 refers to the period 1950.0-1954.99).}
  }
  Datasets in the long format have 1 row per country and year/time period.
}

\details{
\itemize{
\item \code{mig1dt, mig5dt}: annual and 5-year estimates of historical migration, in long format.
\item \code{migproj1dt}, \code{migproj5dt}: annual and 5-year migration projections including probability intervals, in long format.
\item \code{migration1}, \code{migration1dt}: annual estimates and median projections of total net migration, from 1950 to 2100, in wide and long format, respectively.
\item \code{migration5}, \code{migration5dt}: 5-year estimates and projections of total net migration, from 1950-1955 to 2095-2100, in wide and long format, respectively.
\item \code{migprojAge1dt, migprojAge5dt}:  annual and 5-year projections of age-specific migration in long format.
\item \code{migrationM1, migrationF1, migrationM5, migrationF5}:  annual and 5-year projections of male (M) and female (F) age-specific migration in wide format.
}
}

\source{
 These datasets are based on estimates and projections of United Nations, Department of Economic and Social Affairs, Population Division (2024). 
 }
 
 \references{
 World Population Prospects: The 2024 Revision. \url{http://population.un.org/wpp}.
}

\examples{
data(migration1)

# select records for the US
subset(migration1, country_code == 840)

# select records where the name contains the word "America"
subset(migration1, grepl("America", name, fixed = TRUE))

# in long format
# select migration for the US for years between 2000 and 2021
data(migration1dt)
migration1dt[country_code == 840 & year >= 2000 & year <= 2021]
}
\keyword{datasets}
