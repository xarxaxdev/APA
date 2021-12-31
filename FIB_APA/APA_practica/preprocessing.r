rm(list=ls(all=TRUE))


library(ggplot2)
library(gplots)
library(plyr)
library(e1071)

library(rstudioapi) # load it
# the following line is for getting the path the open file
current_path <- getActiveDocumentContext()$path 
setwd(dirname(current_path ))

pokemons <- read.csv("pokemon.csv",header=T, sep=",")



pokemons$id<- NULL
pokemons$species_id <- NULL
pokemons$evolves_from_species_id <- NULL
pokemons$evolution_chain_id <- NULL
pokemons$url_image <- NULL
pokemons$generation_id <- NULL
pokemons$shape_id <- NULL
pokemons$color_1 <- NULL
pokemons$color_2 <- NULL
pokemons$color_f <- NULL
#pokemons$pokemon <- NULL


#NOW WE HAVE ONLY THE INFORMATIVE COLUMNS


pokemons <- pokemons[-c(722:811),] #megaevolutions and other forms of pokemon
pokemons <- pokemons[pokemons$pokemon != 'ditto',]#very special abilities
#and egg group, he is an outlier gimmick pokemon




####################################################
##################TARGET VARIABLE ######################
####################################################
p <- ggplot(pokemons,aes(x=speed)) + 
  geom_density() + 
  geom_vline(aes(xintercept=mean(speed)),
             color="blue", linetype="dashed", size=1)

p
#######################boxplot en funcion de nuestra unica categorica simple##############################
p <- ggplot(pokemons,aes(x=shape,y=speed)) + 
  geom_boxplot() 
p




####################################################
##################SHAPE######################
####################################################
shapes <-levels(pokemons$shape) 
#change to boolean so they count properly
for (i in shapes){
  index <-  paste('shape', i,sep = '_')
  pokemons[,index] <- (pokemons$shape==i )
}
pokemons$shape <- NULL


####################################################
##################TYPES######################
####################################################
#get all typing
types <-levels(pokemons$type_1) 
#change to boolean so they count properly
for (i in types){
  index <-  paste('type', i,sep = '_')
  pokemons[,index] <-( (pokemons$type_1==i )| (!is.na( pokemons$type_2) & pokemons$type_2==i))
}
pokemons$type_1 <- NULL
pokemons$type_2 <- NULL


###  FUNCIONES PARA VISUALIZACION ######
typesMean <- function(type1,type2,stat=stat2Plot){
  print(type1)
  col=paste('type', type1 ,sep ='_')
  col2=paste('type', type2 ,sep ='_')
  return(mean(pokemons[pokemons[,col] &pokemons[,col2],stat]))
}

typesStdev<- function(type1,type2,stat=stat2Plot){
  col=paste('type', type1 ,sep ='_')
  col2=paste('type', type2 ,sep ='_')
  return(sd(pokemons[pokemons[,col] &pokemons[,col2],stat]))
}

stat2Plot= 'speed'
###################PLOTTTING FOR TYPES ######################
typeMeanPlot <- outer(types,types,Vectorize(typesMean))
colnames(typeMeanPlot) <- types
row.names(typeMeanPlot)<- types
#mean matrix
typeMeanPlot
typeMeanPlot<-round(typeMeanPlot)


typeMeanPlot <- as.matrix(typeMeanPlot)
typeMeanPlot[is.nan(typeMeanPlot)] <- NA

#data <- round(data)
#typeVarHeatmap <- heatmap(data.matrix(typeMeanPlot),Rowv=NA, Colv=NA, col = rev(heat.colors(300)),main= stat2Plot)
#Error
typeMeanHeatmap <- heatmap.2(data.matrix(typeMeanPlot),cellnote=typeMeanPlot, density.info="none", notecol="black",
                             trace= "none",dendrogram="none", Rowv=NA, Colv=NA, col = rev(heat.colors(300)),main= stat2Plot)

typeStdev <- outer(types,types,Vectorize(typesStdev))
colnames(typeStdev) <- types
row.names(typeStdev) <-types
#variance matrix
typeStdev
typeStdev<-round(typeStdev)

