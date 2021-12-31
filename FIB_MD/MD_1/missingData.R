setwd(getwd())
# dataset <- read.csv("Practica.csv",header=T, sep=";");
# Read dataset (Adrian PC)
dataset <- read.csv("UNI/Q7/MD/Practica/Data-Mining/Practica.csv",header=T, sep=";");

# Detect
names(dataset)
numAtributs <- dim(dataset)[2]

# Metainfo: Missing data represented by 0 in qualitative variables
# DEALING WITH MISSINGS: Detect

porcentajeNulos = vector(mode="numeric", length = numAtributs)

#columna 1
table(dataset$Any, useNA = "ifany") # we look if there are null values
porcentajeNulos[1] <- length(dataset[dataset$Any == "Unknown",1])/length(dataset[dataset$Any,1])*100
porcentajeNulos[1] 

#columna 2
table(dataset$zona, useNA = "ifany") # we look if there are null values
porcentajeNulos[2] <- length(dataset[dataset$zona == "Unknown",2])/length(dataset[dataset$zona,2])*100
porcentajeNulos[2] 

#columna 3 
table(dataset$dat, useNA = "ifany") # we look if there are null values
porcentajeNulos[3] <- length(dataset[dataset$dat == "Unknown",3])/length(dataset[dataset$dat,3])*100
porcentajeNulos[3] 

#columna 4
table(dataset$via, useNA = "ifany") # we look if there are null values
porcentajeNulos[4] <- length(dataset[dataset$via == "Unknown",4])/length(dataset[dataset$via,4])*100
porcentajeNulos[4] 

#columna 5
levels(dataset$pk) <- c(levels(dataset$pk), "Unknown") # we add the column value "Unknown"
table(dataset$pk, useNA = "ifany") # we look if there are null values
dataset[is.na(dataset$pk) | dataset$pk == 999999,5] <- "Unknown" # we put Unknown in the rows whom values is NA
table(dataset$pk, useNA = "ifany") # we verify the changes
porcentajeNulos[5] <- length(dataset[dataset$pk == "Unknown",5])/length(dataset[dataset$pk,5])*100
porcentajeNulos[5] 

#columna 6
table(dataset$nomMun, useNA = "ifany") # we look if there are null values
porcentajeNulos[6] <- length(dataset[dataset$nomMun == "Unknown",6])/length(dataset[dataset$nomMun,6])*100
porcentajeNulos[6] 

#columna 7
table(dataset$nomCom, useNA = "ifany") # we look if there are null values
porcentajeNulos[7] <- length(dataset[dataset$nomCom == "Unknown",7])/length(dataset[dataset$dat,7])*100
porcentajeNulos[7] 

#columna 8
table(dataset$nomDem, useNA = "ifany") # we look if there are null values
porcentajeNulos[8] <- length(dataset[dataset$nomDem == "Unknown",8])/length(dataset[dataset$nomDem,8])*100
porcentajeNulos[8] 

#columna 9
table(dataset$F_MORTS, useNA = "ifany") # we look if there are null values
porcentajeNulos[9] <- length(dataset[dataset$F_MORTS == "Unknown",9])/length(dataset[dataset$F_MORTS,9])*100
porcentajeNulos[9] 

#columna 10
table(dataset$F_FERITS_GREUS, useNA = "ifany") # we look if there are null values
porcentajeNulos[10] <- length(dataset[dataset$F_FERITS_GREUS == "Unknown",10])/length(dataset[dataset$F_FERITS_GREUS,10])*100
porcentajeNulos[10] 

#columna 11
table(dataset$F_FERITS_LLEUS, useNA = "ifany") # we look if there are null values
porcentajeNulos[11] <- length(dataset[dataset$F_FERITS_LLEUS == "Unknown",11])/length(dataset[dataset$F_FERITS_LLEUS,11])*100
porcentajeNulos[11] 

#columna 12
table(dataset$F_VICTIMES, useNA = "ifany") # we look if there are null values
porcentajeNulos[12] <- length(dataset[dataset$F_VICTIMES == "Unknown",12])/length(dataset[dataset$F_VICTIMES,12])*100
porcentajeNulos[12] 

#columna 13
table(dataset$F_UNITATS_IMPLICADES, useNA = "ifany") # we look if there are null values
porcentajeNulos[13] <- length(dataset[dataset$F_UNITATS_IMPLICADES == "Unknown",13])/length(dataset[dataset$F_UNITATS_IMPLICADES,13])*100
porcentajeNulos[13]

