# 5-year high variant projections of TFR in wide format (data.frame)
tfrprojHigh5 <- local({
    e <- new.env()
    load("tfrproj5dt.rda", envir= e)
    load("countries.rda", envir= e)
    e$tfrproj5dt <- merge(data.table::as.data.table(e$tfrproj5dt), e$countries, by = "country_code", sort = FALSE)
    as.data.frame(data.table::dcast(e$tfrproj5dt, country_order + country_code + name ~ period, value.var = "tfr_high")[, `:=`(country_order = NULL)][])
})
