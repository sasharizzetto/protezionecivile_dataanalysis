install.packages("dbplyr")
install.packages("RPostgreSQL")
install.packages("DT")
install.packages("gifski")
install.packages("png")
install.packages("fmsb")
install.packages("gridExtra")

library(dplyr)
library(RPostgreSQL)

con <- DBI::dbConnect(RPostgreSQL::PostgreSQL(), 
                      host = "0.tcp.ngrok.io",
                      port = "12696",
                      dbname = "pc", 
                      user = "postgres",
                      password = "postgres")
                      #password = rstudioapi::askForPassword("postgres"))

#con <- dbConnect(drv, dbname="pc", host="", port="", user="", password="")

# tbl <- dplyr::tbl(con, dbplyr::in_schema('mortalidad','def0307'))

tb = tbl(con, "attivita")

# tb %>% show_query()

tb %>% left_join(tbl(con, "attivita_completata")) %>% show_query()

# 1. ATTIVITA PER COMUNE
att_per_comune = tbl(con, "attivita_completata") %>% 
  right_join(tbl(con, "attivita_in_comune")) %>% 
  count(nome_comune) %>% 
  collect()



