# 5x5 population median projection in long format (as data.table)
popprojAge5dt <- local({
    source("popprojAge1dt.R", local = TRUE)
    e <- new.env()
    load("age5categories.rda", envir= e)
    pop1 <- data.table::as.data.table(merge(data.table::as.data.table(popprojAge1dt), e$age5categories[,.(age1, agecat, age5=age)], by.x = "age", by.y = "age1", sort = FALSE))
    pop5 <- pop1[, .(popM = sum(popM), popF = sum(popF), pop = sum(pop), 
                     popM_low = sum(popM_low), popM_high = sum(popM_high),
                     popF_low = sum(popF_low), popF_high = sum(popF_high),
                     pop_low = sum(pop_low), pop_high = sum(pop_high)
                     ), 
                 by = c("country_code", "name", "year", "agecat", "age5")][, agecat := NULL]
    pop5.1 <- pop5[year %in% seq(2024, 2099, by = 5)]
    pop5.2 <- pop5[year %in% seq(1925, 2100, by = 5)]
    pop5 <- pop5.2[, .(country_code, name, year, age = age5, 
                       popM = round((pop5.1$popM + pop5.2$popM)/2,3), 
                       popF = round((pop5.1$popF + pop5.2$popF)/2,3), 
                       pop = round((pop5.1$pop + pop5.2$pop)/2,3),
                       popM_low = round((pop5.1$popM_low + pop5.2$popM_low)/2,3), 
                       popM_high = round((pop5.1$popM_high + pop5.2$popM_high)/2,3), 
                       popF_low = round((pop5.1$popF_low + pop5.2$popF_low)/2,3),
                       popF_high = round((pop5.1$popF_high + pop5.2$popF_high)/2,3),
                       pop_low = round((pop5.1$pop_low + pop5.2$pop_low)/2,3),
                       pop_high = round((pop5.1$pop_high + pop5.2$pop_high)/2,3)
                       )]
    pop5[]
})
