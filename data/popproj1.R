# 1-year total population (projected) in wide format (as data.frame)
popproj1 <- local({
    e <- new.env()
    source("popproj1dt.R", local = TRUE)
    load("countries.rda", envir= e)
    pop <- merge(data.table::as.data.table(popproj1dt), e$countries, by = c("country_code", "name"), sort = FALSE)
    as.data.frame(data.table::dcast(pop, country_order + country_code + name ~ year, value.var = "pop")[, `:=`(country_order = NULL)][])
})
