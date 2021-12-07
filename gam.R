require(ggplot2)
require(mgcv)
require(forecast)
library(readxl)
library(GGally)


setwd("B:/codework/study/adss 504/finalinput/")
file.list <- list.files(pattern='*.xls')
df.list <- lapply(file.list, read_excel)
library(dplyr)
df <- bind_rows(df.list)
df$Date <- seq(as.Date('2015-01-01'), as.Date('2020-12-01'), by = "months")


###########################check weekly data model#############################




ggplot(data = wh, aes(x=Date))+
        geom_line(aes(y=NO2))+
        geom_point(aes(y=NO2))


ggplot(data = mwh, aes(x=Date))+
        geom_line(aes(y=NO2))+
        geom_point(aes(y=NO2))


        ####time series model####
# using tslm to find the trend
fdtrend <-function(x){
    temp <- x[ as.Date(x$Date) <= as.Date("2020-12-01"),]
    
    myts <- ts(x$NO2, frequency=12, start = c(2015, 01), end = c(2019, 12))
    myts_month <- decompose(myts)
    plot(myts_month$trend)
}
fdtrend(mbj)
fdtrend(mxa)
fdtrend(msh)
fdtrend(mhz)
fdtrend(mgz)
fdtrend(msz)
fdtrend(mcq)
fdtrend(mcd)
fdtrend(mwh)
fdtrend(mcs)


#and look the forecasting if the emission control policy renain the same
my_df_ts <- data.frame(NO2 = myts, as.numeric(time(myts)))
names(my_df_ts) <- c("NO2", "time")
mymodel <- tslm(NO2~season+trend,my_df_ts)
my_fc <- forecast(mymodel,h=24)
autoplot(my_fc)
checkresiduals(mymodel)

auto.arima(temp$NO2, max.p = 4, max.q = 4, max.d = 4)
ammod <- arima(temp$NO2, order = c(3,0,1))
ammod
#Forecasting
fc1 <- predict(ammod, n.ahead = 10)
fc1$pred
plot(temp$NO2,xlim = c(0,80))
lines(temp$NO2,col='red')
lines(fc1$pred,col='darkblue')
points(fc1$pred)





whmete1 <- df[,c(32,6,14,30)]
colnames(whmete1) <- c("date","temperature","windspeed","precipitation")
whmete1$temperature <- as.numeric(whmete1$temperature)
whmete1$windspeed <- as.numeric(whmete1$windspeed)
whmete1$precipitation <- as.numeric(whmete1$precipitation)
whfull1 <- cbind(temp,whmete1)
whfull1 <- whfull1[1:64,]
whfull1$ndate <- as.numeric(time(whfull1$Date))

temp <- mwh[ as.Date(mwh$Date) < as.Date("2020-01-01"),]
temp$month <- as.numeric(format(temp$Date,"%m"))
temp$ndate <- as.numeric(time(temp$Date))   
whmete2 <- whmete1[ whmete1$date<as.Date("2020-01-01"),]
whfull2 <- cbind(temp,whmete2)
whfull2$ndate <- as.numeric(time(whfull2$Date))
        






whmod <- gam(NO2 ~ s(month, bs = 'cc',k = 12)+s(ndate) ,method = "REML", data = temp)
summary(whmod)
par(mfrow=c(2,2))
gam.check(whmod,pch=20)

ggpairs(whfull2[,c(7,12,13,14)])

whmod2 <- gam(NO2 ~ s(month, bs = 'cc',k = 12) + s(ndate)+
                      precipitation+windspeed+temperature,
                        method = "REML", data = whfull2)
summary(whmod2)
par(mfrow=c(2,2))
gam.check(whmod2,pch=20)


whmod3 <- gam(NO2 ~ s(month, bs = 'cc',k = 12) +s(ndate)+
                      windspeed+temperature,
              method = "REML", data = whfull2)
summary(whmod3)
par(mfrow=c(2,2))
gam.check(whmod3,pch=20)

whmod4 <- gam(NO2 ~ s(month, bs = 'cc',k = 12) + s(ndate)+
                        s(precipitation)+s(windspeed)+s(temperature),
                method = "REML", data = whfull2)
summary(whmod4)
par(mfrow=c(2,2))
gam.check(whmod4,pch=20)


whmod5 <- gam(NO2 ~ s(month, bs = 'cc',k = 12) + s(ndate)+
            s(windspeed)+s(temperature),
    method = "REML", data = whfull2)

whmod6 <- gam(NO2 ~ s(month, bs = 'cc',k = 12) + s(ndate)+
                  s(precipitation)+windspeed+temperature,
              method = "REML", data = whfull2)


logLik.gam(whmod)
logLik.gam(whmod2)
logLik.gam(whmod3)
logLik.gam(whmod4)
logLik.gam(whmod5)
logLik.gam(whmod6)

