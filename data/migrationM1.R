migrationM1 <- local({
    e <- new.env()
    load("migprojAge1dt.rda", envir= e)
    data.table::setDT(e$migprojAge1dt)
    load("countries.rda", envir= e)
    e$migprojAge1dt <- merge(e$migprojAge1dt, e$countries, by = "country_code", sort = FALSE)
    as.data.frame(data.table::dcast(e$migprojAge1dt, country_order + country_code + name + age ~ year, value.var = "migM")[, `:=`(country_order = NULL)][])
})


#migrationM <- read.delim(file='migrationM.txt', comment.char='#', check.names=FALSE)
