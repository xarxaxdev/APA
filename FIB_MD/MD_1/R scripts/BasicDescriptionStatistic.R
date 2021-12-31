setwd("../Original_Dataset");
dataset <- read.csv("Practica.csv",header=T, sep=";");
#setwd("../Original_Dataset/Other_Datasets"); if we want to see after preprocessing
#dataset <- read.csv("Practica_processada.csv", header=T, sep=";");

class(dataset)
dim(dataset)
numTuples<-dim(dataset)[1]
numTuples
numAtributs<-dim(dataset)[2]
numAtributs

names(dataset)

listOfColors<-rainbow(14)

par(ask=TRUE)

for(atribut in 1:numAtributs){
  if (is.factor(dataset[,atribut])){ 
    frecs<-table(dataset[,atribut], useNA="ifany")
    proportions<-frecs/numTuples
    #ojo, decidir si calcular porcentages con o sin missing values
    #table(t1, exclude=NULL) or table(t1, useNA='ifany')
    pie(frecs, cex=0.6, main=paste("Pie of", names(dataset)[atribut]))
    barplot(frecs, las=3, cex.names=0.7, main=paste("Barplot of", names(dataset)[atribut]), col=listOfColors)
    print(frecs)
    print(proportions)
  }else{
    hist(dataset[,atribut], main=paste("Histogram of", names(dataset)[atribut]))
    boxplot(dataset[,atribut], horizontal=TRUE, main=paste("Boxplot of", names(dataset)[atribut]))
    print(summary(dataset[,atribut]))
    print(paste("sd: ", sd(dataset[,atribut])))
    print(paste("vc: ", sd(dataset[,atribut])/mean(dataset[,atribut])))
  }
}

par(ask=FALSE)




