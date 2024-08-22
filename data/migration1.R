migration1 <- local({
    e <- new.env()
    source("migration1dt.R", local = TRUE)
    load("countries.rda", envir= e)
    e$migration1dt <- merge(data.table::as.data.table(migration1dt), e$countries, by = c("country_code", "name"), sort = FALSE)
    migration1 <- data.table::dcast(e$migration1dt, country_order + country_code + name ~ year, value.var = "mig")[, `:=`(country_order = NULL)][]
    as.data.frame(migration1)
})

#migration <- read.delim(file='migration.txt', comment.char='#', check.names=FALSE)