typeStdev<- as.matrix(typeStdev)
for(i in types){
  for(j in types){
    if (! is.na(typeMeanPlot[i,j])  && is.na(typeStdev[i,j])){
      typeStdev[i,j] <- 0
    } 
  }
}


typeSdHeatmap <- heatmap.2(data.matrix(typeStdev), cellnote=typeStdev ,density.info="none", notecol="black",
                           trace='none',  dendrogram = 'none', Rowv=NA,  Colv=NA, col = rev(heat.colors(300)),main= stat2Plot)

###################################Bar plot#######################
n <- length(types)
typeMeanBar <- c()
typeMeanMono <- c()

for (i in 1:n) {
  typeMeanBar <- append(typeMeanBar, mean(typeMeanPlot[i,], na.rm = TRUE))
  typeMeanMono <- append(typeMeanMono, typeMeanPlot[i,i])
}

SuppD <- rep("Mean",times = 18)
SuppD <- append(SuppD, rep("Mono",times = 18))
type.2 <- append(types,types)
data <- append(typeMeanBar,typeMeanMono)

typeMeanBar.df <- data.frame(supp=SuppD,type=type.2,value=data)
#typeMeanBar.df <- data.frame(t(typeMeanBar.df))
#names(typeMeanHist) <- types

#barplot(typeMeanBar, names.arg= types)


p <- ggplot(data=typeMeanBar.df,aes(x=type,y=value, fill=supp))+geom_bar(stat="identity",position=position_dodge()) 
p + theme(axis.text.x = element_text(angle=90)) + scale_y_continuous(breaks=seq())

####################################################
##################EGGTYPES######################
####################################################

#get all typing
eggTypes <-levels(factor(pokemons$egg_group_1) )
eggTypes <- eggTypes[ eggTypes !='ditto']

#change to boolean so they count properly
for (i in eggTypes){
  index <-  paste('eggtype', i,sep = '_')
  pokemons[,index] <-( (pokemons$egg_group_1==i )| (!is.na( pokemons$egg_group_2) & pokemons$egg_group_2==i))
}
pokemons$egg_group_1 <- NULL
pokemons$egg_group_2 <- NULL

######### FUNCIONES PARA VISUALIZACION ######

eggTypesMean <- function(type1,type2,stat=stat2Plot){
  col=paste('eggtype', type1 ,sep ='_')
  col2=paste('eggtype', type2 ,sep ='_')
  return(mean(pokemons[pokemons[,col] &pokemons[,col2],stat]))
}

eggTypesStdev <- function(type1,type2,stat=stat2Plot){
  col=paste('eggtype', type1 ,sep ='_')
  col2=paste('eggtype', type2 ,sep ='_')
  return(sd(pokemons[pokemons[,col] &pokemons[,col2],stat]))
}

###################PLOTTTING FOR TYPES ######################

eggTypeMeanPlot <- outer(eggTypes,eggTypes,Vectorize(eggTypesMean))
colnames(eggTypeMeanPlot) <- eggTypes
row.names(eggTypeMeanPlot)<- eggTypes
#mean matrix
eggTypeMeanPlot
eggTypeMeanPlot<-round(eggTypeMeanPlot)
eggTypeMeanPlot <- as.matrix(eggTypeMeanPlot)
eggTypeMeanPlot[is.nan(eggTypeMeanPlot)] <- NA
eggTypeMeanPlot
typeMeanHeatmap <- heatmap.2(data.matrix(eggTypeMeanPlot),cellnote=eggTypeMeanPlot, density.info="none", notecol="black", keysize = 0.70,
                             trace= "none",dendrogram="none", Rowv=NA, Colv=NA, col = rev(heat.colors(300)),
                             srtRow=0, srtCol=50,margins = c(6, 7),main= stat2Plot)





eggTypeStdev <- outer(eggTypes,eggTypes,Vectorize(eggTypesStdev))
colnames(eggTypeStdev) <- eggTypes
row.names(eggTypeStdev) <-eggTypes
#variance matrix
eggTypeStdev
eggTypeStdev<-round(eggTypeStdev)
eggTypeStdev <- as.matrix(eggTypeStdev)


