rm(list=ls(all=TRUE))

library(rstudioapi) # load it
# the following line is for getting the path the open file
current_path <- getActiveDocumentContext()$path 
path <- paste(dirname(current_path),'dataset_split/',sep='/')
setwd(path)


library(MLmetrics)#needed for making our own evaluation function
library(caret)#best library for parameter tuning
library(naivebayes)#naive bayes original implementation
#since the one from caret has minor bugs
library(infotheo)
library(vcd)



#generating namefiles
cvString <- 'crossvalidation_student_'
testString <- 'testing_student_'
cvPor<- read.csv(paste(cvString,'por.csv',sep=''))
testPor<- read.csv(paste(testString,'por.csv',sep=''))



cvPor$Grade <- NULL
testPor$Grade <- NULL 
cvPor$X <- NULL
testPor$X <- NULL 
cvPor$Unnamed..0 <- NULL
testPor$Unnamed..0 <- NULL 
cvPor$absences <- cut(cvPor$absences,5)
testPor$absences <- cut(testPor$absences,5)


foo <- function(colname){
  val <- mutinformation(X=cvPor[,colname],Y=cvPor[,"Passed"])
  return(val)
}
variables = colnames( cvPor[-grep('Passed',colnames(cvPor))])
MIratio <- sapply(variables,foo )
MIratio
plot(x = MIratio,xaxt = "n")
axis(1,at=1:(length(variables)) , labels = c(variables),cex.axis = 0.6)
length(variables)



DF <- cvPor
catcorrm <- function(vars, dat) sapply(vars, function(y) sapply(vars, function(x) assocstats(table(dat[,x], dat[,y]))$cramer))
DF <- catcorrm(colnames(DF),DF)
heatmap(-DF,Colv=NA, Rowv=NA,col)
DF[ DF < 0.3] <- NA
heatmap(-DF,Colv=NA, Rowv=NA)


colnames(cvPor)
cvPor$Grade <- NULL
testPor$Grade <- NULL
#given the fact that naive bayes is weak to noninformative variables
#and that the most common value is 'other' which brings no information to our analysis
#the wisest choice is to remove them

cvPor$school <- NULL
testPor$school <- NULL
#cvPor$sex <- NULL
#testPor$sex <- NULL
cvPor$age <- NULL
testPor$age <- NULL
cvPor$address <- NULL
testPor$address <- NULL
cvPor$famsize <- NULL
testPor$famsize <- NULL
cvPor$pstatus <- NULL
testPor$pstatus <- NULL
cvPor$medu <- NULL
testPor$medu <- NULL
#cvPor$fedu <- NULL
#testPor$fedu <- NULL
#cvPor$mjob <- NULL
#testPor$mjob <- NULL
#cvPor$fjob <- NULL 
#testPor$fjob <- NULL 
#cvPor$reason <- NULL
#testPor$reason <- NULL
#cvPor$guardian <- NULL
#testPor$guardian <- NULL
cvPor$traveltime <- NULL
testPor$traveltime <- NULL
cvPor$studytime <- NULL
testPor$studytime <- NULL
#cvPor$failures <- NULL
#testPor$failures <- NULL
cvPor$schoolsup <- NULL
testPor$schoolsup <- NULL
cvPor$famsup <- NULL
testPor$famsup <- NULL
cvPor$paid <- NULL##this one doesnt matter
testPor$paid <- NULL
cvPor$activities <- NULL
testPor$activities <- NULL
#cvPor$nursery <- NULL #this one doest matter
#testPor$nursery <- NULL
#cvPor$higher <- NULL
#testPor$higher <- NULL
#cvPor$internet <- NULL
#testPor$internet <- NULL
#cvPor$romantic <- NULL
#testPor$romantic <- NULL
#cvPor$famrel <- NULL
#testPor$famrel <- NULL
#cvPor$freetime <- NULL
#testPor$freetime <- NULL
#cvPor$goout <- NULL #this one doesnt matter
#testPor$goout <- NULL
#cvPor$dalc <- NULL
#testPor$dalc <- NULL
#cvPor$walc <- NULL
#testPor$walc <- NULL
cvPor$health <- NULL 
testPor$health <- NULL
#cvPor$absences <- NULL
#testPor$absences <- NULL

f1 <- function (data, lev = NULL, model = NULL) {
  precision <- posPredValue(data$pred, data$obs, positive = "Passed")
  recall  <- sensitivity(data$pred, data$obs, postive = "Passed")
  f1_val <- (2 * precision * recall) / (precision + recall)
  names(f1_val) <- c("F1")
  f1_val
} 



#Preparing parameters for naive bayes
#k fold cross validation
k=7
train_control <-trainControl(method='cv',number= k,summaryFunction = f1)
#separate column we want predict
features = cvPor[-grep('Passed',colnames(cvPor))]
results = cvPor$Passed#column we want to predict

model <- train(x=features,y=results,
               trControl= train_control, 
               method='naive_bayes',
               tuneGrid = expand.grid(.laplace=0.01,.usekernel=c(TRUE,FALSE),.adjust=1),
               metric = 'F1')
model#we can see final f1 measure
model$resample#fmeasure throughout training


  
x <- testPor[-grep('Passed',colnames(testPor))]
obs <- testPor$Passed
pred <- predict(model,x)
(matrix <- table(pred=pred,truth=obs))
#confusionMatrix(pred,obs) #version with more information
(finalRecall  <- sensitivity(data=pred, reference = obs, postive = "Passed"))
(finalPrecision <- posPredValue(data = pred,reference = obs,positive = 'Passed'))
(finalFmeasure <-(2 * finalPrecision * finalRecall) / (finalPrecision + finalRecall))

(finalRecallNeg  <- sensitivity(data=pred, reference = obs, postive = "Failed"))
(finalPrecisionNeg <- posPredValue(data = pred,reference = obs,positive = 'Failed'))
(finalFmeasureNeg <-(2 * finalPrecisionNeg * finalRecallNeg) / (finalPrecisionNeg + finalRecallNeg))

