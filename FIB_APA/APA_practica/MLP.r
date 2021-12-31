rm(list=ls(all=TRUE))

library(rstudioapi) # load it
# the following line is for getting the path the open file
current_path <- getActiveDocumentContext()$path 
setwd(dirname(current_path ))

library(keras)
library(dplyr)


#divide in testing and training
pokemonsTraining <- read.csv("pokemonsTraining.csv", sep = ",", na = "NA", dec = ".")


#numero neuronas
#5 por cada stat que no es speed
#3 experiencia base, height, weight
#2 por type
#2 por eggtype
#3 por abilities
#1 por la shape
nNeuronas <- 40
model <- keras_model_sequential()
hiddenActivation<- 'relu'
model%>%
  layer_dense(input_shape = c(ncol(pokemonsTraining)-1), nNeuronas )%>%
  layer_dense(units = nNeuronas,activation = hiddenActivation )%>%
  layer_dense(units = nNeuronas,activation = hiddenActivation )%>%
  layer_dense(units = nNeuronas,activation = hiddenActivation )%>%
  layer_dense(units = nNeuronas,activation = hiddenActivation )%>%
  layer_dense(input_shape = 1, units = 1 )
  
  
  
model %>% compile(
  loss = 'mean_squared_error',
  optimizer = optimizer_sgd(lr = 0.05,momentum = 0.9),
  metrics = c('mse')
)
model



y_train <- pokemonsTraining$speed
x_train <- as.matrix(pokemonsTraining[,- which(names(pokemonsTraining)== 'speed')])
history <- model %>% fit(
  x_train, y_train, 
  epochs = 80, batch_size = 128, 
  validation_split = 0.2
)
