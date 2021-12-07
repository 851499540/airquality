require(tidyr)
require(tidyverse)
require(ggplot2)
require(lubridate)
########################## get the period (in 2020) and (mean between 2015-2019)###############


beijing1 <- beijing[ (beijing$Date>as.Date("2020-1-23"))& (beijing$Date<=as.Date("2020-4-8")),]
xian1<- xian[ (xian$Date>as.Date("2020-1-23")) & (xian$Date<= as.Date("2020-4-8")),]
shanghai1<- shanghai[(shanghai$Date>as.Date("2020-1-23"))& (shanghai$Date<=as.Date("2020-4-8")),]
hangzhou1<- hangzhou[(hangzhou$Date>as.Date("2020-1-23"))& (hangzhou$Date<=as.Date("2020-4-8")),]
guangzhou1<- guangzhou[(guangzhou$Date>as.Date("2020-1-23"))& (guangzhou$Date<=as.Date("2020-4-8")),]
shenzhen1<- shenzhen[(shenzhen$Date>as.Date("2020-1-23"))& (shenzhen$Date<=as.Date("2020-4-8")),]
chongqing1<- chongqing[(chongqing$Date>as.Date("2020-1-23"))& (chongqing$Date<=as.Date("2020-4-8")),]
chengdu1<- chengdu[(chengdu$Date>as.Date("2020-1-23"))& (chengdu$Date<=as.Date("2020-4-8")),]
wuhan1<- wuhan[(wuhan$Date>as.Date("2020-1-23"))& (wuhan$Date<=as.Date("2020-4-8")),]
changsha1<- changsha[(changsha$Date>as.Date("2020-1-23"))& (changsha$Date<=as.Date("2020-4-8")),]


beijing2 <- beijing[ (beijing$Date<as.Date("2020-1-1")),]
xian2<- xian[ (xian$Date< as.Date("2020-1-1")),]
shanghai2<- shanghai[(shanghai$Date<as.Date("2020-1-1")),]
hangzhou2<- hangzhou[(hangzhou$Date<as.Date("2020-1-1")),]
guangzhou2<- guangzhou[(guangzhou$Date<as.Date("2020-1-1")),]
shenzhen2<- shenzhen[(shenzhen$Date<as.Date("2020-1-1")),]
chongqing2<- chongqing[(chongqing$Date<as.Date("2020-1-1")),]
chengdu2<- chengdu[(chengdu$Date<as.Date("2020-1-1")),]
wuhan2<- wuhan[(wuhan$Date<as.Date("2020-1-1")),]
changsha2<- changsha[(changsha$Date<as.Date("2020-1-1")),]

beijing2$md <- format(beijing2$Date,"%m-%d")
xian2$md <- format(xian2$Date,"%m-%d")
shanghai2$md <- format(shanghai2$Date,"%m-%d")
hangzhou2$md <- format(hangzhou2$Date,"%m-%d")
guangzhou2$md <- format(guangzhou2$Date,"%m-%d")
shenzhen2$md <- format(shenzhen2$Date,"%m-%d")
chongqing2$md <- format(chongqing2$Date,"%m-%d")
chengdu2$md <- format(chengdu2$Date,"%m-%d")
wuhan2$md <- format(wuhan2$Date,"%m-%d")
changsha2$md <- format(changsha2$Date,"%m-%d")

beijing2<-aggregate(beijing2[, 2:8], list(beijing2$md), mean)
xian2<-aggregate(xian2[, 2:8], list(xian2$md), mean)
shanghai2<-aggregate(shanghai2[, 2:8], list(shanghai2$md), mean)
hangzhou2<-aggregate(hangzhou2[, 2:8], list(hangzhou2$md), mean)
guangzhou2<-aggregate(guangzhou2[, 2:8], list(guangzhou2$md), mean)
shenzhen2<-aggregate(shenzhen2[, 2:8], list(shenzhen2$md), mean)
chongqing2<-aggregate(chongqing2[, 2:8], list(chongqing2$md), mean)
chengdu2<-aggregate(chengdu2[, 2:8], list(chengdu2$md), mean)
wuhan2<-aggregate(wuhan2[, 2:8], list(wuhan2$md), mean)
changsha2<-aggregate(changsha2[, 2:8], list(changsha2$md), mean)

