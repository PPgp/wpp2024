# 1-year total observed male population in wide format (data.frame)
popMT1 <- local({
    source('pop1dt.R', local = TRUE)
    e <- new.env()
    load("countries.rda", envir= e)
    e$pop1dt <- merge(data.table::as.data.table(pop1dt), e$countries[,c("country_code", "country_order")], by = "country_code", sort = FALSE)
    as.data.frame(data.table::dcast(e$pop1dt, country_order + country_code + name ~ year, value.var = "popM")[, `:=`(country_order = NULL)][])
})