for(i in eggTypes){
  for(j in eggTypes){
    if (! is.na(eggTypeMeanPlot[i,j])  && is.na(eggTypeStdev[i,j])){
      eggTypeStdev[i,j] <- 0
    } 
  }
}

typeSdHeatmap <- heatmap.2(data.matrix(eggTypeStdev), cellnote=eggTypeStdev ,density.info="none", notecol="black",
                           trace='none',  dendrogram = 'none', Rowv=NA, Colv=NA, col = rev(heat.colors(300)),
                           srtRow=0, srtCol=50,margins = c(6, 7),main= stat2Plot)

####################################################
##################ABILITIES######################
####################################################


abilities <- as.factor(paste(c(as.character(pokemons$ability_1), 
                               as.character(pokemons$ability_2), 
                               as.character(pokemons$ability_hidden))))
c <- as.data.frame(table(abilities))
(c2 <- c[order(-c$Freq),])
plot(c2[c2$abilities != 'NA' ,])

ind <- c[c$Freq < 20 ,] # top 25

levels(pokemons$ability_1) <- c(levels(pokemons$ability_1),'LOWFREQ')
levels(pokemons$ability_2) <- c(levels(pokemons$ability_2),'LOWFREQ')
levels(pokemons$ability_hidden) <- c(levels(pokemons$ability_hidden),'LOWFREQ')

for (i in ind$abilities) {
  pokemons$ability_1[pokemons$ability_1 == i] <- "LOWFREQ"
  pokemons$ability_2[pokemons$ability_2 == i] <- "LOWFREQ"
  pokemons$ability_hidden[pokemons$ability_hidden == i] <- "LOWFREQ"
}

abilities <- as.factor(paste(c(as.character(pokemons$ability_1), 
                               as.character(pokemons$ability_2), 
                               as.character(pokemons$ability_hidden))))
length(levels(abilities))
c <- as.data.frame(table(abilities))
c<- c[c$abilities != 'NA',] #we dont want to add NAs
c$abilities <- factor(c$abilities)
(c2 <- c[order(-c$Freq),])
plot(c2, xaxt="n", ann=FALSE)
text(seq(c$abilities), labels = c$abilities, srt =50, pos = 1, offset = 2.5,xpd = TRUE,cex=.75)




#get all abilities
(abilities <-levels(abilities)) 
#change to boolean so they count properly
for (i in abilities){
  index <-  paste('ability', i,sep = '_')
  pokemons[,index] <-( (pokemons$ability_1==i )| (!is.na( pokemons$ability_2) & pokemons$ability_2==i)|
                         (!is.na( pokemons$ability_hidden) & pokemons$ability_hidden==i))
}

pokemons$ability_1 <- NULL
pokemons$ability_2 <- NULL
pokemons$ability_hidden <- NULL
pokemons$ability_NA <- NULL #we don't need this anymore
pokemons


#pokemonSinForma <- pokemons[rowSums(is.na(pokemons)) > 0,]#per comprovar
pokemons <- pokemons[complete.cases(pokemons),]
 
pokemons[pokemons == FALSE] <- 0
pokemons[pokemons == TRUE] <- 1

pokemons$pokemon <- NULL


#####################################################
##################    STATS    ######################
#####################################################

#Now we want to transform data for reduce the skewness and kurtosis
#We use the following functions for calculate the skewness and kurtosis of every predictor variable
#Acceptables values are round 0 in both skewness and kurtosis.
#For achieve this values we use 2 methods, the log transformormation and the sqrt transformation.
skewness(pokemons$height)  #bad results
kurtosis(pokemons$height)  
hist(pokemons$height)      #it doesn't have gaussian form or similar
p <- ggplot(pokemons,aes(x=height)) + 
  geom_density() + 
  geom_vline(aes(xintercept=mean(height)),
             color="blue", linetype="dashed", size=1)
p

skewness(log(pokemons$height))  
kurtosis(log(pokemons$height))
hist(log(pokemons$height))

