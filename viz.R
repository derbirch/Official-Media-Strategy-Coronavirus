
##### 读鸭读鸭读数据
pdchinaCleaned <- read.csv('pdchina数据汇总.csv',sep=',',header=TRUE,encoding='UTF-8')


#复用

temp <- read.csv('finalData/定稿CGTN.csv',sep=',',header=TRUE,encoding='UTF-8')

##### Lib
library(lubridate)
library(echarts4r)
library(dplyr)
library(tidyr)
library(rtweet)

##### 分组

temp$md <- ymd(x = temp$created_date)
temp$hm <- hms(x = temp$created_time)
temp$h <- hour(x = temp$hm)
temp$md <- as.factor(temp$md)
temp$h <- as.numeric(temp$h)


p1 <- filter(temp,h<5)
p1$peroid <- '凌晨'
p2 <- filter(temp,h<8&h>=5)
p2$peroid <- '早晨'
p3 <- filter(temp,h<11&h>=8)
p3$peroid <- '上午'
p4 <- filter(temp,h<13&h>=11)
p4$peroid <- '中午'
p5 <- filter(temp,h<16&h>=13)
p5$peroid <- '下午'
p6 <- filter(temp,h<19&h>=16)
p6$peroid <- '傍晚'
p7 <- filter(temp,h<24&h>=19)
p7$peroid <- '深夜'

plist <- c(p1,p2,p3,p4,p5,p6,p7)
pt <- rbind(p1,p2) 
pt <- rbind(pt,p3) 
pt <- rbind(pt,p4) 
pt <- rbind(pt,p5) 
pt <- rbind(pt,p6) 
pt <- rbind(pt,p7) 

#####Bar plot 出来吧柱状图
tb1 <- table(temp$md)
tb1 <- as.data.frame(tb1)


max <- list(
  name = "Max",
  type = "max"
)

min <- list(
  name = "Min",
  type = "min"
)

tb1 %>% 
  e_charts(Var1) %>% 
  e_bar(Freq, name = "每月数量") %>%
  e_tooltip() %>%
  e_mark_point(data = max) %>% 
  e_mark_point(data = min) %>%
  e_datazoom(type = "slider")


##### 小时分布
tb2 <- table(pt$peroid)
tb2 <- as.data.frame(tb2)


max <- list(
  name = "Max",
  type = "max"
)

min <- list(
  name = "Min",
  type = "min"
)

tb2 %>% 
  e_charts(Var1) %>% 
  e_bar(Freq, name = "时间段数量") %>%
  e_tooltip() %>%
  e_mark_point(data = max) %>% 
  e_mark_point(data = min)

###### 热力图



v <- LETTERS[1:10]
matrix <- data.frame(
  x = sample(v, 300, replace = TRUE), 
  y = sample(v, 300, replace = TRUE), 
  z = rnorm(300, 10, 1),
  stringsAsFactors = FALSE
) %>% 
  dplyr::group_by(x, y) %>% 
  dplyr::summarise(z = sum(z)) %>% 
  dplyr::ungroup()
#> `summarise()` regrouping output by 'x' (override with `.groups` argument)

matrix %>% 
  e_charts(x) %>% 
  e_heatmap(y, z) %>% 
  e_visual_map(z) %>% 
  e_title("Heatmap")


tb3 <- table(pt$md,pt$peroid)
tb3 <- as.data.frame(tb3)



tb3 %>% 
  e_charts(Var1) %>% 
  e_heatmap(Var2, Freq) %>% 
  e_visual_map(Freq) %>% 
  e_title("Heatmap") %>%
  e_tooltip()


tb4 <- table(temp$md,temp$h)
tb4 <- as.data.frame(tb4)

tb4 %>% 
  e_charts(Var1) %>% 
  e_heatmap(Var2, Freq) %>% 
  e_visual_map(Freq) %>% 
  e_title("Heatmap") %>%
  e_tooltip()

pt$frame <- as.character(pt$frame)

##########桑基图
 

