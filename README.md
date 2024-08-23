# wpp2024

## Introduction

**Maintainer's note:**

We are very pleased to provide the wpp2024 R package that contains various datasets from the newly published revision of the United Nations World Population Prospects, the [WPP 2024](https://population.un.org/wpp), released on July 11, 2024. The Population Estimates and Projection Section of the UN Population Division, under the leadership of Patrick Gerland, compiled these data, while dealing with difficult challenges including the impact of COVID on estimates and projections, as well as producing all datasets on a one year scale. 

In addition to the expert analysts working at the UN, Patrick Gerland  assembled an international group of respected  scientists to support this work, in order to ensure that the underlying methodology is cutting edge, including assessing uncertainty around estimates and projections.

For the first time, the population projections takes into account uncertainty about migration. 

[Read about the key highlights on the UN website.](https://www.un.org/development/desa/pd/world-population-prospects-2024)

[Details about the methodology](https://population.un.org/wpp/Publications/Files/WPP2024_Methodology_Advance_Unedited.pdf)

## About the R package

Although all the WPP data can be accessed from the [UN website](https://population.un.org/wpp), the **wpp2024** R package provides an easy way to access the main demographic indicators, including projection uncertainty. Unlike the previous **wpp** packages available on CRAN, this revision includes annual and 1-year age group (1x1) data. This makes the size of the package too big for a CRAN release, and thus it will be accessible from GitHub, as is the case of [wpp2022](https://github.com/PPgp/wpp2022). 

Five-year period datasets are also included. These are not official UN datasets, but were provided by Patrick Gerland, and provide data in legacy 5-year periods as used in earlier WPP revisions (i.e., from mid-year t to mid-year t+5 instead of the newer civil calendar year from 31 december (midnight) for year t to 31 december (midnight) year t+1). 

**_New in this revision_:** Datasets on migration projection contain uncertainty bounds and are now available by age and sex.



[Shiny interface to the 5-year data](https://bayespop.shinyapps.io/wpp2024explorer/)

#### Data copyright

2024 United Nations, DESA, Population Division. Licensed under [Creative Commons license CC BY 3.0 IGO](http://creativecommons.org/licenses/by/3.0/igo).
Source: United Nations, DESA, Population Division. [World Population Prospects 2024](http://population.un.org/wpp/).

#### Acknowledments

The work of the package maintainer is supported by the Eunice Kennedy Shriver National Institute of Child Health and Human Development (NICHD) under grant number R01 HD-070936, and the BayesPop research group at the University of Washington.



## Installation and usage

As with any GitHub R package, you can install it using the **devtools** package. In addition, as the package is quite big you might need to increase the timeout for the download:

```
library(devtools)
options(timeout = 600)
install_github("PPgp/wpp2024")
```


All datasets described below can be accessed via the function `data()`, e.g. 

```
data(pop1dt)
pop1dt
```

Help files are available to give more details about the datasets. Simply type e.g. `?pop1dt`

## Dataset format


Previous **wpp** packages (up to **wpp2019**) provide datasets in a wide format, where countries and ages are in rows and years correspond to columns. In this revision, we follow the format of the **wpp2022** package, where most datasets are stored in a long format (countries, ages and time correspond to rows and indicators correspond to columns). However, to keep consistency and not to break any package dependencies, we offer the wide format as well. Note that many of these datasets are created on the fly using the stored long format. 
 
Thus, most indicators in the package are included in four versions (with the corresponding suffix in parentheses): 

1. Long format annual (`1dt`)
2. Long format 5-years (`5dt`)
3. Wide format annual (`1`)
4. Wide format 5-years (`5`, sometimes without any number)

We used the **data.table** package for the long format data, while wide datasets are returned as `data.frame`. 

In the following sections we summarize the main indicators. We only list the one-year datasets; for 5-year data, replace the number 1 in their names with 5. For example, `pop1dt` becomes `pop5dt`.

## Population datasets

**_Caution_:** All annual population datasets are considered to depict population to December 31 (midnight) of each year. This is different from the official WPP release, which treats population at January 1 (0h). Thus, the population numbers in this package are shifted by one year when compared to the official UN data. E.g., population in year 2050 in the R package corresponds to 2051 in the UN data. Vital rates and counts at time t refer to the calendar year t, so that they yield population at time t in this R package.

The 5-year datasets are created in legacy WPP 5-year periods so that vital rates observed/projected from July 1 of year t to June 31 of year t+5 correspond to population at July 1 of year t+5. E.g. population in 2055 in a 5x5 dataset corresponds to vital rates/counts aggregated over 2050.5-2054.49. Since the 5x5 population is considered to July 1st, it corresponds to the interpolated values between year t and year t+1 in the annual 1x1 dataset. 

All values are in thousands.

### Historical estimates

Data from 1949 to 2023.

* Long format:
    * age-specific:
        * `popAge1dt`: columns _popM_ (male), _popF_ (female), _pop_ (total)
    * totals across ages: 
    	 * `pop1dt`: columns _popM_ (male), _popF_ (female), _pop_ (total)
* Wide format: 
	* age-specific: 
		* `popF1` (female), `popM1` (male), `popB1` (total)
	* totals by sex: 
		* `popFT1` (female), `popMT1` (male)
   * totals across sex and age: `pop1`

    	 

### Projections

Data from 2024 to 2100.

 * Long format:
    * age-specific:
        * `popprojAge1dt`: columns _popM_ (median male), _popF_ (median female), _pop_ (median total), _*\_low_, _*\_high_ (-+ 1/2 child variants)
    * totals across ages: 
    	 * `popproj1dt`: columns _popM_ (median male), _popF_ (median female), _pop_ (median total), _*\_80l_, _*\_80u_ (80% lower and upper bounds), _*\_95l_, _*\_95u_ (95% lower and upper bounds), _*\_low_, _*\_high_ (-+ 1/2 child variants)
* Wide format: 
	* age-specific: 
		* `popFprojMed1` (median female), `popMprojMed1` (median male), `popBprojMed1` (median total)
   * totals across sex and age: 
   		* `popproj1` (median total), `popprojHigh1`, `popprojLow1` (-+ 1/2 child variants)
   		* Various 5-year legacy datasets available, e.g. `popproj80l` and `popproj80u`.

## Fertility datasets

### Total fertility rate
* **Historical estimates**: `tfr1dt` (long), `tfr1` (wide) 
* **Projections**:
	* Long format: 
		* `tfrproj1dt` (median, lower and upper bounds of the 80 and 90% probability intervals and +-1/2 child variants)
	* Wide format: 
		* `tfrprojMed1` (median), `tfrprojLow1`, `tfrprojHigh1` (-+1/2 child variants)
	* Various 5-year legacy datasets available, e.g. `tfrproj80l` and `tfrproj80u`.
* **Pre-1950 estimates**: `tfr_supplemental` (5-year)

### Percent age-specific fertility rate
 
* **Historical estimates and projections**: `percentASFR1dt` (long), `percentASFR1` (wide)


## Mortality datasets

### Life expectancy at birth
#### Historical estimates
* Long format: 
	* `e01dt`: columns _e0M_ (male), _e0F_ (female), _e0B_ (combined sexes)
* Wide format:
	* `e0F1` (female), `e0M1` (male), `e0B1` (combined sexes)
	* Pre-1950 5-year: `e0M_supplemental`, `e0F_supplemental` (5-year), `e0M_supplemental1`, `e0F_supplemental1` (annual)

#### Projections
* Long format: 
	* `e0proj1dt`: columns _e0M_, _e0F_, _e0B_ (sex-specific median), _*\_80l_, _*\_80u_, _*\_95l_, _*\_95u_ (sex-specific lower and upper bounds of the 80 and 90% probabiltity intervals)
* Wide format:
	* `e0Fproj1`, `e0Mproj1`, `e0Bproj1` (sex-specific median)
	* Other 5-year legacy datasets available, e.g. `e0Mproj80l` etc.

### Mortality rates
These datasets contain age- and sex-specific historical estimates and projections (1950-2100) in one file.

* Long format: 
	* `mx1dt`: columns _mxM_ (male), _mxF_ (female), _mxB_ (both)
* Wide format:
	* `mxF1` (female), `mxM1` (male), `mxB1` (both) 

## Migration datasets
The package contains historical estimates and probabilistic projection of net migration counts (1950-2100) in 1000.

#### Combined series
* `migration1dt` (long format), `migration1` (wide format)

#### Historical estimates
* Long format:
	* `mig1dt`: column _mig_ (total)
* Wide format: see Combined series above

#### Projections
* Long format:
	* age-specific:
		* `migprojAge1dt`: columns _migM_ (male), _migF_ (female), _mig_ (total)
	* totals across ages and sexes:
		* `migproj1dt`: columns _mig_ (median), _mig\_80l_, _mig\_80u_, _mig\_95l_, _mig\_95u_ (lower and upper bounds of the 80 and 90% probabiltity intervals)
* Wide format:
	* `migrationM1`, `migrationF1` (age-specific male and female) 

## Other datasets

### Sex ratio at birth
The sex ratio at birth is defined as the ratio of male to female. The datasets contain both, historical estimates as well as projections (1950-2100).

* `sexRatio1dt` (long format) `sexRatio1` (wide format)


### Births, deaths, growth, rates
Other indicators are available in the miscellaneous dataset, such as births- and deaths-related indicators. These are only available in the long format on the one-year scale. 

* `misc1dt` (historical estimates), `miscproj1dt` (projections). Both datasets contain the following columns:
	* _births_ : annual number of live births in 1,000
	* _cbr_ : annual number of live births per 1,000 population
	* _deaths_ : annual number of deaths in 1,000
	* _cdr_ : annual number of deaths per 1,000 population
	* _PopChange_: annual population change (difference between the population at the end of the period and that at the beginning of the period. Refers to annual civil calendar years from 1 January to 31 December). Data are presented in thousands.
	* _growthrate_ : annual rate of population change (as %) computed as the average exponential rate of growth of the population over a given period. It is calculated as ln(P2/P1)/n where P1 and P2 are the populations on 1 January of subsequent years, and n is the length of the period between t1 and t2 (n=1 for annual data).
	* _cnmr_: annual crude net migration rate which corresponds to the  number of immigrants minus the number of emigrants over a period, divided by the person-years lived by the population of the receiving country over that period. It is expressed as net number of migrants per 1,000 population.
	* _NatChangeRT_: rate of natural change (crude birth rate minus the crude death rate) per 1,000 population. Represents the portion of population growth (or decline) determined exclusively by births and deaths.
 
### Locations
The dataset on UN locations is stored in `UNlocations`and provides the United Nations table of locations, including regions, for statistical purposes as available in 2024.
