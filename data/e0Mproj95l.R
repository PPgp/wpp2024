# 5-year lower projection 95% bound of male e0 in wide format (data.frame)
e0Mproj95l <- local({
    #source('e0Mproj95l5.R')
    #e0Mproj95l5
    e <- new.env()
    load("e0proj5dt.rda", envir= e)
    load("countries.rda", envir= e)
    e$e0proj5dt <- merge(data.table::as.data.table(e$e0proj5dt), e$countries, by = "country_code", sort = FALSE)
    as.data.frame(data.table::dcast(e$e0proj5dt, country_order + country_code + name ~ period, value.var = "e0M_95l")[, `:=`(country_order = NULL)][])
})
