setwd("~/bayespop/R/wpps/wpp2024/data")
#for (f in rev(list.files(".", pattern = "*.R$"))) {print(f); source(f)} # run from the back
for (f in list.files(".", pattern = "*.R$")) {print(f); source(f)} # run from the front