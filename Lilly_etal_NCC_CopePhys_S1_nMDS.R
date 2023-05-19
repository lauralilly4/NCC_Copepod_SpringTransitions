########################################
##  NOAA/OSU post-doc (NCC Copepods)
##  Step 1: Run nMDS of copepod spp.
##  Laura E. Lilly
##  Updated: 18 May 2023
########################################
# Data are from Newport Hydro Line (NHL):
#   - *Year-day dates*
#   - 36 major spp -> already log(0.1+bm)+ transformed by C.A. Morgan
#   - includes data from JSOES cruises


library(vegan)  # For nMDS

# Load datafile
nhfl <- read.csv('NH05_CopeDens_log_subSpp_1996_2020.csv')


# ### Step 1: Combine date columns and create new dataframe
dtfl <- data.frame(nhfl[,3],nhfl[,1],nhfl[,2])
colnames(dtfl) <- c(colnames(nhfl[3]),colnames(nhfl[1]),colnames(nhfl[2]))
dtvec <- as.Date(with(dtfl,paste(dtfl$Year,dtfl$Mon,dtfl$Day,sep="-")),"%Y-%m-%d")
sppsub <- data.frame(dtvec,nhfl[,5:ncol(nhfl)]) 


# ### Step 2: Run nMDS
# Get only rows (dates) with *some* non-zero spp
sppnonzro <- sppsub[rowSums(sppsub[,2:ncol(sppsub)])>0,2:ncol(sppsub)]

# Get corresponding 'Dates' vector (to reapply after nMDS)
dtsnonzro <- sppsub[rowSums(sppsub[,2:ncol(sppsub)])>0,1]


##### Average all dulicate values for each date 
dtsnonzrounq <- unique(dtsnonzro)

sppdtavg <- data.frame(matrix(nrow=length(dtsnonzrounq),ncol=ncol(sppnonzro)))
for(d in 1:length(dtsnonzrounq)){
  dtid <- which(dtsnonzro %in% dtsnonzrounq[d])
  sppavg <- colMeans(sppnonzro[dtid,])
  sppdtavg[d,] <- sppavg
}
rownames(sppdtavg) <- dtsnonzrounq
colnames(sppdtavg) <- colnames(sppnonzro)


# Run nMDS calculations
spp_nmds <- metaMDS(sppdtavg,trymax=100,k=3) 


# ### Step 4: Plot nMDS ordinations and save scores
# Plot 4a: Stress plot
dev.new(width=8,height=20)
stressplot(spp_nmds)

# Plot 4b: nMDS ordination scatter
dev.new(width=8,height=20)
ordiplot(spp_nmds,type="n",xlim=c(-1.5,1),ylim=c(-1,1))
orditorp(spp_nmds,display="species",col="blue",air=0.01,cex=1)


# # Save nMDS scores
write.csv(data.frame(scores(spp_nmds)),'NH05_Cope_biom_MDSscore_v4_CAM_RawDts.csv')