q1 <- filter(pt,frame=='事实陈述')
q1$cat <- '事实框架'
q2 <- filter(pt,frame=='权威阐释')
q2$cat <- '事实框架'
q3 <- filter(pt,frame=='认知差异')
q3$cat <- '冲突框架'
q4 <- filter(pt,frame=='行动争议')
q4$cat <- '冲突框架'
q5 <- filter(pt,frame=='歌颂报道')
q5$cat <- '情感框架'
q6 <- filter(pt,frame=='共情报道')
q6$cat <- '情感框架'
q7 <- filter(pt,frame=='问责行动')
q7$cat <- '责任框架'
q8 <- filter(pt,frame=='失责行为')
q8$cat <- '责任框架'
q9 <- filter(pt,frame=='道德信仰')
q9$cat <- '道德框架'
q10 <- filter(pt,frame=='人性欲望')
q10$cat <- '道德框架'
q11 <- filter(pt,frame=='政府举措')
q11$cat <- '应对框架'
q12 <- filter(pt,frame=='行动引导')
q12$cat <- '应对框架'
q13 <- filter(pt,frame=='国际影响')
q13$cat <- '影响框架'
q14 <- filter(pt,frame=='国内影响')
q14$cat <- '影响框架'

qt <- rbind(q1,q2)
qt <- rbind(qt,q3)
qt <- rbind(qt,q4)
qt <- rbind(qt,q5)
qt <- rbind(qt,q6)
qt <- rbind(qt,q7)
qt <- rbind(qt,q8)
qt <- rbind(qt,q9)
qt <- rbind(qt,q10)
qt <- rbind(qt,q11)
qt <- rbind(qt,q12)
qt <- rbind(qt,q13)
qt <- rbind(qt,q14)

nqt <-qt
nqt$Length <- as.factor(nqt$Length) 
nqt$source_country <- as.factor(nqt$source_country) 
nqt$source_identity <- as.factor(nqt$source_identity) 

levels(nqt$Length)
levels(nqt$Length)[1] <- '一句话推文'
levels(nqt$Length)[2] <- '长推文'

levels(nqt$source_country)
levels(nqt$source_country)[1] <- '中国'
levels(nqt$source_country)[2] <- '美国'
levels(nqt$source_country)[3] <- '国际'
levels(nqt$source_country)[4] <- '其他'

levels(nqt$source_identity)
levels(nqt$source_identity)[1] <- '官方'
levels(nqt$source_identity)[2] <- '抗疫人员'
levels(nqt$source_identity)[3] <- '专家机构'
levels(nqt$source_identity)[4] <- '百姓生活'

tb5 <- table(nqt$md,nqt$peroid ,nqt$cat,nqt$frame,nqt$Length,nqt$source_country,nqt$source_identity)
tb5 <- as.data.frame(tb5)
tb5 %>% 
  e_charts() %>% 
  e_sankey(Var1, Var2, Freq) %>% 
  e_sankey(Var2, Var3, Freq,x_index = 1, y_index = 1) %>% 
  e_title("Sankey chart")

?slice(tb6[])
tb6 <- spread(nqt,'md','frame')

t1 <- rbind(q1,q2)
t1 <- table(t1$md,t1$cat)
t2 <- rbind(q3,q4)
t2 <- table(t2$md,t2$cat)
t3 <- rbind(q5,q6)
t3 <- table(t3$md,t3$cat)
t4 <- rbind(q7,q8)
t4 <- table(t4$md,t4$cat)
t5 <- rbind(q9,q10)
t5 <- table(t5$md,t5$cat)
t6 <- rbind(q11,q12)
t6 <- table(t6$md,t6$cat)
t7 <- rbind(q13,q14)
t7 <- table(t7$md,t7$cat)
tt1 <- cbind(t1,t2)
tt1 <- cbind(t3,tt1)
tt1 <- cbind(t4,tt1)
tt1 <- cbind(t5,tt1)
tt1 <- cbind(t6,tt1)
tt1 <- cbind(t7,tt1)
tt1 <- as.data.frame(tt1)

View(t7)
tt1$date <- row.names(tt1)

