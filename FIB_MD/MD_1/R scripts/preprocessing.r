library(stringr)

rm(list=ls(all=TRUE))
dev.off()
# loading dataset
setwd("../Original_Dataset");
DATASET_CATALAN_ <- read.csv("Practica.csv",header=T, sep=";");

# reading a .csv file was easier than an .xlsx

#DATASET_CATALAN_ <- read_excel(PATH) 

class(DATASET_CATALAN_) 
dim(DATASET_CATALAN_) # 11514 tuples x 50 variables
names(DATASET_CATALAN_)
numTuples<-dim(DATASET_CATALAN_)[1]; numTuples
numAtributs<-dim(DATASET_CATALAN_)[2]; numAtributs

missingDataValue <- 'Sense Especificar' # value used for indicating a missing information



# we look at each column

table(DATASET_CATALAN_$Any, useNA = "ifany")
table(DATASET_CATALAN_$zona, useNA = "ifany")
table(DATASET_CATALAN_$dat, useNA = "ifany")
table(DATASET_CATALAN_$via, useNA = "ifany")
table(DATASET_CATALAN_$pk, useNA = "ifany")                         # not important
table(DATASET_CATALAN_$nomMun, useNA = "ifany")
table(DATASET_CATALAN_$nomCom, useNA = "ifany")
table(DATASET_CATALAN_$nomDem, useNA = "ifany")
table(DATASET_CATALAN_$F_MORTS, useNA = "ifany")
table(DATASET_CATALAN_$F_FERITS_GREUS, useNA = "ifany")
table(DATASET_CATALAN_$F_FERITS_LLEUS, useNA = "ifany")
table(DATASET_CATALAN_$F_VICTIMES, useNA = "ifany")
table(DATASET_CATALAN_$F_UNITATS_IMPLICADES, useNA = "ifany")
table(DATASET_CATALAN_$C_VELOCITAT_VIA, useNA = "ifany")            # 14
table(DATASET_CATALAN_$D_ACC_AMB_FUGA, useNA = "ifany")             # 11279 values are "no" or null
table(DATASET_CATALAN_$D_BOIRA, useNA = "ifany")                    # 11462 equal values
table(DATASET_CATALAN_$D_CARACT_ENTORN, useNA = "ifany")            # 17
table(DATASET_CATALAN_$D_CARRIL_ESPECIAL, useNA = "ifany")          # 18
table(DATASET_CATALAN_$D_CIRCULACIO_MESURES_ESP, useNA = "ifany")   # 19
table(DATASET_CATALAN_$D_CLIMATOLOGIA, useNA = "ifany")
table(DATASET_CATALAN_$D_FUNC_ESP_VIA, useNA = "ifany")
table(DATASET_CATALAN_$D_GRAVETAT, useNA = "ifany")

# The following variables have a huge amount of equal values
###################
table(DATASET_CATALAN_$D_INFLUIT_BOIRA, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_CARACT_ENTORN, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_CIRCULACIO, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_ESTAT_CLIMA, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_INTEN_VENT, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_LLUMINOSITAT, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_MESU_ESP, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_OBJ_CALCADA, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_SOLCS_RASES, useNA = "ifany")
table(DATASET_CATALAN_$D_INFLUIT_VISIBILITAT, useNA = "ifany")
###################

