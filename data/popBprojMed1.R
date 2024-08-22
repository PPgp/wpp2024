popBprojMed1 <- local({
    e <- new.env()
    source("popprojAge1dt.R", local = TRUE)
    load("countries.rda", envir= e)
    pop <- merge(data.table::as.data.table(popprojAge1dt), e$countries, by = c("country_code", "name"), sort = FALSE)
    as.data.frame(data.table::dcast(pop, country_order + country_code + name + age ~ year, value.var = "pop")[, `:=`(country_order = NULL)][])
})

