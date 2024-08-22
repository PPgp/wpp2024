# 5-year total net migration in long format (as data.table)
migration5dt <- local({
    source('mig5dt.R', local = TRUE)
    source("migproj5dt.R", local = TRUE)
    rbind(mig5dt, migproj5dt[, .(country_code, name, year, period, mig)])
})
