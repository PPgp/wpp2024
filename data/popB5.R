# 5x5 male + female observed population in wide format
popB5 <- local({
    e <- new.env()
    source('popAge5dt.R', local = TRUE)
    load("countries.rda", envir= e)
    e$popAge5dt <- merge(data.table::as.data.table(popAge5dt), e$countries[,c("country_code", "country_order")], by = "country_code", sort = FALSE)
    e$popAge5dt[, agecat := rep(1:21, nrow(e$popAge5dt)/21)]
    as.data.frame(data.table::dcast(e$popAge5dt, country_order + country_code + name + agecat + age ~ year, value.var = "pop")[, `:=`(country_order = NULL, agecat = NULL)][])
})