#columna 14 (mirar como poner unknown en numéricas)
levels(dataset$C_VELOCITAT_VIA) <- c(levels(dataset$C_VELOCITAT_VIA), "Unknown") # we add the column value "Unknown"
table(dataset$C_VELOCITAT_VIA, useNA = "ifany") # we look if there are null values
dataset[is.na(dataset$C_VELOCITAT_VIA) | dataset$C_VELOCITAT_VIA == 999,14] <- "Unknown" # we put Unknown in the rows whom values is NA
table(dataset$C_VELOCITAT_VIA, useNA = "ifany") # we verify the changes
porcentajeNulos[14] <- length(dataset[dataset$C_VELOCITAT_VIA == "Unknown",14])/length(dataset[dataset$C_VELOCITAT_VIA,14])*100
porcentajeNulos[14]

#columna 15 (mirar para poner unknown en categoricas sin NAs)
table(dataset$D_ACC_AMB_FUGA, useNA = "ifany") # we look if there are null values
levels(dataset$D_ACC_AMB_FUGA)[levels(dataset$D_ACC_AMB_FUGA)=="Sense Especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_ACC_AMB_FUGA, useNA = "ifany") 
porcentajeNulos[15] <- length(dataset[dataset$D_ACC_AMB_FUGA == "Unknown",15])/length(dataset[dataset$D_ACC_AMB_FUGA,15])*100
porcentajeNulos[15]

#columna 16 
table(dataset$D_BOIRA, useNA = "ifany") # we look if there are null values
porcentajeNulos[16] <- length(dataset[dataset$D_BOIRA== "Unknown",16])/length(dataset[dataset$D_BOIRA,16])*100
porcentajeNulos[16]


#columna 17 (mirar para poner unknown en categoricas con NAs)
table(dataset$D_CARACT_ENTORN, useNA = "ifany") # we look if there are null values
levels(dataset$D_CARACT_ENTORN)[levels(dataset$D_CARACT_ENTORN)=="Sense Especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_CARACT_ENTORN, useNA = "ifany")
dataset[is.na(dataset$D_CARACT_ENTORN),17] <- "Unknown" # we put Unknown in the rows whom values is NA
table(dataset$D_CARACT_ENTORN, useNA = "ifany")
porcentajeNulos[17] <- length(dataset[dataset$D_CARACT_ENTORN == "Unknown",17])/length(dataset[dataset$D_CARACT_ENTORN,17])*100
porcentajeNulos[17]


#columna 18
table(dataset$D_CARRIL_ESPECIAL, useNA = "ifany") # we look if there are null values
levels(dataset$D_CARRIL_ESPECIAL)[levels(dataset$D_CARRIL_ESPECIAL)=="Sense Especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_CARRIL_ESPECIAL, useNA = "ifany")
dataset[is.na(dataset$D_CARRIL_ESPECIAL),18] <- "Unknown" # we put Unknown in the rows whom values is NA. Remember to change the column name
table(dataset$D_CARRIL_ESPECIAL, useNA = "ifany")
porcentajeNulos[18] <- length(dataset[dataset$D_CARRIL_ESPECIAL == "Unknown",18])/length(dataset[dataset$D_CARRIL_ESPECIAL,18])*100
porcentajeNulos[18]


#columna 19
table(dataset$D_CIRCULACIO_MESURES_ESP, useNA = "ifany") # we look if there are null values
levels(dataset$D_CIRCULACIO_MESURES_ESP) <- c(levels(dataset$D_CIRCULACIO_MESURES_ESP), "Unknown") # we add the column value "Unknown"
dataset[is.na(dataset$D_CIRCULACIO_MESURES_ESP),19] <- "Unknown" # we put Unknown in the rows whom values is NA. Remember to change the column name
table(dataset$D_CIRCULACIO_MESURES_ESP, useNA = "ifany")
porcentajeNulos[19] <- length(dataset[dataset$D_CIRCULACIO_MESURES_ESP == "Unknown",19])/length(dataset[dataset$D_CIRCULACIO_MESURES_ESP,19])*100
porcentajeNulos[19]


#columna 20
table(dataset$D_CLIMATOLOGIA, useNA = "ifany") # we look if there are null values
levels(dataset$D_CLIMATOLOGIA)[levels(dataset$D_CLIMATOLOGIA)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_CLIMATOLOGIA, useNA = "ifany") 
porcentajeNulos[20] <- length(dataset[dataset$D_CLIMATOLOGIA == "Unknown",20])/length(dataset[dataset$D_CLIMATOLOGIA,20])*100
porcentajeNulos[20]

#columna 21
table(dataset$D_FUNC_ESP_VIA, useNA = "ifany") # we look if there are null values
levels(dataset$D_FUNC_ESP_VIA)[levels(dataset$D_FUNC_ESP_VIA)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_FUNC_ESP_VIA, useNA = "ifany") 

#columna 22
table(dataset$D_GRAVETAT, useNA = "ifany") # we look if there are null values

#columna 23
table(dataset$D_INFLUIT_BOIRA, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_BOIRA)[levels(dataset$D_INFLUIT_BOIRA)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_BOIRA, useNA = "ifany")

#columna 24
table(dataset$D_INFLUIT_CARACT_ENTORN, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_CARACT_ENTORN)[levels(dataset$D_INFLUIT_CARACT_ENTORN)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_CARACT_ENTORN, useNA = "ifany")

#columna 25
table(dataset$D_INFLUIT_CIRCULACIO, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_CIRCULACIO)[levels(dataset$D_INFLUIT_CIRCULACIO)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_CIRCULACIO, useNA = "ifany")

#columna 26
table(dataset$D_INFLUIT_ESTAT_CLIMA, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_ESTAT_CLIMA)[levels(dataset$D_INFLUIT_ESTAT_CLIMA)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_ESTAT_CLIMA, useNA = "ifany")

#columna 27
table(dataset$D_INFLUIT_INTEN_VENT, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_INTEN_VENT)[levels(dataset$D_INFLUIT_INTEN_VENT)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_INTEN_VENT, useNA = "ifany")

#columna 28
table(dataset$D_INFLUIT_LLUMINOSITAT, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_LLUMINOSITAT)[levels(dataset$D_INFLUIT_LLUMINOSITAT)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_LLUMINOSITAT, useNA = "ifany")

#columna 29
table(dataset$D_INFLUIT_MESU_ESP, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_MESU_ESP)[levels(dataset$D_INFLUIT_MESU_ESP)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_MESU_ESP, useNA = "ifany")

#columna 30
table(dataset$D_INFLUIT_OBJ_CALCADA, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_OBJ_CALCADA)[levels(dataset$D_INFLUIT_OBJ_CALCADA)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_OBJ_CALCADA, useNA = "ifany")

#columna 31
table(dataset$D_INFLUIT_SOLCS_RASES, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_SOLCS_RASES)[levels(dataset$D_INFLUIT_SOLCS_RASES)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_SOLCS_RASES, useNA = "ifany")

#columna 32
table(dataset$D_INFLUIT_VISIBILITAT, useNA = "ifany") # we look if there are null values
levels(dataset$D_INFLUIT_VISIBILITAT)[levels(dataset$D_INFLUIT_VISIBILITAT)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_INFLUIT_VISIBILITAT, useNA = "ifany")

#columna 33
table(dataset$D_INTER_SECCIO, useNA = "ifany") # we look if there are null values

#columna 34
table(dataset$D_LIMIT_VELOCITAT, useNA = "ifany") # we look if there are null values

#columna 33
table(dataset$D_LLUMINOSITAT, useNA = "ifany") # we look if there are null values
levels(dataset$D_LLUMINOSITAT)[levels(dataset$D_LLUMINOSITAT)=="Sense especificar"] <- "Unknown" # we change the Sense Especificar category to Unknown category
table(dataset$D_LLUMINOSITAT, useNA = "ifany")

levels(dataset$dat) <- c(levels(dataset$dat), "Unknown") # we add the column value "Unknown"
table(dataset$dat, useNA = "ifany") # we look if there are null values
dataset[is.na(dataset$dat),1] <- "Unknown" # we put Unknown in the rows whom values is NA
table(dataset$dat, useNA = "ifany") # we verify the changes


dataset$D_CARRIL_ESPECIAL
levels(dataset$D_CARRIL_ESPECIAL)
levels(dataset$D_CARRIL_ESPECIAL) <- c(levels(dataset$D_CARRIL_ESPECIAL), "Unknown")
table(dataset$D_CARRIL_ESPECIAL, useNA = "ifany")
dataset[is.na(dataset$D_CARRIL_ESPECIAL) |  dataset$D_CARRIL_ESPECIAL == "Sense Especificar",18]<- "Unknown"
levels(dataset$D_CARRIL_ESPECIAL) <- levels(dataset$D_CARRIL_ESPECIAL)[levels(dataset$D_CARRIL_ESPECIAL) != "Sense Especificar"]

factor(dataset$D_CARRIL_ESPECIAL)


dataset$D_CARRIL_ESPECIAL
levels(dataset$D_CARRIL_ESPECIAL)
levels(dataset$D_CARRIL_ESPECIAL) <- c(levels(dataset$D_CARRIL_ESPECIAL), "Unknown")
table(dataset$D_CARRIL_ESPECIAL, useNA = "ifany")
dataset[is.na(dataset$D_CARRIL_ESPECIAL) |  dataset$D_CARRIL_ESPECIAL == "Sense Especificar" ,18]<- "Unknown" 
dataset$D_CARRIL_ESPECIAL <- factor(dataset$D_CARRIL_ESPECIAL)
levels(dataset$D_CARRIL_ESPECIAL)


names(dataset)

#Seleccionar las columnas que queremos conservar en el nuevo dataset
dataset[,c(1,3,5,8)]