tt1 %>% 
  e_charts(date) %>% 
  e_bar('影响框架', name = "影响框架" ,stack = "grp") %>%
  e_bar('应对框架', name = "应对框架" ,stack = "grp") %>%
  e_bar('道德框架', name = "道德框架" ,stack = "grp") %>%
  e_bar('责任框架', name = "责任框架" ,stack = "grp") %>%
  e_bar('情感框架', name = "情感框架" ,stack = "grp") %>%
  e_bar('事实框架', name = "事实框架" ,stack = "grp") %>%
  e_bar('冲突框架', name = "冲突框架" ,stack = "grp") %>%
  e_tooltip() %>%
  e_datazoom(type = "slider") %>%
  e_mark_point(data = max) %>% 
  e_mark_point(data = min)




########################################



CGTN_covPrecent <- read.csv('finalData/CGTN_covPrecent.csv',sep=',',header=TRUE,encoding='UTF-8')
pdChina_covPrecent <- read.csv('finalData/pdChina_covPrecent.csv',sep=',',header=TRUE,encoding='UTF-8')




################


all_covPrecent <- read.csv('finalData/pdChina_covPrecent1.csv',sep=',',header=TRUE,encoding='UTF-8')


##############

all_covPrecent <- merge(CGTN_covPrecent,pdChina_covPrecent)
all_covPrecent <- subset(all_covPrecent, select = -date )
View(all_covPrecent)

all_covPrecent$CGFreq <- all_covPrecent$CGFreq-all_covPrecent$CGFreqC
all_covPrecent$PDFreq <- all_covPrecent$PDFreq-all_covPrecent$PDFreqC

all_covPrecent <- all_covPrecent[,-5]

all_covPrecent[64,4] <- 3
all_covPrecent$date <- ymd(all_covPrecent$date)
all_covPrecent$date <- as.character(all_covPrecent$date)
all_covPrecent <- arrange(all_covPrecent,date)
all_covPrecent <- slice(all_covPrecent,31:122)

all_covPrecent %>%
  e_charts(date) %>%
  e_bar(CGFreq,name='CGTN其他',serise='CGTN',stack = "grp") %>%
  e_bar(CGFreqC,name='CGTN疫情相关',serise='CGTN',stack = "grp") %>%
  e_bar(PDFreq,name='PDChina其他',serise='PDChina',stack = "grp1" , x_index = 1, y_index = 1) %>%
  e_bar(PDFreqC,name='PDChina疫情相关',serise='PDChina',stack = "grp1" , x_index = 1, y_index = 1) %>%
  e_grid(width = "45%") %>% 
  e_grid(width = "45%", left = "55%") %>% 
  e_y_axis(gridIndex = 1 ) %>% # put x and y on grid index 1
  e_x_axis(gridIndex = 1,position="right") %>%
  e_flip_coords() %>%
  e_tooltip() #%>%
#e_title('每日疫情相关推文与其他',subtext='柱状堆砌图')






##########################################
#Heatmap 推文时间日期分布

install.packages("readxl")
library(readxl)
all_CG_PD1 = read_excel("finalData/CGTN+PDChina.xlsx",sheet = 1) 
all_CG_PD1$screen_name <- as.factor(all_CG_PD1$screen_name)
all_CG_PD1$date <- as.character(all_CG_PD1$created_date)
all_CG_PD1$time <- as.character(all_CG_PD1$created_time)



all_CG_PD1$date <- ymd_hms(all_CG_PD1$date)
all_CG_PD1$time <- ymd_hms(all_CG_PD1$time)
all_CG_PD1$date <- as.Date(all_CG_PD1$date)

all_CG_PD1$hour <- hour(all_CG_PD1$time)

all_CG_PD1$date <- as.character(all_CG_PD1$date)
all_CG_PD1$hour <- as.factor(all_CG_PD1$hour)
factor(all_CG_PD1$hour)

tbc1 <- filter(all_CG_PD1,all_CG_PD1$screen_name=='CGTNOfficial')
tbc2 <- filter(all_CG_PD1,all_CG_PD1$screen_name=='PDChina')

tbc11 <- table(tbc1$date,tbc1$hour)
tbc11 <- as.data.frame(tbc11)

