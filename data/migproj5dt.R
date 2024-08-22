# 5-year historical total net migration in long format (as data.table)
migproj5dt <- local({
    source('migration1dt.R', local = TRUE)
    source('migproj1dt.R', local = TRUE)
    data.table::setDT(migration1dt)
    data.table::setDT(migproj1dt)
    yeardf <- data.table::data.table(year = 1950:2104, yearcat = rep(seq(1953, 2103, by = 5), each = 5))
    yeardf[, period := paste(yearcat-3, yearcat + 2, sep = "-")]
    mig1 <- rbind(migration1dt[year >= 2020 & year < 2024], migproj1dt, fill = TRUE)
    mig1 <- merge(mig1, yeardf[year >= 2020], by = "year", sort = FALSE)
    mig1[is.na(mig_80l), mig_80l := mig]
    mig1[is.na(mig_80u), mig_80u := mig]
    mig1[is.na(mig_95l), mig_95l := mig]
    mig1[is.na(mig_95u), mig_95u := mig]
    mig1[, is_edge := year %% 5 == 0][, yearcat_upper := yearcat - 5]
    mig5 <- mig1[is_edge == FALSE, .(mig = sum(mig), mig_80l = sum(mig_80l, na.rm = TRUE), 
                                     mig_80u = sum(mig_80u, na.rm = TRUE),
                                     mig_95l = sum(mig_95l, na.rm = TRUE), 
                                     mig_95u = sum(mig_95u, na.rm = TRUE)
                                     ), by = c("country_code", "name", "yearcat", "period")]
    migedges <- mig1[is_edge == TRUE, .(mig = sum(0.5*mig), 
                                        mig_80l = sum(0.5*mig_80l, na.rm = TRUE), 
                                        mig_80u = sum(0.5*mig_80u, na.rm = TRUE),
                                        mig_95l = sum(0.5*mig_95l, na.rm = TRUE), 
                                        mig_95u = sum(0.5*mig_95u, na.rm = TRUE)), 
                     by = c("country_code", "name", "yearcat", "period")]
    migedge_up <- mig1[is_edge == TRUE, .(mig = sum(0.5*mig), 
                                          mig_80l = sum(0.5*mig_80l, na.rm = TRUE), 
                                          mig_80u = sum(0.5*mig_80u, na.rm = TRUE),
                                          mig_95l = sum(0.5*mig_95l, na.rm = TRUE), 
                                          mig_95u = sum(0.5*mig_95u, na.rm = TRUE)), 
                       by = c("country_code", "name", "yearcat_upper")]
    migedges[migedge_up, `:=`(mig = mig + i.mig, mig_80l = mig_80l + i.mig_80l, 
                              mig_80u = mig_80u + i.mig_80u,
                              mig_95l = mig_95l + i.mig_95l, mig_95u = mig_95u + i.mig_95u),
             on = c("country_code", yearcat = "yearcat_upper")]
    mig5[migedges, `:=`(mig = mig + i.mig, mig_80l = mig_80l + i.mig_80l, mig_80u = mig_80u + i.mig_80u,
                        mig_95l = mig_95l + i.mig_95l, mig_95u = mig_95u + i.mig_95u),
         on = c("country_code", "yearcat")]
    data.table::setnames(mig5, "yearcat", "year")
    mig5[]
})