whmod$aic
whmod2$aic
whmod3$aic
whmod4$aic
whmod5$aic
whmod6$aic



## Create a sequence of x values for which to predict from the fitted model
xp <- whfull1[as.Date(whfull1$Date)<=as.Date("2020-04-01"),]
xp$month <- as.numeric(format(xp$Date,"%m"))
xp$ndate <- as.numeric(time(xp$Date))
## predict from model (this is the mean of our model)
preds <- predict.gam(whmod4,newdata=xp)
preds[61:64]

ndate <- as.numeric(time(seq(as.Date('2015-01-01'), as.Date('2020-04-01'), by = "months")))
pred <- cbind(ndate ,preds)

pred

whfull1 <- merge(whfull1,pred, by="ndate", all = T)

plot(whfull1$Date,whfull1$NO2)
lines(whfull1$Date,whfull1$NO2,col='red')
lines(whfull1$Date,whfull1$pred,col='darkblue')




predict_gam <- function(x){
        temp <- x[ as.Date(x$Date) < as.Date("2020-01-01"),]
        temp$month <- as.numeric(format(temp$Date,"%m"))
        temp$ndate <- as.numeric(time(temp$Date))  
        mod <- gam(NO2 ~ s(month, bs = 'cc',k = 12) + s(ndate),
                      method = "REML", data = temp)
        
        
        temp <- x[ as.Date(x$Date) <= as.Date("2020-04-01"),]
        xp <- temp[as.Date(temp$Date)<=as.Date("2020-04-01"),]
        xp$month <- as.numeric(format(xp$Date,"%m"))
        xp$ndate <- as.numeric(time(xp$Date))
        
        pd <- predict(mod, xp, type = "link", se.fit = TRUE)
        
        temp$pd <- pd$fit
        
        
        upr <- pd$fit + (2 * pd$se.fit)
        lwr <- pd$fit - (2 * pd$se.fit)
        
        temp$upr <- upr
        temp$lwr <- lwr
        
        
        plot(temp$Date,temp$NO2)
        lines(temp$Date,temp$NO2,col='red')
        lines(temp$Date,temp$upr,lty = "dashed")
        lines(temp$Date,temp$pd,col='darkblue')
        lines(temp$Date,temp$lwr,lty = "dashed")

        print(temp$NO2[61:64])
        print(temp$pd[61:64])
        return(mod)
}


predict_gam(mbj)
predict_gam(mxa)
predict_gam(msh)
predict_gam(mhz)
predict_gam(mgz)
predict_gam(msz)
predict_gam(mcq)
predict_gam(mcd)
predict_gam(mwh)
predict_gam(mcs)




###########################check weekly data model#############################

temp <- wh[ as.Date(wh$Date) < as.Date("2020-01-23"),]
temp$month <- as.numeric(format(temp$Date,"%m"))
temp$ndate <- as.numeric(time(temp$Date))  
whweeklymod <- gam(NO2 ~ s(month, bs = 'cc',k = 12) + s(ndate),
                   method = "REML", data = temp)


predict_weeklygam <- function(x){
        temp <- x[ as.Date(x$Date) < as.Date("2020-01-23"),]
        temp$month <- as.numeric(format(temp$Date,"%m"))
        temp$ndate <- as.numeric(time(temp$Date))  
        mod <- gam(NO2 ~ s(month, bs = 'cc',k = 12) + s(ndate),
                   method = "REML", data = temp)
        
        
        temp <- x[ as.Date(x$Date) <= as.Date("2020-04-09"),]
        xp <- temp[as.Date(temp$Date)<=as.Date("2020-04-09"),]
        xp$month <- as.numeric(format(xp$Date,"%m"))
        xp$ndate <- as.numeric(time(xp$Date))
        
        pd <- predict(mod, xp, type = "link", se.fit = TRUE)
        
        temp$pd <- pd$fit
        
        
        upr <- pd$fit + (2 * pd$se.fit)
        lwr <- pd$fit - (2 * pd$se.fit)
        
        temp$upr <- upr
        temp$lwr <- lwr
        
        
        plot(temp$Date,temp$NO2)
        lines(temp$Date,temp$NO2,col='red')
        lines(temp$Date,temp$upr,lty = "dashed")
        lines(temp$Date,temp$pd,col='darkblue')
        lines(temp$Date,temp$lwr,lty = "dashed")
        
        print(temp$NO2[265:275])
        print(temp$pd[265:275])
}


predict_weeklygam(bj)
predict_weeklygam(xa)
predict_weeklygam(sh)
predict_weeklygam(hz)
predict_weeklygam(gz)
predict_weeklygam(sz)
predict_weeklygam(cq)
predict_weeklygam(cd)
predict_weeklygam(wh)
predict_weeklygam(cs)