table(DATASET_CATALAN_$D_INTER_SECCIO, useNA = "ifany")
table(DATASET_CATALAN_$D_LIMIT_VELOCITAT, useNA = "ifany")
table(DATASET_CATALAN_$D_LLUMINOSITAT, useNA = "ifany")
table(DATASET_CATALAN_$D_REGULACIO_PRIORITAT, useNA = "ifany")      # 36 # around 70% of nulls
table(DATASET_CATALAN_$D_SENTITS_VIA, useNA = "ifany")              # 37
table(DATASET_CATALAN_$D_SUBTIPUS_ACCIDENT, useNA = "ifany")        # 38
table(DATASET_CATALAN_$D_SUBTIPUS_TRAM, useNA = "ifany")            # 39 # around 70% of nulls
table(DATASET_CATALAN_$D_SUBZONA, useNA = "ifany")
table(DATASET_CATALAN_$D_SUPERFICIE, useNA = "ifany")               # 41
table(DATASET_CATALAN_$D_TIPUS_VIA, useNA = "ifany")                # 42
table(DATASET_CATALAN_$D_TITULARITAT_VIA, useNA = "ifany")          # we consider this data irrelevant
table(DATASET_CATALAN_$D_TRACAT_ALTIMETRIC, useNA = "ifany")        # 44
table(DATASET_CATALAN_$D_VENT, useNA = "ifany")
table(DATASET_CATALAN_$grupDiaLab, useNA = "ifany")                 # 46
table(DATASET_CATALAN_$hor, useNA = "ifany")
table(DATASET_CATALAN_$grupHor, useNA = "ifany")
table(DATASET_CATALAN_$tipAcc, useNA = "ifany")
table(DATASET_CATALAN_$tipDia, useNA = "ifany")


