# 5x5 projected median of male population in wide format
popMprojMed5 <- local({
    source('popprojAge5dt.R', local = TRUE)
    e <- new.env()
    load("countries.rda", envir= e)
    load("age5categories.rda", envir = e)
    e$popprojAge5dt <- merge(data.table::as.data.table(popprojAge5dt), e$countries[,c("country_code", "country_order")], by = "country_code", sort = FALSE)
    e$popprojAge5dt <- merge(e$popprojAge5dt, unique(e$age5categories[,.(agecat, age)]), by = "age", sort = FALSE)
    as.data.frame(data.table::dcast(e$popprojAge5dt, country_order + country_code + name + agecat + age ~ year, 
                                    value.var = "popM")[, `:=`(country_order = NULL, agecat = NULL)][])
})
