# 5-year total net migration in wide format (data.frame)
migration5 <- local({
    source('migration5dt.R', local = TRUE)
    e <- new.env()
    load("countries.rda", envir= e)
    e$migration5dt <- merge(data.table::as.data.table(migration5dt), e$countries[,c("country_code", "country_order")], by = "country_code", sort = FALSE)[, year := NULL]
    as.data.frame(data.table::dcast(e$migration5dt, country_order + country_code + name ~ period, value.var = "mig")[, `:=`(country_order = NULL)][])
})
