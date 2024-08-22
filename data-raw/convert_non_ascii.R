library(data.table)

dir <- "~/bayespop/R/wpps/wpp2024/data-raw"
resdir <- "~/bayespop/R/wpps/wpp2024/data"

files <- c("UNlocations.txt", "migrationM.txt", "migrationF.txt", 
           "migrationF5.txt", "migrationM5.txt")

replace.names <- list("384"="Cote d'Ivoire",
                      "638"="Reunion",
                      "531"="Curacao",
                      "652"="Saint-Barthelemy",
                      "792"="Turkiye")
for(f in files) {
    d <- fread(file.path(dir, f))
    if(! "name" %in% colnames(d)) setnames(d, "country", "name")
    for(code in names(replace.names)) {
        idx <- which(d$country_code == code)
        if(length(idx) == 0) next
        if(d[idx[1], name] == replace.names[[code]]) next
        d[idx, name := rep(replace.names[[code]], length(idx))]
        fwrite(d, file=file.path(resdir, f), sep="\t")
    }
}
