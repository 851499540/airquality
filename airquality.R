require(tidyr)
require(tidyverse)
require(ggplot2)






################### read data##################
path = "B:/codework/study/adss 504/input"


beijing <- 
  do.call(rbind,
          list.files(path, pattern="^beijing.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


shanghai <- 
  do.call(rbind,
          list.files(path, pattern="^shanghai.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


guangzhou <- 
  do.call(rbind,
          list.files(path, pattern="^guangzhou.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


shenzhen <- 
  do.call(rbind,
          list.files(path, pattern="^shenzhen.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


wuhan <- 
  do.call(rbind,
          list.files(path, pattern="^wuhan.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


chongqing <- 
  do.call(rbind,
          list.files(path, pattern="^chongqing.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


chengdu <- 
  do.call(rbind,
          list.files(path, pattern="^chengdu.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


xian <- 
  do.call(rbind,
          list.files(path, pattern="^xian.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


hangzhou <- 
  do.call(rbind,
          list.files(path, pattern="^hangzhou.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))


changsha <- 
  do.call(rbind,
          list.files(path, pattern="^changsha.*?.csv",full.names = TRUE) %>% 
            lapply(read.csv,header=FALSE, col.names = c('Date', 'AQI', 'level', 'PM25', 'PM10', 'SO2', 'CO', 'NO2', 'O3_8h')))




#'wuhan','beijing','shanghai','guangzhou','shenzhen',
#'chengdu','xian','hangzhou','changsha','chongqin'




############### find duplicate data ##################
sum(duplicated(beijing[1]))
sum(duplicated(shanghai[1]))
sum(duplicated(hangzhou[1]))
sum(duplicated(chengdu[1]))
sum(duplicated(xian[1]))
sum(duplicated(chongqing[1]))
sum(duplicated(guangzhou[1]))
sum(duplicated(shenzhen[1]))
sum(duplicated(wuhan[1]))
sum(duplicated(changsha[1]))



#chongqing[duplicated(chongqing[1]),]



################ find missing value ####################

head <- beijing[1:1095,1:9]
tail <- beijing[1096:1825,1:9]
head$Date <- as.Date(head$Date)
tail$Date<-as.Date(tail$Date)
head<-rbind.data.frame(head, tail)
tail <- beijing[1826:2191,1:9]
tail$Date<-as.Date(tail$Date)
head<-rbind.data.frame(head, tail)
tail <- beijing[2192:2353,1:9]
tail$Date<-as.Date(tail$Date)
beijing <- rbind.data.frame(head, tail)

xian$Date<-as.Date(xian$Date)
wuhan$Date<-as.Date(wuhan$Date)
changsha$Date<-as.Date(changsha$Date)

head <- chongqing[1:2192,1:9]
tail <- chongqing[2193:2354,1:9]
head$Date <- as.Date(head$Date)
tail$Date<-as.Date(tail$Date)
chongqing<-rbind.data.frame(head, tail)
rownames(chongqing) <- 1:2354


chengdu$Date<-as.Date(chengdu$Date)

head <- shanghai[1:731,1:9]
mid <- shanghai[732:1461,1:9]
tail <- shanghai[1462:2354,1:9]
head$Date <- as.Date(head$Date)
mid$Date <- as.Date(mid$Date)
tail$Date<-as.Date(tail$Date)
head <- rbind.data.frame(head, mid)
shanghai <- rbind.data.frame(head, tail)


head <- hangzhou[1:731,1:9]
mid <- hangzhou[732:1096,1:9]
tail <- hangzhou[1097:1461,1:9]
head$Date <- as.Date(head$Date)
mid$Date <- as.Date(mid$Date)
tail$Date<-as.Date(tail$Date)
head <- rbind.data.frame(head, mid)
head <- rbind.data.frame(head, tail)
tail <- hangzhou[1462:2354,1:9]
tail$Date<-as.Date(tail$Date)
hangzhou <- rbind.data.frame(head, tail)
rownames(hangzhou) <- 1:2354

head <- guangzhou[1:731,1:9]
mid <- guangzhou[732:1096,1:9]
tail <- guangzhou[1097:2354,1:9]
head$Date <- as.Date(head$Date)
mid$Date <- as.Date(mid$Date)
tail$Date<-as.Date(tail$Date)
head <- rbind.data.frame(head, mid)
guangzhou <- rbind.data.frame(head, tail)
rownames(guangzhou) <- 1:2354

shenzhen$Date<-as.Date(shenzhen$Date)



daterange <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "1 day")
length(daterange)#2354

daterange[!daterange %in% beijing$Date]
daterange[!daterange %in% wuhan$Date]
daterange[!daterange %in% changsha$Date]

#################### beijing  "2016-04-16" ###########################


head <- beijing[beijing$Date < "2016-04-16",]
tail <- beijing[beijing$Date > "2016-04-16",]
x<- head[head$Date == "2016-04-15",]
y<- tail[tail$Date == "2016-04-17",]
colMeans(rbind(x,y)[1:2,c(2,4,5,6,7,8,9)])

z<-data.frame(Date=c(as.Date("2016-04-16")), 
              AQI=63,level = "Á¼",PM25=37.5,PM10=71,SO2=0.65,CO=9,NO2=37,O3_8h=91)
beijing <- rbind(rbind(head,z),tail)
rownames(beijing) <- 1:2354

################  wuhan "2015-01-26"  #################


head <- wuhan[wuhan$Date < "2015-01-26" ,]
tail <- wuhan[wuhan$Date > "2015-01-26" ,]
x<- head[head$Date == "2015-01-25" ,]
y<- tail[tail$Date == "2015-01-27" ,]
colMeans(rbind(x,y)[1:2,c(2,4,5,6,7,8,9)])

z<-data.frame(Date=c(as.Date("2015-01-26")), 
              AQI=209,level = "ÖØ¶ÈÎÛÈ¾",PM25=168,PM10=32.5,SO2=19.5,CO=1.85,NO2=47.5,O3_8h=44.5)
wuhan <- rbind(rbind(head,z),tail)
rownames(wuhan) <- 1:2354

################## changsha   "2015-01-26" "2015-02-01" ###############

head <- changsha[changsha$Date < "2015-01-26"  ,]
tail <- changsha[changsha$Date > "2015-01-26"  ,]
x<- head[head$Date == "2015-01-25" ,]
y<- tail[tail$Date == "2015-01-27" ,]
colMeans(rbind(x,y)[1:2,c(2,4,5,6,7,8,9)])

z<-data.frame(Date=c(as.Date("2015-01-26")), 
              AQI=189,level = "ÖÐ¶ÈÎÛÈ¾",PM25=149.5,PM10=57.5,SO2=20.5,CO=1.6,NO2=47.5,O3_8h=27.5)
changsha<- rbind(rbind(head,z),tail)


head <- changsha[changsha$Date <  "2015-02-01",]
tail <- changsha[changsha$Date >  "2015-02-01",]
x<- head[head$Date == "2015-01-31",]
y<- tail[tail$Date == "2015-02-02",]
colMeans(rbind(x,y)[1:2,c(2,4,5,6,7,8,9)])

z<-data.frame(Date=c(as.Date("2015-02-01")), 
              AQI=97.5,level = "Á¼",PM25=73.5,PM10=18.5,SO2=15.5,CO=1.2,NO2=41,O3_8h=25.5)
changsha<- rbind(rbind(head,z),tail)

rownames(changsha) <- 1:2354




################### find zero or NA data ##########################

# beijing 2016-09-06


head <- beijing[beijing$Date < "2016-09-06",]
tail <- beijing[beijing$Date > "2016-09-06",]
x<- head[head$Date == "2016-09-05",]
y<- tail[tail$Date == "2016-09-07",]
colMeans(rbind(x,y)[1:2,c(2,4,5,6,7,8,9)])

z<-data.frame(Date=c(as.Date("2016-09-9")), 
              AQI=70.5,level = "Á¼",PM25=34,PM10=61.5,SO2=0.6,CO=3.5,NO2=37,O3_8h=119)
beijing[615,1:9] <- z






##################### average data weekly #########################


beijing$isoweek <- format(as.Date(beijing$Date),"%G-W%V")

xian$isoweek <- format(as.Date(xian$Date),"%G-W%V")

shanghai$isoweek <- format(as.Date(shanghai$Date),"%G-W%V")

hangzhou$isoweek <- format(as.Date(hangzhou$Date),"%G-W%V")

guangzhou$isoweek <- format(as.Date(guangzhou$Date),"%G-W%V")

shenzhen$isoweek <- format(as.Date(shenzhen$Date),"%G-W%V")

chengdu$isoweek <- format(as.Date(chengdu$Date),"%G-W%V")

chongqing$isoweek <- format(as.Date(chongqing$Date),"%G-W%V")

wuhan$isoweek <- format(as.Date(wuhan$Date),"%G-W%V")

changsha$isoweek <- format(as.Date(changsha$Date),"%G-W%V")


bj <- beijing[,-3]
xa <- xian[,-3]
sh <- shanghai[,-3]
hz <- hangzhou[,-3]
gz <- guangzhou[,-3]
sz <- shenzhen[,-3]
cd <- chengdu[,-3]
cq <- chongqing[,-3]
wh <- wuhan[,-3]
cs <- changsha[,-3]


bj <- aggregate(bj[, 2:8], list(bj$isoweek), mean)
bj[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(bj)[1] <- "Date" 

xa <- aggregate(xa[, 2:8], list(xa$isoweek), mean)
xa[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(xa)[1] <- "Date" 

sh <- aggregate(sh[, 2:8], list(sh$isoweek), mean)
sh[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(sh)[1] <- "Date" 

hz <- aggregate(hz[, 2:8], list(hz$isoweek), mean)
hz[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(hz)[1] <- "Date" 

gz <- aggregate(gz[, 2:8], list(gz$isoweek), mean)
gz[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(gz)[1] <- "Date" 

sz <- aggregate(sz[, 2:8], list(sz$isoweek), mean)
sz[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(sz)[1] <- "Date" 

cd <- aggregate(cd[, 2:8], list(cd$isoweek), mean)
cd[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(cd)[1] <- "Date" 

cq <- aggregate(cq[, 2:8], list(cq$isoweek), mean)
cq[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(cq)[1] <- "Date" 

wh <- aggregate(wh[, 2:8], list(wh$isoweek), mean)
wh[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(wh)[1] <- "Date" 

cs <- aggregate(cs[, 2:8], list(cs$isoweek), mean)
cs[1] <- seq(as.Date('2015-01-01'), as.Date('2021-06-11'), by = "7 days")
colnames(cs)[1] <- "Date" 


######################## Visualization ######################
library("ggpubr")
par(mfrow=c(1,1))

p1<- ggplot(wh, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p2<-ggplot(cs, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p3<-ggplot(bj, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p4<-ggplot(xa, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p5<-ggplot(sh, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p6<-ggplot(hz, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p7<-ggplot(gz, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p8<-ggplot(sz, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p9<-ggplot(cq, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p10<-ggplot(cd, aes(x=Date)) + 
  geom_line(aes(y = PM25))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                   labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                   font.label = list(size = 10),
                   ncol = 2, nrow = 5)
figure



p1<- ggplot(wh, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p2<-ggplot(cs, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p3<-ggplot(bj, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p4<-ggplot(xa, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p5<-ggplot(sh, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p6<-ggplot(hz, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p7<-ggplot(gz, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p8<-ggplot(sz, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p9<-ggplot(cq, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p10<-ggplot(cd, aes(x=Date)) + 
  geom_line(aes(y = PM10))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure





p1<- ggplot(wh, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p2<-ggplot(cs, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p3<-ggplot(bj, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p4<-ggplot(xa, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p5<-ggplot(sh, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p6<-ggplot(hz, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p7<-ggplot(gz, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p8<-ggplot(sz, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p9<-ggplot(cq, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p10<-ggplot(cd, aes(x=Date)) + 
  geom_line(aes(y = SO2))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure



p1<- ggplot(wh, aes(x=Date)) + 
  geom_line(aes(y = CO))

p2<-ggplot(cs, aes(x=Date)) + 
  geom_line(aes(y = CO))

p3<-ggplot(bj, aes(x=Date)) + 
  geom_line(aes(y = CO))

p4<-ggplot(xa, aes(x=Date)) + 
  geom_line(aes(y = CO))

p5<-ggplot(sh, aes(x=Date)) + 
  geom_line(aes(y = CO))

p6<-ggplot(hz, aes(x=Date)) + 
  geom_line(aes(y = CO))

p7<-ggplot(gz, aes(x=Date)) + 
  geom_line(aes(y = CO))

p8<-ggplot(sz, aes(x=Date)) + 
  geom_line(aes(y = CO))

p9<-ggplot(cq, aes(x=Date)) + 
  geom_line(aes(y = CO))

p10<-ggplot(cd, aes(x=Date)) + 
  geom_line(aes(y = CO))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure






p1<- ggplot(wh, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p2<-ggplot(cs, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p3<-ggplot(bj, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p4<-ggplot(xa, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p5<-ggplot(sh, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p6<-ggplot(hz, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p7<-ggplot(gz, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p8<-ggplot(sz, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p9<-ggplot(cq, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p10<-ggplot(cd, aes(x=Date)) + 
  geom_line(aes(y = NO2))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure



p1<- ggplot(wh, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p2<-ggplot(cs, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p3<-ggplot(bj, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p4<-ggplot(xa, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p5<-ggplot(sh, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p6<-ggplot(hz, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p7<-ggplot(gz, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p8<-ggplot(sz, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p9<-ggplot(cq, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p10<-ggplot(cd, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure



p1<- ggplot(wh, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p2<-ggplot(cs, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p3<-ggplot(bj, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p4<-ggplot(xa, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p5<-ggplot(sh, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p6<-ggplot(hz, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p7<-ggplot(gz, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p8<-ggplot(sz, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p9<-ggplot(cq, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p10<-ggplot(cd, aes(x=Date)) + 
  geom_line(aes(y = AQI))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure


write.csv(bj,"B:/codework/study/adss 504/finalinput/wbeijing.csv", row.names = FALSE)
write.csv(xa,"B:/codework/study/adss 504/finalinput/wxian.csv", row.names = FALSE)
write.csv(sh,"B:/codework/study/adss 504/finalinput/wshanghai.csv", row.names = FALSE)
write.csv(hz,"B:/codework/study/adss 504/finalinput/whangzhou.csv", row.names = FALSE)
write.csv(gz,"B:/codework/study/adss 504/finalinput/wguangzhou.csv", row.names = FALSE)
write.csv(sz,"B:/codework/study/adss 504/finalinput/wshenzhen.csv", row.names = FALSE)
write.csv(cq,"B:/codework/study/adss 504/finalinput/wchongqing.csv", row.names = FALSE)
write.csv(cd,"B:/codework/study/adss 504/finalinput/wchengdu.csv", row.names = FALSE)
write.csv(wh,"B:/codework/study/adss 504/finalinput/wwuhan.csv", row.names = FALSE)
write.csv(cs,"B:/codework/study/adss 504/finalinput/wchangsha.csv", row.names = FALSE)






##################### average data monthly #########################




beijing$ym <- format(as.Date(beijing$Date),"%Y-%m")

xian$ym <- format(as.Date(xian$Date),"%Y-%m")

shanghai$ym <- format(as.Date(shanghai$Date),"%Y-%m")

hangzhou$ym <- format(as.Date(hangzhou$Date),"%Y-%m")

guangzhou$ym <- format(as.Date(guangzhou$Date),"%Y-%m")

shenzhen$ym <- format(as.Date(shenzhen$Date),"%Y-%m")

chengdu$ym <- format(as.Date(chengdu$Date),"%Y-%m")

chongqing$ym <- format(as.Date(chongqing$Date),"%Y-%m")

wuhan$ym <- format(as.Date(wuhan$Date),"%Y-%m")

changsha$ym <- format(as.Date(changsha$Date),"%Y-%m")


mbj <- beijing[,c(-3,-10)]
mxa <- xian[,c(-3,-10)]
msh <- shanghai[,c(-3,-10)]
mhz <- hangzhou[,c(-3,-10)]
mgz <- guangzhou[,c(-3,-10)]
msz <- shenzhen[,c(-3,-10)]
mcd <- chengdu[,c(-3,-10)]
mcq <- chongqing[,c(-3,-10)]
mwh <- wuhan[,c(-3,-10)]
mcs <- changsha[,c(-3,-10)]

require(lubridate)

mbj <- aggregate(mbj[, 2:8], list(mbj$ym), mean)
colnames(mbj)[1] <- "Date" 
mbj$Date <- lubridate::parse_date_time(mbj$Date,"Ym")

mxa <- aggregate(mxa[, 2:8], list(mxa$ym), mean)
colnames(mxa)[1] <- "Date" 
mxa$Date <- lubridate::parse_date_time(mxa$Date,"Ym")

msh <- aggregate(msh[, 2:8], list(msh$ym), mean)
colnames(msh)[1] <- "Date" 
msh$Date <- lubridate::parse_date_time(msh$Date,"Ym")

mhz <- aggregate(mhz[, 2:8], list(mhz$ym), mean)
colnames(mhz)[1] <- "Date" 
mhz$Date <- lubridate::parse_date_time(mhz$Date,"Ym") 

mgz <- aggregate(mgz[, 2:8], list(mgz$ym), mean)
colnames(mgz)[1] <- "Date" 
mgz$Date <- lubridate::parse_date_time(mgz$Date,"Ym")

msz <- aggregate(msz[, 2:8], list(msz$ym), mean)
colnames(msz)[1] <- "Date" 
msz$Date <- lubridate::parse_date_time(msz$Date,"Ym") 

mcd <- aggregate(mcd[, 2:8], list(mcd$ym), mean)
colnames(mcd)[1] <- "Date" 
mcd$Date <- lubridate::parse_date_time(mcd$Date,"Ym") 

mcq <- aggregate(mcq[, 2:8], list(mcq$ym), mean)
colnames(mcq)[1] <- "Date" 
mcq$Date <- lubridate::parse_date_time(mcq$Date,"Ym")

mwh <- aggregate(mwh[, 2:8], list(mwh$ym), mean)
colnames(mwh )[1] <- "Date" 
mwh $Date <- lubridate::parse_date_time(mwh $Date,"Ym")

mcs <- aggregate(mcs[, 2:8], list(mcs$ym), mean)
colnames(mcs)[1] <- "Date" 
mcs$Date <- lubridate::parse_date_time(mcs$Date,"Ym")



######################## Visualization ######################
library("ggpubr")
par(mfrow=c(1,1))

p1<- ggplot(mwh, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p2<-ggplot(mcs, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p3<-ggplot(mbj, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p4<-ggplot(mxa, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p5<-ggplot(msh, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p6<-ggplot(mhz, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p7<-ggplot(mgz, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p8<-ggplot(msz, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p9<-ggplot(mcq, aes(x=Date)) + 
  geom_line(aes(y = PM25))

p10<-ggplot(mcd, aes(x=Date)) + 
  geom_line(aes(y = PM25))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure



p1<- ggplot(mwh, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p2<-ggplot(mcs, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p3<-ggplot(mbj, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p4<-ggplot(mxa, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p5<-ggplot(msh, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p6<-ggplot(mhz, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p7<-ggplot(mgz, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p8<-ggplot(msz, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p9<-ggplot(mcq, aes(x=Date)) + 
  geom_line(aes(y = PM10))

p10<-ggplot(mcd, aes(x=Date)) + 
  geom_line(aes(y = PM10))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure





p1<- ggplot(mwh, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p2<-ggplot(mcs, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p3<-ggplot(mbj, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p4<-ggplot(mxa, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p5<-ggplot(msh, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p6<-ggplot(mhz, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p7<-ggplot(mgz, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p8<-ggplot(msz, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p9<-ggplot(mcq, aes(x=Date)) + 
  geom_line(aes(y = SO2))

p10<-ggplot(mcd, aes(x=Date)) + 
  geom_line(aes(y = SO2))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure



p1<- ggplot(mwh, aes(x=Date)) + 
  geom_line(aes(y = CO))

p2<-ggplot(mcs, aes(x=Date)) + 
  geom_line(aes(y = CO))

p3<-ggplot(mbj, aes(x=Date)) + 
  geom_line(aes(y = CO))

p4<-ggplot(mxa, aes(x=Date)) + 
  geom_line(aes(y = CO))

p5<-ggplot(msh, aes(x=Date)) + 
  geom_line(aes(y = CO))

p6<-ggplot(mhz, aes(x=Date)) + 
  geom_line(aes(y = CO))

p7<-ggplot(mgz, aes(x=Date)) + 
  geom_line(aes(y = CO))

p8<-ggplot(msz, aes(x=Date)) + 
  geom_line(aes(y = CO))

p9<-ggplot(mcq, aes(x=Date)) + 
  geom_line(aes(y = CO))

p10<-ggplot(mcd, aes(x=Date)) + 
  geom_line(aes(y = CO))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure






p1<- ggplot(mwh, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p2<-ggplot(mcs, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p3<-ggplot(mbj, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p4<-ggplot(mxa, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p5<-ggplot(msh, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p6<-ggplot(mhz, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p7<-ggplot(mgz, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p8<-ggplot(msz, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p9<-ggplot(mcq, aes(x=Date)) + 
  geom_line(aes(y = NO2))

p10<-ggplot(mcd, aes(x=Date)) + 
  geom_line(aes(y = NO2))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure



p1<- ggplot(mwh, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p2<-ggplot(mcs, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p3<-ggplot(mbj, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p4<-ggplot(mxa, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p5<-ggplot(msh, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p6<-ggplot(mhz, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p7<-ggplot(mgz, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p8<-ggplot(msz, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p9<-ggplot(mcq, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))

p10<-ggplot(mcd, aes(x=Date)) + 
  geom_line(aes(y = O3_8h))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure



p1<- ggplot(mwh, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p2<-ggplot(mcs, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p3<-ggplot(mbj, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p4<-ggplot(mxa, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p5<-ggplot(msh, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p6<-ggplot(mhz, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p7<-ggplot(mgz, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p8<-ggplot(msz, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p9<-ggplot(mcq, aes(x=Date)) + 
  geom_line(aes(y = AQI))

p10<-ggplot(mcd, aes(x=Date)) + 
  geom_line(aes(y = AQI))



figure <- ggarrange(p1, p2, p3, p4, p5, p6,p7,p8,p9,p10,
                    labels = c("wuhan","changsha","beijing","xian","shanghai","hangzhou","guangzhou","shenzhen","chongqing","chengdu"),
                    font.label = list(size = 10),
                    ncol = 2, nrow = 5)
figure


write.csv(mbj,"B:/codework/study/adss 504/finalinput/mbeijing.csv", row.names = FALSE)
write.csv(mxa,"B:/codework/study/adss 504/finalinput/mxian.csv", row.names = FALSE)
write.csv(msh,"B:/codework/study/adss 504/finalinput/mshanghai.csv", row.names = FALSE)
write.csv(mhz,"B:/codework/study/adss 504/finalinput/mhangzhou.csv", row.names = FALSE)
write.csv(mgz,"B:/codework/study/adss 504/finalinput/mguangzhou.csv", row.names = FALSE)
write.csv(msz,"B:/codework/study/adss 504/finalinput/mshenzhen.csv", row.names = FALSE)
write.csv(mcq,"B:/codework/study/adss 504/finalinput/mchongqing.csv", row.names = FALSE)
write.csv(mcd,"B:/codework/study/adss 504/finalinput/mchengdu.csv", row.names = FALSE)
write.csv(mwh,"B:/codework/study/adss 504/finalinput/mwuhan.csv", row.names = FALSE)
write.csv(mcs,"B:/codework/study/adss 504/finalinput/mchangsha.csv", row.names = FALSE)















