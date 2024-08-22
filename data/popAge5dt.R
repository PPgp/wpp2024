# 5x5 male, female and total age-specific observed population in long format (as data.table)
popAge5dt <- local({
    source("popAge1dt.R", local = TRUE)
    e <- new.env()
    load("age5categories.rda", envir= e)
    pop1 <- merge(data.table::as.data.table(popAge1dt), e$age5categories[,.(age1, agecat, age5=age)], by.x = "age", by.y = "age1", sort = FALSE)
    pop5 <- pop1[, .(popM = sum(popM), popF = sum(popF), pop = sum(pop)), 
                 by = c("country_code", "name", "year", "agecat", "age5")][, agecat := NULL]
    pop5.1 <- pop5[year %in% seq(1949, 2019, by = 5)]
    pop5.2 <- pop5[year %in% seq(1950, 2020, by = 5)]
    pop5 <- pop5.2[, .(country_code, name, year, age = age5, popM = round((pop5.1$popM + pop5.2$popM)/2,3), 
                       popF = round((pop5.1$popF + pop5.2$popF)/2,3))][, pop := popM + popF]
    pop5[]
})
