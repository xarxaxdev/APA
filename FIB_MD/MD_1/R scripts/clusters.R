#############
# REMOVE ALL:

rm(list=ls(all=TRUE))
dev.off()

#############

library(readxl)
setwd("../Original_Dataset/Other_Datasets");
dd <- read.table("Practica_processada.csv",header=T, sep=";")
## names(dd)
## dim(dd)
## summary(dd)

attach(dd)

dades <- data.frame(F_MORTS,F_FERITS_GREUS,F_FERITS_LLEUS,F_VICTIMES,F_UNITATS_IMPLICADES)
dim(dades)

k1 <- kmeans(dades, 5)
## names(dades)


# Kmeans info: 
  print(k1)

  k1$size

  k1$withinss

  k1$centers

# plots de las variables:

  plot(F_MORTS,F_FERITS_GREUS)
  plot(F_FERITS_GREUS,F_FERITS_LLEUS)
  plot(F_FERITS_LLEUS,F_VICTIMES)
  plot(F_VICTIMES, F_UNITATS_IMPLICADES)

# LETS COMPUTE THE DECOMPOSITION OF INERTIA

Bss <- sum(rowSums(k1$centers^2)*k1$size); Bss
Wss <- sum(k1$withinss); Wss
Tss <- k1$totss; Tss

Bss+Wss

Ib1 <- 100*Bss/(Bss+Wss); Ib1



### HIERARCHICAL CLUSTERING:

d <- dist(dades[,])
h1 <- hclust(d,method="ward.D")
plot(h1)


d <- dist(dades)
h1 <- hclust(d, method="ward.D") ### notice the cost
plot(h1)  ## may take long (may even crash R)


# BUT WE ONLY NEED WHERE THERE ARE THE LEAPS OF THE HEIGHT

# WHERE ARE THER THE LEAPS? WHERE WILL YOU CUT THE DENDREOGRAM?, HOW MANY CLASSES WILL YOU OBTAIN?

nc <- 3

c1 <- cutree(h1,nc)

c1[1:20]

nc = 5

clusters <- cutree(h1,nc)

c5[1:20]


table(c1)
table(c5)
table(c1,c5)


cdg <- aggregate(as.data.frame(dades),list(c5),mean); cdg

plot(cdg[,1], cdg[,2])

# LETS SEE THE PARTITION VISUALLY

plot(jitter(F_MORTS),jitter(F_FERITS_GREUS),col=c5,main="Clustering of credit data in 3 classes",bty="n")
plot(jitter(F_FERITS_GREUS),jitter(F_FERITS_LLEUS),col=c5,main="Clustering of credit data in 3 classes",bty="n")
plot(jitter(F_FERITS_LLEUS),jitter(F_VICTIMES),col=c5,main="Clustering of credit data in 3 classes",bty="n")
plot(jitter(F_VICTIMES),jitter(F_UNITATS_IMPLICADES),col=c5,main="Clustering of credit data in 3 classes",bty="n")

# LETS SEE THE QUALITY OF THE HIERARCHICAL PARTITION

Bss <- sum(rowSums(cdg^2)*as.numeric(table(c1)))

Ib4 <- 100*Bss/Tss
Ib4

dd<- data.frame(dd,clusters)

write.table(dd, file = "Practica_w_cluster.csv", sep = ";", na = "NA", dec = ".", row.names = FALSE, col.names = TRUE)