pokemons$height <- log(pokemons$height)
p <- ggplot(pokemons,aes(x=height)) + 
  geom_density() + 
  geom_vline(aes(xintercept=mean(height)),
             color="blue", linetype="dashed", size=1)
p

#weight
skewness(pokemons$weight)
kurtosis(pokemons$weight)  
hist(pokemons$weight)
p <- ggplot(pokemons,aes(x=weight)) + 
  geom_density() + 
  geom_vline(aes(xintercept=mean(weight)),
             color="blue", linetype="dashed", size=1)
p


skewness(log(pokemons$weight))
kurtosis(log(pokemons$weight))  
hist(log(pokemons$weight))

pokemons$weight <- log(pokemons$weight)
p <- ggplot(pokemons,aes(x=weight)) + 
  geom_density() + 
  geom_vline(aes(xintercept=mean(weight)),
             color="blue", linetype="dashed", size=1)
p


#base_experience
skewness(pokemons$base_experience)
kurtosis(pokemons$base_experience)  
hist(pokemons$base_experience)

skewness(sqrt(pokemons$base_experience))
kurtosis(sqrt(pokemons$base_experience))  
hist(sqrt(pokemons$base_experience))

pokemons$base_experience <- log(pokemons$base_experience)

#attack
skewness(pokemons$attack) 
kurtosis(pokemons$attack)  
hist(pokemons$attack)

skewness(sqrt(pokemons$attack)) 
kurtosis(sqrt(pokemons$attack))  
hist(sqrt(pokemons$attack))

pokemons$attack <- sqrt(pokemons$attack)

#defense
skewness(pokemons$defense)
kurtosis(pokemons$defense)  
hist(pokemons$defense)

skewness(sqrt(pokemons$defense))
kurtosis(sqrt(pokemons$defense))  
hist(sqrt(pokemons$defense))

pokemons$defense <- sqrt(pokemons$defense)

#hp
skewness(pokemons$hp)
kurtosis(pokemons$hp)  
hist(pokemons$hp)

skewness(sqrt(pokemons$hp))
kurtosis(sqrt(pokemons$hp))  
hist(sqrt(pokemons$hp))

pokemons$hp <- sqrt(pokemons$hp)

#special_attack
skewness(pokemons$special_attack)
kurtosis(pokemons$special_attack)  
hist(pokemons$special_attack)

skewness(sqrt(pokemons$special_attack))
kurtosis(sqrt(pokemons$special_attack))  
hist(sqrt(pokemons$special_attack))

pokemons$special_attack <- sqrt(pokemons$special_attack)


#special_defense
skewness(pokemons$special_defense)
kurtosis(pokemons$special_defense)  
hist(pokemons$special_defense)

skewness(sqrt(pokemons$special_defense))
kurtosis(sqrt(pokemons$special_defense))  
hist(sqrt(pokemons$special_defense))

pokemons$special_defense <- sqrt(pokemons$special_defense)

####################################################
################## NUMERICAL VARIABLES ######################
##################NEEDING NORMALIZATION ######################
####################################################
max(pokemons$height)
pokemons$height <- pokemons$height/max(pokemons$height)
max(pokemons$weight)
pokemons$weight <- pokemons$weight/max(pokemons$weight)
max(pokemons$base_experience)
pokemons$base_experience <- pokemons$base_experience/max(pokemons$base_experience)
max(pokemons$attack)
pokemons$attack <- pokemons$attack/max(pokemons$attack)
max(pokemons$defense)
pokemons$defense <- pokemons$defense/max(pokemons$defense)
max(pokemons$hp)
pokemons$hp <- pokemons$hp/max(pokemons$hp)
max(pokemons$special_attack)
pokemons$special_attack <- pokemons$special_attack/max(pokemons$special_attack)
max(pokemons$special_defense)
pokemons$special_defense <- pokemons$special_defense/max(pokemons$special_defense)
max(pokemons$speed)
pokemons$speed <- pokemons$speed/max(pokemons$speed)


write.table(pokemons, file = "pokemon_procesado.csv", sep = ",", na = "NA", dec = ".", row.names = FALSE, col.names = TRUE)