# REMOVING the columns that we think not are necessary
# This variables won't be informative in our data exploration or are redundant
#############
index <- grep("pk", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_TITULARITAT_VIA", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("tipDia", colnames(DATASET_CATALAN_)) 
DATASET_CATALAN_[,index] <- NULL
index <- grep("Any", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("nomMun", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("nomDem", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("via", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
#############


# REMOVING this variables because either they have a lot of rows (>90%) with the same value or a lot of NA data (~= 70%)
index <- grep("D_ACC_AMB_FUGA", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_BOIRA", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_BOIRA", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_CARACT_ENTORN", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_CIRCULACIO", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_ESTAT_CLIMA", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_INTEN_VENT", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_LLUMINOSITAT", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_MESU_ESP", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_OBJ_CALCADA", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_SOLCS_RASES", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_INFLUIT_VISIBILITAT", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_REGULACIO_PRIORITAT", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL
index <- grep("D_SUBTIPUS_TRAM", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- NULL


# We simplify the values of "dat", we only need the 'month' of the accident, using 
# the 'day' makes it harder to analyze data and find patterns

columnData = DATASET_CATALAN_$dat

DATASET_CATALAN_$dat <- NULL


newColumnData <- factor()
levels(newColumnData) <- c("01","02","03","04","05","06","07","08","09","10","11","12")

for(i in 1:numTuples) {
  fecha <- columnData[i]
  fecha <- as.character(fecha)
  fecha <- substr(fecha, 4, 5)
  fecha <- as.factor(fecha)
  newColumnData[i] <- fecha
}
newColumnData
DATASET_CATALAN_["dat"] <- newColumnData


columnData = DATASET_CATALAN_$hor

DATASET_CATALAN_$hor <- NULL

newColumnData <- factor()
levels(newColumnData) <- c(0:23)
for(i in 1:numTuples) {
  hora <- columnData[i]
  hora <- as.character(hora)
  indiceSubs <- str_locate(hora, "[,]")[1]
  if(!is.na(indiceSubs))
    hora <- substr(hora, 1,str_locate(hora, "[,]")[1]-1)
  hora <- as.factor(hora)
  newColumnData[i] <- hora
}
newColumnData
DATASET_CATALAN_["hor"] <- newColumnData


numAtributs<-dim(DATASET_CATALAN_)[2]
numAtributs 



# ********************EXAMPLE****************************
# Column 18 is whether the accident happened in a special via
# We replace missings and consider 'Altres' as missing data since it's equally informative.
# To add a new value to a categorical value(factor level), we must add it first this way
# it won't let us add it if it's not in the factor levels of that column

index <- grep("D_CARRIL_ESPECIAL", colnames(DATASET_CATALAN_))
levels(DATASET_CATALAN_$D_CARRIL_ESPECIAL)=c (levels(DATASET_CATALAN_$D_CARRIL_ESPECIAL),missingDataValue)
DATASET_CATALAN_[is.na(DATASET_CATALAN_$D_CARRIL_ESPECIAL),index]<-missingDataValue
DATASET_CATALAN_[(DATASET_CATALAN_$D_CARRIL_ESPECIAL)=='Altres',index]<-missingDataValue

# We remove the categorical values with no instances (no rows with that value)
DATASET_CATALAN_[,index] <- factor(DATASET_CATALAN_[,index])
# We check that we treated all the values we wanted 
table(DATASET_CATALAN_[,index])

# Column 14 is maximum speed,
# We replace missing values, 999 and 0 (these values don't make sense) into our default missing data value.

index <- grep("C_VELOCITAT_VIA", colnames(DATASET_CATALAN_))
DATASET_CATALAN_[,index] <- as.factor(DATASET_CATALAN_[,index])#convert to categorical variable
levels(DATASET_CATALAN_$C_VELOCITAT_VIA)=c (levels(DATASET_CATALAN_$C_VELOCITAT_VIA),missingDataValue)
DATASET_CATALAN_[is.na(DATASET_CATALAN_$C_VELOCITAT_VIA),index]<-missingDataValue
DATASET_CATALAN_[(DATASET_CATALAN_$C_VELOCITAT_VIA)=='999',index]<-missingDataValue
DATASET_CATALAN_[(DATASET_CATALAN_$C_VELOCITAT_VIA)=='0',index]<-missingDataValue
DATASET_CATALAN_[,index] <- factor(DATASET_CATALAN_[,index])
table(DATASET_CATALAN_$C_VELOCITAT_VIA, useNA = "ifany")
levels(DATASET_CATALAN_[,index])

# We unify all the missing data with a single value.
# Also, we join 'Altres' with the missing data value, since it's equally informative.
for(index in 1:numAtributs){
  levels(DATASET_CATALAN_[,index])=c (levels(DATASET_CATALAN_[,index]),missingDataValue)
  DATASET_CATALAN_[is.na(DATASET_CATALAN_[index]),index]<-missingDataValue
  DATASET_CATALAN_[(DATASET_CATALAN_[,index])=='Sense especificar',index]<-missingDataValue
  DATASET_CATALAN_[(DATASET_CATALAN_[,index])=='Altres',index]<-missingDataValue
  DATASET_CATALAN_[,index] <- factor(DATASET_CATALAN_[,index])
}

# Column 46 is a binary value, we must replace the variable and its values.

#index <- grep("grupDiaLab", colnames(DATASET_CATALAN_))
#names(DATASET_CATALAN_)[names(DATASET_CATALAN_) == 'grupDiaLab'] <- 'Feiner?'
#levels(DATASET_CATALAN_[,index])=c (levels(DATASET_CATALAN_[,index]),as.logical(1))
#levels(DATASET_CATALAN_[,index])=c (levels(DATASET_CATALAN_[,index]),as.logical(0))
#DATASET_CATALAN_[(DATASET_CATALAN_[,index])=='Feiners',index]<-'TRUE'
#DATASET_CATALAN_[(DATASET_CATALAN_[,index])=='CapDeSetmana',index]<-'FALSE'
#levels(DATASET_CATALAN_[,index])
# We remove the categorical values with no instances (no rows with that value)
#DATASET_CATALAN_[,index] <- factor(DATASET_CATALAN_[,index])
# We check that we treated all the values we wanted 
#table(DATASET_CATALAN_[,index])


#############################################################################################################################
#   
#                                                    ESTO NO ESTÁ REPETIDO?
#
#############################################################################################################################
# #anar executant ha estat util per comprovar si hi havia missing data
# #si poso el número es que hi havia missing data o s'han agut de fer canvis
 table(DATASET_CATALAN_$Any, useNA = "ifany")
 table(DATASET_CATALAN_$zona, useNA = "ifany")
 table(DATASET_CATALAN_$dat, useNA = "ifany")
 table(DATASET_CATALAN_$via, useNA = "ifany")
#table(DATASET_CATALAN_$pk, useNA = "ifany") #aquest no ens importa
 table(DATASET_CATALAN_$nomMun, useNA = "ifany")
 table(DATASET_CATALAN_$nomCom, useNA = "ifany")
 table(DATASET_CATALAN_$nomDem, useNA = "ifany")
 table(DATASET_CATALAN_$F_MORTS, useNA = "ifany")
 table(DATASET_CATALAN_$F_FERITS_GREUS, useNA = "ifany")
 table(DATASET_CATALAN_$F_FERITS_LLEUS, useNA = "ifany")
 table(DATASET_CATALAN_$F_VICTIMES, useNA = "ifany")
 table(DATASET_CATALAN_$F_UNITATS_IMPLICADES, useNA = "ifany")
 table(DATASET_CATALAN_$C_VELOCITAT_VIA, useNA = "ifany")#14
 table(DATASET_CATALAN_$D_ACC_AMB_FUGA, useNA = "ifany")
 table(DATASET_CATALAN_$D_BOIRA, useNA = "ifany")
 table(DATASET_CATALAN_$D_CARACT_ENTORN, useNA = "ifany")#17
 table(DATASET_CATALAN_$D_CARRIL_ESPECIAL, useNA = "ifany")#18
 table(DATASET_CATALAN_$D_CIRCULACIO_MESURES_ESP, useNA = "ifany")#19
 table(DATASET_CATALAN_$D_CLIMATOLOGIA, useNA = "ifany")
 table(DATASET_CATALAN_$D_FUNC_ESP_VIA, useNA = "ifany")
 table(DATASET_CATALAN_$D_GRAVETAT, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_BOIRA, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_CARACT_ENTORN, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_CIRCULACIO, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_ESTAT_CLIMA, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_INTEN_VENT, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_LLUMINOSITAT, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_MESU_ESP, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_OBJ_CALCADA, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_SOLCS_RASES, useNA = "ifany")
 table(DATASET_CATALAN_$D_INFLUIT_VISIBILITAT, useNA = "ifany")
 table(DATASET_CATALAN_$D_INTER_SECCIO, useNA = "ifany")
 table(DATASET_CATALAN_$D_LIMIT_VELOCITAT, useNA = "ifany")
 table(DATASET_CATALAN_$D_LLUMINOSITAT, useNA = "ifany")
 table(DATASET_CATALAN_$D_REGULACIO_PRIORITAT, useNA = "ifany")#36
 table(DATASET_CATALAN_$D_SENTITS_VIA, useNA = "ifany")#37
 table(DATASET_CATALAN_$D_SUBTIPUS_ACCIDENT, useNA = "ifany")#38
 table(DATASET_CATALAN_$D_SUBTIPUS_TRAM, useNA = "ifany")#39
 table(DATASET_CATALAN_$D_SUBZONA, useNA = "ifany")
 table(DATASET_CATALAN_$D_SUPERFICIE, useNA = "ifany")#41
 table(DATASET_CATALAN_$D_TIPUS_VIA, useNA = "ifany")#42
 #table(DATASET_CATALAN_$D_TITULARITAT_VIA, useNA = "ifany") we consider this data not interesting
 table(DATASET_CATALAN_$D_TRACAT_ALTIMETRIC, useNA = "ifany")#44
 table(DATASET_CATALAN_$D_VENT, useNA = "ifany")
 table(DATASET_CATALAN_$grupDiaLab, useNA = "ifany")#46
 table(DATASET_CATALAN_$hor, useNA = "ifany")
 table(DATASET_CATALAN_$grupHor, useNA = "ifany")
 table(DATASET_CATALAN_$tipAcc, useNA = "ifany")
 #table(DATASET_CATALAN_$tipDia, useNA = "ifany")
#############################################################################################################################
 #############################################################################################################################
 #############################################################################################################################



write.table(DATASET_CATALAN_, file = "Practica_processada.csv", sep = ";", na = "NA", dec = ".", row.names = FALSE, col.names = TRUE)

