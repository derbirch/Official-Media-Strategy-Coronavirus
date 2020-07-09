install.packages('lubridate')
library(lubridate)

##########################
cgtnNew <- CGTNfull
cgtnNew$created_at <- as.character(cgtnNew$created_at)
cgtnNew$created_at <- ymd_hms(x = cgtnNew$created_at,
                               tz = 'GMT')
cgtnNew$created_at <- with_tz(cgtnNew$created_at,tz="Asia/Shanghai")


write_as_csv(cgtnNew, 'CGTNfullTimeCorrected', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")




#######################


pdchinaNew <- pdchina
pdchinaNew$created_at <- as.character(pdchinaNew$created_at)


pdchinaNew$created_at <- ymd_hms(x = pdchinaNew$created_at,
                              tz = 'GMT')

pdchinaNew$created_at <- with_tz(pdchinaNew$created_at,tz="Asia/Shanghai")

write_as_csv(pdchinaNew, 'pdchinaTimeCorrected', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")

EXPORT <- slice(cgtnNew,8623:10152)
write_as_csv(EXPORT, 'EXPORT', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")
