library(readxl)
wd <- getwd()

#IF WE WANT CLEAN THE ENVIRONMENT
rm(list=ls(all=TRUE))
dev.off()

setwd("../Original_Dataset/Other_Datasets");
dd <- read.csv("Practica_processada.csv",header=T, sep=";");


objects()
attributes(dd)

#
# VISUALISATION OF DATA
#
# PRINCIPAL COMPONENT ANALYSIS OF CONTINcUOUS VARIABLES, WITH Dictamen PROJECTED AS ILLUSTRATIVE
#

# CREATION OF THE DATA FRAME OF CONTINUOUS VARIABLES

attach(dd)
names(dd)

#CONVERT VELOCITAT TO NUMERICAL
index <- grep("C_VELOCITAT_VIA", colnames(dd))
dd[,index] <- as.numeric(dd[,index])
missingDataValue <- 100
levels(dd[,index])=c (levels(dd[,index]),missingDataValue)
dd[is.na(dd[index]),index]<-missingDataValue
dd[(dd[,index])=='13',index]<-missingDataValue
dd[,index] <- as.numeric(as.factor(dd[,index]))


#set a list of numerical variables
dcon <- data.frame(F_MORTS, F_FERITS_GREUS, F_FERITS_LLEUS, F_VICTIMES, F_UNITATS_IMPLICADES, dd$C_VELOCITAT_VIA)



# PRINCIPAL COMPONENT ANALYSIS OF dcon
pc1 <- prcomp(dcon, scale=TRUE)

# Screeplot for ppt
screeplot(main = "Scree plot for ACP",pc1, type="lines")

# SELECTION OF THE SINGIFICNT DIMENSIONS (keep 80% of total inertia)
nd = 0.8*totalIner

# STORAGE OF THE EIGENVALUES, EIGENVECTORS AND PROJECTIONS IN THE nd DIMENSIONS
Psi = pc1$x[,1:nd]


class(pc1)
attributes(pc1)

print(pc1)




# WHICH PERCENTAGE OF THE TOTAL INERTIA IS REPRESENTED IN SUBSPACES?

pc1$sdev
inerProj<- pc1$sdev^2 
inerProj
totalIner<- sum(inerProj)
totalIner
pinerEix<- 100*inerProj/totalIner
pinerEix
barplot(main = "% of Total Inertia",pinerEix)


#Cummulated Inertia in subspaces, from first principal component to the 11th dimension subspace
xx <- barplot(main = "Accumulated % of inertia", 100*cumsum(pc1$sdev[1:dim(dcon)[2]]^2)/dim(dcon)[2])
percInerAccum<-100*cumsum(pc1$sdev[1:dim(dcon)[2]]^2)/dim(dcon)[2]
text(xx, percInerAccum - 4,paste(round(percInerAccum, digits = 2)), cex = 0.8)
xpos <- c(0,0,0,0,0,0)
xax <- c("PC1", "PC2", "PC3", "PC4", "PC5", "PC6")
text(xx, xpos+2.5 ,paste(xax), cex = 0.8)
percInerAccum


# STORAGE OF LABELS FOR INDIVIDUALS AND VARIABLES
iden = row.names(dcon)
etiq = names(dcon)
ze = rep(0,length(etiq)) # WE WILL NEED THIS VECTOR AFTERWARDS FOR THE GRAPHICS

# PLOT OF INDIVIDUALS

#select your axis
eje1<-1
eje2<-2

plot(main = "Individual projection", Psi[,1],Psi[,2], xlab = "PC1", ylab = "PC2", col=seq(1:dim(Psi)[2]))
axis(side=1, pos= 0, labels = F, col="cyan")
axis(side=3, pos= 0, labels = F, col="cyan")
axis(side=2, pos= 0, labels = F, col="cyan")
axis(side=4, pos= 0, labels = F, col="cyan")
legend("bottomleft",legend=c("Morts", "Ferits_Greus", "Ferits_lleus", "Víctimes", "Unitats_implicades", "Velocitat"),pch=1,col=seq(1:dim(Psi)[2]), cex=0.6)

library(rgl)
plot3d(Psi[,1],Psi[,2],Psi[,3], xlab = "PC1", ylab = "PC2", zlab = "PC3")

#Projection of variables

Phi = cor(dcon,Psi)

X<-Phi[,eje1]
Y<-Phi[,eje2]

#zooms
plot(main = "Common projection",Psi[,eje1],Psi[,eje2],type="n",xlim=c(min(X,0),max(0.3,0)), ylim = c(-1,1), xlab = "PC1", ylab = "PC2")
axis(side=1, pos= 0, labels = F)
axis(side=3, pos= 0, labels = F)
axis(side=2, pos= 0, labels = F)
axis(side=4, pos= 0, labels = F)
arrows(ze, ze, X, Y, length = 0.07,col="blue")
text(X,Y,labels=etiq,col="darkblue", cex=0.7)

dcat <- data.frame (D_CARACT_ENTORN, D_CARRIL_ESPECIAL, D_CIRCULACIO_MESURES_ESP, D_CLIMATOLOGIA, D_LLUMINOSITAT ,D_SUBTIPUS_ACCIDENT, D_SUPERFICIE, D_TIPUS_VIA, D_TRACAT_ALTIMETRIC, grupHor, tipAcc)
dcat_ind <- c (grep("D_CARACT_ENTORN", colnames(dd)), grep("D_CARRIL_ESPECIAL", colnames(dd)), grep("D_CIRCULACIO_MESURES_ESP", colnames(dd)), grep("D_CLIMATOLOGIA", colnames(dd)), grep("D_LLUMINOSITAT", colnames(dd)), grep("D_SUBTIPUS_ACCIDENT", colnames(dd)), grep("D_SUPERFICIE", colnames(dd)), grep("D_TIPUS_VIA", colnames(dd)), grep("D_TRACAT_ALTIMETRIC", colnames(dd)), grep("grupHor", colnames(dd)), grep("tipAcc", colnames(dd)))

for(k in dcat_ind){
  fdic1 = tapply(Psi[,eje1],dd[,k],mean)
  fdic2 = tapply(Psi[,eje2],dd[,k],mean) 
  text(fdic1,fdic2,labels=levels(dd[,k]),col=c(3:13), cex=0.6, pch=1)
 
}
legend("bottomleft",names(dd)[dcat_ind],pch=1,col=c(3:13), cex=0.6)

##################################################
##################################################