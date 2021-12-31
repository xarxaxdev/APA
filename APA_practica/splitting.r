rm(list=ls(all=TRUE))

library(rstudioapi) # load it
# the following line is for getting the path the open file
current_path <- getActiveDocumentContext()$path 
setwd(dirname(current_path ))

pokemons <- read.csv("pokemon_procesado.csv",header=T, sep=",")
n <- nrow(pokemons)

#divide in testing and training 
# Ni idea de xk no me funciona
#pokemonsTraining <- pokemons[sample(1:nrow(pokemons), 2*nrow(pokemons)/3,
#                                    replace=FALSE),]  
#pokemonsTesting <- setdiff(pokemons, pokemonsTraining)

learn <- sample(1:n, round(2*n/3))
nlearn <- length(learn)
ntest <- n - nlearn

#no repeated ind (lo quitamos al final)
for (value in duplicated(learn[order(learn)])){
  if (value == TRUE){
    print("ERROR")
  }
}

pokemonsTraining <- pokemons[learn,]  
pokemonsTesting <- pokemons[-learn,]



write.table(pokemonsTraining, file = "pokemonsTraining.csv", sep = ",", na = "NA", dec = ".", row.names = FALSE, col.names = TRUE)
write.table(pokemonsTesting, file = "pokemonsTesting.csv", sep = ",", na = "NA", dec = ".", row.names = FALSE, col.names = TRUE)

