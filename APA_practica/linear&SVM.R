#####################################
######   linear & SVM Models   ######
#####################################

#install.packages('plyr')
rm(list=ls(all=TRUE))

library(MASS)
library(e1071)
library(mlbench)
library(evaluate)


setLocalDir <- function() {
  actualDir <- dirname(rstudioapi::getSourceEditorContext()$path)
  setwd(actualDir)
}

setLocalDir()

set.seed(537)


MSE <- function(real, predicted) {
  n <- length(real)
  differences <- sort(real-predicted) 
  plot(differences)
  lines(differences)
  abline(h=0)
  abline(h=0.2,col=2)
  abline(h=-0.2,col=2)
  abline(h=0.05,col=4)
  abline(h=-0.05,col=4)
  length(differences[differences<0.05 & differences> -0.05])
  
  plot(seq(n), predicted, ylab = "Value", xlab = "Data", col='red', ylim=c(0,1))
  points(seq(n), real, col = 'blue')
  legend("topleft", legend=c("Predicted Value", "DataTest"), fill=c("red","blue"))
  
  mse <- sum((real - predicted)^2)/n
  
  return(mse)
}


##### Linear Regression #####
learn.data <- read.csv("pokemonsTraining.csv",header=T, sep=",")
test.data <- read.csv("pokemonsTesting.csv",header=T, sep=",")

nlearn <- nrow(learn.data)
ntest <- nrow(test.data)

model.linear <- lm(speed ~., data=learn.data) ##learn data


#save(model.linear, file = "model.linear.mod")
load ("model.linear.mod")


plinear <- predict(model.linear)

(MSE.linear <- MSE(learn.data$speed, plinear))


######  SVM linear  ###### 
model.SVMlinear <- svm(speed ~ . , data = learn.data,
                       type="eps-regression", kernel="linear", epsilon=0.01,
                       scale = FALSE)

pred.SVMlinear <- predict(model.SVMlinear, learn.data)
(MSE.SVMlinear <- MSE(learn.data$speed, pred.SVMlinear))

#We want a better performance
c <- 2^seq(-10,10)
e <- 0.01

trc <- tune.control(nrepeat = 1, sampling="cross", cross=4, best.model = TRUE)
## WARNING: this takes some minutes
model.SVMlinear.CV <- tune(svm, speed ~., data = learn.data, kernel="linear",
                                ranges=list(cost=c, epsilon=e), tunecontrol = trc)

model.SVMlinear.CV
model.SVMlinear <- model.SVMlinear.CV$best.model

#save(model.SVMlinear, file = "model.SVMlinear.mod")
load ("model.SVMlinear.mod")

pSVMlinear <- predict(model.SVMlinear)

(MSE.SVMlinear.CV <- MSE(learn.data$speed, pSVMlinear))



######  SVM quad(tune)  ######
c <- 2^seq(-10,10)
g <- 2^seq(-10,10)
e <- 0.01
## WARNING: this takes some minutes
model.SVMquad.CV <- tune(svm, speed ~., data = learn.data, kernel="polynomial",
                              ranges=list(type = "eps-regression",epsilon=e ,cost=c, gamma=g, degree=2, coef0=1), tunecontrol = trc)


model.SVMquad.CV
model.SVMquad <- model.SVMquad.CV$best.model 

#save(model.SVMquad, file = "model.SVMquad.mod")
load ("model.SVMquad.mod")

pSVMquad <- predict(model.SVMquad)

(MSE.SVMquad <- MSE(learn.data$speed, pSVMquad))



######  SVM rbf(tune)  ######
c <- 2^seq(-10,10)
g <- 2^seq(-10,10)
e <- 0.01
## WARNING: this takes some minutes
model.SVMrbf.CV <- tune(svm, speed ~., data = learn.data, kernel="radial",
                             ranges=list(type = "eps-regression",epsilon=e ,cost=c, gamma=g), tunecontrol = trc)

model.SVMrbf.CV
model.SVMrbf <- model.SVMrbf.CV$best.model

#save(model.SVMrbf, file = "model.SVMrbf.mod")
load ("model.SVMrbf.mod")

pSVMrbf <- predict(model.SVMrbf)

(MSE1 <- MSE(learn.data$speed, pSVMrbf))




#TEST
plinear.DT <- (predict (model.linear, newdata=test.data))
(MSE.linear.DT <- MSE(test.data$speed, plinear.DT))

pSVMlinear.DT <- (predict (model.SVMlinear, newdata=test.data))
(MSE.SVMlinear.DT <- MSE(test.data$speed, pSVMlinear.DT))

pSVMquad.DT <- (predict (model.SVMquad, newdata=test.data))
(MSE.SVMquad.DT <- MSE(test.data$speed, pSVMquad.DT))

pSVMrbf.DT <- (predict (model.SVMrbf, newdata=test.data))
(MSE.SVMrbf.DT <- MSE(test.data$speed, pSVMrbf.DT))