tbc22 <- table(tbc2$date,tbc2$hour)
tbc22 <- as.data.frame(tbc22)

tbc <- data.frame()


View(tbc22)

tbc11 %>% 
  e_charts(Var1) %>% 
  e_heatmap(Var2, Freq) %>% 
  e_visual_map(Freq) %>% 
  e_title('CGTN推文时间日期分布') %>%
  e_tooltip()


tbc22 %>% 
  e_charts(Var1) %>% 
  e_heatmap(Var2, Freq) %>% 
  e_visual_map(Freq) %>% 
  e_title('PDChina推文时间日期分布') %>%
  e_tooltip()


all_CG_PD1 <- read.csv('finalData/副本CGTN+PDChina.csv',sep=',',header=TRUE,encoding='UTF-8')
all_CG_PD$cat <- as.character(all_CG_PD$cat)
all_CG_PD$created_date <- as.character(all_CG_PD$created_date)
View(temp1)











#######################################
#StackBar in Frames 框架条形堆栈


temp1 <- filter(all_CG_PD,cat=='影响框架')
temp1 <- table(temp1$created_date,temp1$cat)

temp2 <- filter(all_CG_PD,cat=='事实框架')
temp2 <- table(temp2$created_date,temp2$cat)

temp3 <- filter(all_CG_PD,cat=='冲突框架')
temp3 <- table(temp3$created_date,temp3$cat)
temp4 <- filter(all_CG_PD,cat=='情感框架')
temp4 <- table(temp4$created_date,temp4$cat)
temp5 <- filter(all_CG_PD,cat=='责任框架')
temp5 <- table(temp5$created_date,temp5$cat)
temp6 <- filter(all_CG_PD,cat=='道德框架')
temp6 <- table(temp6$created_date,temp6$cat)
temp7 <- filter(all_CG_PD,cat=='应对框架')
temp7 <- table(temp7$created_date,temp7$cat)

temp <- merge(temp1, temp2, by="Var1", all = T)
temp <- merge(temp, temp3, by="Var1", all = T)
temp <- merge(temp, temp4, by="Var1", all = T)
temp <- merge(temp, temp5, by="Var1", all = T)
temp <- merge(temp, temp6, by="Var1", all = T)
temp <- merge(temp, temp7, by="Var1", all = T)
View(temp)


p_all_CG_PD <- data.frame(date=temp[1],
                          Yingxiang=temp[3],
                          Shishi=temp[5],
                          Chongtu=temp[7],
                          Qinggan=temp[9],
                          Zeren=temp[11],
                          Daode=temp[13],
                          Yingdui=temp[15])

colnames(p_all_CG_PD) <- c('date', '影响框架','事实框架','冲突框架','情感框架','责任框架','道德框架','应对框架')
p_all_CG_PD %>%
  e_charts(date) %>% 
  e_bar('影响框架', name = "影响框架" ,stack = "grp") %>%
  e_bar('应对框架', name = "应对框架" ,stack = "grp") %>%
  e_bar('道德框架', name = "道德框架" ,stack = "grp") %>%
  e_bar('责任框架', name = "责任框架" ,stack = "grp") %>%
  e_bar('情感框架', name = "情感框架" ,stack = "grp") %>%
  e_bar('事实框架', name = "事实框架" ,stack = "grp") %>%
  e_bar('冲突框架', name = "冲突框架" ,stack = "grp") %>%
  e_tooltip() %>%
  e_datazoom(type = "slider") %>%
  e_mark_point(data = max) %>% 
  e_mark_point(data = min) %>%
  e_title('')

p_all_CG_PD$date <-as.character(p_all_CG_PD$date)
p_all_CG_PD <- arrange(p_all_CG_PD,date)
p_all_CG_PD[is.na(p_all_CG_PD)] <- 0
p_all_CG_PD$date <- ymd(p_all_CG_PD$date)







#Save tidy data

write_as_csv(tb5, 'Snacky', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")
write_as_csv(tt1, 'TidyPDChina Frame', prepend_ids = TRUE, na = "", fileEncoding = "UTF-8")
