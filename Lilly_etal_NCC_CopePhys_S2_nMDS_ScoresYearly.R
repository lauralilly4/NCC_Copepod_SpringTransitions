########################################
##  NOAA/OSU post-doc (NCC Copepods)
##  Step 2: Plot nMDS yearly scores
##  Laura E. Lilly
##  Updated: 18 May 2023
########################################
# From saved file ('Lilly_etal_NCC_CopePhys_S1_nMDS):
#   -> plot yearly timeseries of nMDS scores


library(lubridate)

# Open datafile
scrfl <- read.csv('NH05_Cope_biom_MDSscore_v4_CAM_RawDts.csv')


# ### Step 0: Convert file days -> R Dates
scrdtfrm <- data.frame(scrfl[,3],scrfl[,1],scrfl[,2])
scrdts <- as.Date(with(scrdtfrm,paste(scrfl[,3],scrfl[,1],scrfl[,2],sep="-")),format="%Y-%m-%d")
scrtbl <- cbind(scrdts,scrfl[,4:6])


# ### Step 1: Create daily-resolution time structure
stdt <- as.Date(paste(min(scrfl[,3]),01,01,sep="-"),format="%Y-%m-%d")
endt <- as.Date(paste(max(scrfl[,3]),12,31,sep="-"),format="%Y-%m-%d")
mstrdt <- seq(stdt,endt,by="day")

# Remove Leap Days -> to make every timeseries the same length
lpdt <- format(as.Date(paste(2012,02,29,sep='-')),"%m-%d")
mstrmd <- format(mstrdt,"%m-%d")
lpidx <- which(mstrmd %in% lpdt)
mstrdt <- mstrdt[-lpidx]


# ### Step 2: Slot actual copepod data points into larger timeseries
# ***If a sample exists for a Leap Day, pause to deal with it
mstrdayall <- data.frame(mstrdt,matrix(nrow=length(mstrdt),ncol=ncol(scrtbl)-1))
sppidx <- vector(length=nrow(scrtbl))

for(dn in 1:nrow(scrtbl)){
  midx =  which(mstrdayall[,1] == scrtbl[dn,1])
  if(length(midx) == 0){
    print(scrtbl[dn,1])
    continue =  FALSE
  } else {
    continue =  TRUE
  }
  mstrdayall[midx,] = scrtbl[dn,]
  sppidx[dn] =  midx
}
names(mstrdayall) =  names(scrtbl)



# ### Step 3: Plot yearly timeseries for each nMDS score
scrin <- readline(prompt = "Which nMDS dimension?")

# S3.1: Create Jan. 1 timeseries and find indices of 'mstrdayall' that match
jan1s <- seq(mstrdt[1],as.Date("2020-01-01"),by="year")
idxj1 <- which(mstrdayall[,1] %in% jan1s)
idxend <- c(idxj1[2:length(idxj1)]-1,nrow(mstrdayall))

# S3.2: Get data.frame of year-long chunks for selected species
yrsunq <- unique(format(as.Date(mstrdayall[,1]),"%Y"))
dtswk <- format(as.Date(mstrdayall[,1]),"%m-%d")
wksunq <- unique(dtswk)
# Also get indices of Day 1 of each month -> for plotting purposes (below)
mostunq <- unique(floor_date(mstrdayall[1:365,1], unit = "month"))
mostidx <- which(mstrdayall[,1] %in% mostunq)
mostdt <- format(as.Date(mostunq),"%m-%d")


# For-loop to select each year-chunk
scrchnks <- data.frame(matrix(nrow=length(yrsunq),ncol=length(wksunq)))
for(jx in 1:length(idxj1)){
  chnk = mstrdayall[idxj1[jx]:idxend[jx],as.numeric(scrin)+1]
  scrchnks[jx,] = chnk
}
rownames(scrchnks) <- yrsunq
colnames(scrchnks) <- wksunq




# ### Step 4: Plot all year-chunks of scores
## Color Scheme  -> four categories
symc <- c(15,16,17,18,12,3,4,8)
colel <- "orangered"
colwm <- "orange2"
colcd <- "skyblue"
colla <- "royalblue"
colnu <- "grey50"

# Set up color/symbol scheme based on year-classification (El Nino, La Nina
#           warm, cool, neutral)
#            1996,  1997,   1998,   1999,   2000,   2001,   2002,  
symsall <- c(symc[1],symc[1],symc[1],symc[1],symc[2],symc[1],symc[2],
            # 2003, 2004,   2005,   2006,   2007,   2008,   2009,
            symc[2],symc[2],symc[3],symc[3],symc[3],symc[3],symc[4],
            # 2010, 2011,   2012,   2013,   2014,   2015,   2016, 
            symc[2],symc[4],symc[5],symc[4],symc[5],symc[4],symc[3],
            # 2017, 2018,   2019,   2020
            symc[6],symc[6],symc[7],symc[7])
colsall <- c(colwm,colnu,colel,colla,colla,colcd,colcd,
            colwm,colnu,colwm,colcd,colnu,colla,colcd,
            colel,colla,colcd,colnu,colnu,colwm,colel,
            colnu,colcd,colnu,colcd)

# Delineate for NH05 vs. NH25
if(yrsunq[1] == 1996){
  symspal = symsall
  colspal = colsall
} else if(yrsunq[1] == 1998){
  symspal = symsall[3:length(symsall)]
  colspal = colsall[3:length(colsall)]
}


# PLOT all yearly points
dev.new()
# plot(gam10,ylim=c(-1.2,1.2),xlab='',ylab='',xaxt='n',yaxt='n',bty='n',lwd=2,cex.axis = 1.7)
plot(seq(1,ncol(scrchnks),1),scrchnks[1,],pch=symspal[1],col=colspal[1],ylim=c(-1.5,1.5),xlab='',ylab='',xaxt='n',yaxt='n',bty='n',cex.axis = 1.7)
axis(1,labels=FALSE,tick=FALSE)
for(pu in 2:nrow(scrchnks)){
  points(seq(1,ncol(scrchnks),1),scrchnks[pu,],pch=symspal[pu],col=colspal[pu],cex=1)
}
lines(seq(1,ncol(scrchnks),1),rep(0,ncol(scrchnks)),col='grey50')
axis(1,at=mostidx,labels=mostdt,cex.axis=1.7,las=2)
axis(2,at=seq(-1,1,0.5),labels=c("-1","","0","","1"),cex.axis=1.7)
legend("topright",legend=c(as.character(yrsunq)),col=colspal,pch=symspal,ncol=6)


