# 5-year historical total net migration in long format (as data.table)
mig5dt <- local({
    source('mig1dt.R', local = TRUE)
    data.table::setDT(mig1dt)
    yeardf <- data.table::data.table(year = 1950:2024, yearcat = rep(seq(1953, 2023, by = 5), each = 5))
    yeardf[, period := paste(yearcat-3, yearcat + 2, sep = "-")]
    mig1 <- merge(mig1dt, yeardf[year <= 2020], by = "year", sort = FALSE)
    mig1[, is_edge := year %% 5 == 0][, yearcat_upper := yearcat - 5]
    mig5 <- mig1[is_edge == FALSE, .(mig = sum(mig)), by = c("country_code", "name", "yearcat", "period")]
    migedges <- mig1[is_edge == TRUE, .(mig = sum(0.5*mig)), by = c("country_code", "name", "yearcat", "period")]
    migedge_up <- mig1[is_edge == TRUE, .(mig = sum(0.5*mig)), by = c("country_code", "name", "yearcat_upper")]
    migedges[migedge_up, mig := mig + i.mig, on = c("country_code", yearcat = "yearcat_upper")]
    mig5[migedges, mig := mig + i.mig, on = c("country_code", "yearcat")]
    data.table::setnames(mig5, "yearcat", "year")
    mig5[]
})
