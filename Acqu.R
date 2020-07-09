library(rtweet)
library(dplyr)
library(ggplot2)
install.packages('rtweet')



#Your Token

token <- create_token(
   app = "APP_NAME",
   access_token = 'ACCESS_TOKEN',
   access_secret = 'ACCESS_SECRET',
   consumer_key = 'API_KEY',
   consumer_secret = 'API_SECRET',
   set_renv = TRUE
)
get_token()



#You may need to cofigue proxy if in limited connection

file.edit('~/.Renviron')





#Collect Timeline

user <- c('PDChina')

PDChina <- get_timeline(
      user,
      n = 3200,
      max_id = NULL,
      home = FALSE,
      parse = TRUE,
      check = TRUE,
      token = NULL
)

user <- c('XHNews')

XHNews <- get_timeline(
   user,
   n = 3200,
   max_id = NULL,
   home = FALSE,
   parse = TRUE,
   check = TRUE,
   token = NULL
)

user <- c('CGTNOfficial')

CGTN <- get_timeline(
   user,
   n = 3200,
   max_id = NULL,
   home = FALSE,
   parse = TRUE,
   check = TRUE,
   token = NULL
)




#Export Data

write.csv(PDChina,"C:/Users/wardz/Desktop/CoronavirusTweetScrawp/PDChina.csv", row.names = TRUE)




# SEARCH FULL ARCHIEVE API
# 2020 01 - 2020 02
pdchina1 <- search_fullarchive(
   "from:pdchina",
   n = 18000,
   fromDate = 202001010000,
   toDate = 202003010000,
   env_name = 'academical',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)


# 2019 12
pdchina2 <- search_fullarchive(
   "from:pdchina",
   n = 18000,
   fromDate = 201912010000,
   toDate = 202001010000,
   env_name = 'academical',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)

# 2020 03
pdchina3 <- search_fullarchive(
   "from:pdchina",
   n = 18000,
   fromDate = 202003010000,
   toDate = 202004010000,
   env_name = 'academical',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)

pdchina <- rbind(pdchina2,pdchina1)
pdchina <- rbind(pdchina,pdchina3)

pdchina4 <- search_fullarchive(
   "from:pdchina",
   n = 2000,
   fromDate = 202003010000,
   toDate = 202003051508,
   env_name = 'label2',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)


###########################################################################
#CGTN

#12
CGTNfull1 <- search_fullarchive(
   "from:CGTNOfficial",
   n = 18000,
   fromDate = 201912010000,
   toDate = 202001010000,
   env_name = 'label2',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)


#1
CGTNfull2 <- search_fullarchive(
   "from:CGTNOfficial",
   n = 18000,
   fromDate = 202001010000,
   toDate = 202002010000,
   env_name = 'test',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)


#2
CGTNfull3 <- search_fullarchive(
   "from:CGTNOfficial",
   n = 18000,
   fromDate = 202002010000,
   toDate = 202003010000,
   env_name = 'test',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)


#3
CGTNfull4 <- search_fullarchive(
   "from:CGTNOfficial",
   n = 18000,
   fromDate = 202003010000,
   toDate = 202004010000,
   env_name = 'test',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)

CGTNfull5 <- search_fullarchive(
   "from:CGTNOfficial",
   n = 18000,
   fromDate = 202003010000,
   toDate = 202003301046,
   env_name = 'ele',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)



#4
CGTNfull6 <- search_fullarchive(
   "from:CGTNOfficial",
   n = 18000,
   fromDate = 202004010000,
   toDate = 202005010000,
   env_name = 'ele',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)


CGTNfull7 <- search_fullarchive(
   "from:CGTNOfficial",
   n = 8000,
   fromDate = 202004010000,
   toDate = 202004161020,
   env_name = 'label2',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)


CGTNfull <- rbind(CGTNfull1,CGTNfull2)
CGTNfull <- rbind(CGTNfull,CGTNfull3)
CGTNfull <- rbind(CGTNfull,CGTNfull4)
CGTNfull <- rbind(CGTNfull,CGTNfull5)


write_as_csv(CGTNfull, 'CGTNfull12010401', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")
###新华
XHNewsfull1 <- search_fullarchive(
   "from:XHNews",
   n = 18000,
   fromDate = 201912010000,
   toDate = 202004010000,
   env_name = 'lable2',
   safedir = NULL,
   parse = TRUE,
   token = NULL
)



# WRITE CSV
write_as_csv(pdchina, 'pdchina01010301', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")


write_as_csv(CGTN, 'CGTN3200', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")
write_as_csv(PDChina, 'PDChina3200', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")
write_as_csv(XHNews, 'XHNews3200', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")