beijing2<-beijing2[24:99,]
xian2<-xian2[24:99,]
shanghai2<-shanghai2[24:99,]
hangzhou2<-hangzhou2[24:99,]
guangzhou2<-guangzhou2[24:99,]
shenzhen2<-shenzhen2[24:99,]
chongqing2<-chongqing2[24:99,]
chengdu2<-chengdu2[24:99,]
wuhan2<-wuhan2[24:99,]
changsha2<-changsha2[24:99,]



write.csv(beijing1,"B:/codework/study/adss 504/code/bj1.csv", row.names = FALSE)
write.csv(xian1,"B:/codework/study/adss 504/code/xa1.csv", row.names = FALSE)
write.csv(shanghai1,"B:/codework/study/adss 504/code/sh1.csv", row.names = FALSE)
write.csv(hangzhou1,"B:/codework/study/adss 504/code/hz1.csv", row.names = FALSE)
write.csv(guangzhou1,"B:/codework/study/adss 504/code/gz1.csv", row.names = FALSE)
write.csv(shenzhen1,"B:/codework/study/adss 504/code/sz1.csv", row.names = FALSE)
write.csv(chongqing1,"B:/codework/study/adss 504/code/cq1.csv", row.names = FALSE)
write.csv(chengdu1,"B:/codework/study/adss 504/code/cd1.csv", row.names = FALSE)
write.csv(wuhan1,"B:/codework/study/adss 504/code/wh1.csv", row.names = FALSE)
write.csv(changsha1,"B:/codework/study/adss 504/code/cs1.csv", row.names = FALSE)


write.csv(beijing2,"B:/codework/study/adss 504/code/bj2.csv", row.names = FALSE)
write.csv(xian2,"B:/codework/study/adss 504/code/xa2.csv", row.names = FALSE)
write.csv(shanghai2,"B:/codework/study/adss 504/code/sh2.csv", row.names = FALSE)
write.csv(hangzhou2,"B:/codework/study/adss 504/code/hz2.csv", row.names = FALSE)
write.csv(guangzhou2,"B:/codework/study/adss 504/code/gz2.csv", row.names = FALSE)
write.csv(shenzhen2,"B:/codework/study/adss 504/code/sz2.csv", row.names = FALSE)
write.csv(chongqing2,"B:/codework/study/adss 504/code/cq2.csv", row.names = FALSE)
write.csv(chengdu2,"B:/codework/study/adss 504/code/cd2.csv", row.names = FALSE)
write.csv(wuhan2,"B:/codework/study/adss 504/code/wh2.csv", row.names = FALSE)
write.csv(changsha2,"B:/codework/study/adss 504/code/cs2.csv", row.names = FALSE)


par(mar=rep(0,4))
dat = read.csv(text = "city,longitude,latitude
    Beijing,116.4666667,39.9
    Shanghai,121.4833333,31.23333333
    Chongqing,106.5333333,29.53333333
    Xi'an,108.9,34.26666667
    Hangzhou,120.15,30.23333333
    Changsha,113,28.18333333
    Wuhan,114.35,30.61666667
    Chengdu,104.0833333,30.65
    Guangzhou,113.25,23.13333333
    Shenzhen,114.05,22.5431
                ")
library(maps)
library(mapdata)
map("china", xlim = c(100, 130), ylim = c(20,45))
points(dat$longitude, dat$latitude, pch = 19, col = rgb(0, 0, 0, 0.5))
text(dat$longitude, dat$latitude, dat[, 1], cex = 0.7, col = rgb(0,
                                                    0, 1, 1))




