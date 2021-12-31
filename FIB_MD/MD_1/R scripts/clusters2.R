#############
# REMOVE ALL:

rm(list=ls(all=TRUE))
dev.off()
#############

library(readxl)
library(FactoMineR)

setwd("../Original_Dataset/Other_Datasets");
dades <- read.table("Practica_processada.csv",header=T, sep=";")
## names(dd)
## dim(dd)
## summary(dd)

attach(dades)

dades <- data.frame(F_MORTS,F_FERITS_GREUS,F_FERITS_LLEUS,F_VICTIMES,F_UNITATS_IMPLICADES,C_VELOCITAT_VIA)
index <- grep("C_VELOCITAT_VIA", colnames(dades))
missingDataValue <- 100
levels(dades[,index])=c (levels(dades[,index]),missingDataValue)
dades[is.na(dades[index]),index]<-missingDataValue
dades[(dades[,index])=='13',index]<-missingDataValue
dades[(dades[,index])=='Sense Especificar',index]<-missingDataValue
dades[,index] <- as.numeric(dades[,index])

numVariables<- dim(dades)[2]
numRows <- dim(dades)[1]
d <- dist(dades[,])
h1 <- hclust(d,method="ward.D")
plot(h1)
numClustersToTry=60
Ib_array <- vector()

#try finding the best amound of groups
rep.row<-function(x,n){
  matrix(rep(x,each=n),nrow=n)
}
for (i in 2:numClustersToTry) {
  c<- cutree(h1,i)
  dataWithCluster <- data.frame(dades,c)
  cdg <- aggregate(as.data.frame(dades),list(c),mean) 
  globalMeans <-  colMeans(dades)
  dim(globalMeans) <- c(1,numVariables)
  Bss <- 0
  for (cluster in 1:i){
    numTuples = as.numeric(table(c)[cluster])
    meanCluster = cdg[cluster,1:numVariables+1]
    Bss <- Bss + numTuples*rowSums((meanCluster-globalMeans)^2)
  }
  globalMeansTss <- rep.row(globalMeans,numRows)
  Tss <- sum(rowSums((dades - globalMeans)^2))

  Ib <- 100*Bss/Tss
  print(i)
  print(Ib)
  Ib_array <- c(Ib_array,Ib)
}


plot(Ib_array, xlab="numberofclusters", ylab="MANOVA")


