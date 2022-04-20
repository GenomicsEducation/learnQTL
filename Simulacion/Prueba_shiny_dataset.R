# Script learnQTL: Simula marcadores genéticos con (QTL) y sin asociación a un rasgo cuantitativo. 
# Dr. José Gallardo Matus y Dra. María Angélica Rueda Calderón.
# Pontificia Universidad Católica de Valparaíso
# Abril 2022

# Load the libraries
library(ggplot2)
library(xlsx)
library(dplyr)
library(readxl)
library(tidyr) # To manipulate data

# Remove objects in workspace
rm(list=ls())

# Simulating genotype data
set.seed(2022)
M <- matrix(rep(0,10*1000),1000,10)
for (i in 1:10) {
  M[,i] <- rbinom(1000,2,0.5)
}

colnames(M) <- c("M1", "M2", "M3", "M4", "M5", "M6", "M7", "M8", "M9", "M10")
M
geno <- data.frame(M,check.names=FALSE)

# Simulated phenotype

# Positive associated marker with phenotype data
set.seed(2022)
wfe_means_pos <- c(5500, 5750, 6000)
wfe_sd <- 1190

wfe_pos <- rnorm(1000, wfe_means_pos[factor(M)],wfe_sd)

snp.wfe <- data.frame(cbind(M, wfe_pos))

M1_def <- snp.wfe$M1


# Negative associated marker with phenotype data
set.seed(2022)
wfe_means_pos_1 <- c(6000, 5570, 5500)
wfe_pos_1 <- rnorm(1000, wfe_means_pos_1[factor(M)],wfe_sd)

snp.wfe_1 <- data.frame(cbind(M, wfe_pos_1))

plot(as.factor(snp.wfe_1$M1),snp.wfe_1$wfe_pos_1,main="Variación de fenotipos en función de los genotipos", xlab="Alelo de referencia", ylab= "WFE")

M2_def <- snp.wfe_1$M1

# Marcador con dominancia completa
set.seed(2022)
wfe_means_pos_dom <- c(5750, 6000, 6000)

wfe_pos_dom <- rnorm(1000, wfe_means_pos_dom[factor(M)],wfe_sd)

snp.wfe_dom <- data.frame(cbind(M, wfe_pos_dom))

plot(as.factor(snp.wfe_dom$M1),snp.wfe_dom$wfe_pos_dom,main="Variación de fenotipos en función de los genotipos", xlab="Alelo de referencia", ylab= "WFE")

M3_def <- snp.wfe_dom$M1

# Database with molecular markers and phenotype information
data_all_MM <- data.frame(ID=seq(1:100),M1_def=snp.wfe$M1, M2_def=snp.wfe_1$M1,snp.wfe_dom[,-c(9:10)])
colnames(data_all_MM) <- c("ID", "M1", "M2", "M3", "M4", "M5", "M6", "M7", "M8", "M9", "M10","WFE")
data_all_MM

# From messy data to tidy data
tidy_all_MM <- data_all_MM %>% gather("Marcador","Genotipo",2:11)

# Save the dataset
write.xlsx (tidy_all_MM , file="tidy_all_MM.xlsx", row.names = FALSE)


comb1<- data.frame("letras"=c("CC","TC","TT"),"Num"=c(0,1,2))
comb2<- data.frame("letras"=c("CC","AC","AA"),"Num"=c(0,1,2))

data_all_G <- data_all_MM
for(k in 2:11){
guia<-sample(c(1,2),1)
for(i in 1:3){
if(guia==1){
index<-which(data_all_G[,k]==comb1[i,2])
data_all_G[index,k]<-comb1[i,1]
}else{
index<-which(data_all_G[,k]==comb2[i,2])
data_all_G[index,k]<-comb2[i,1]  
}
}
}

# From messy data to tidy data
tidy_all_G <- data_all_G %>% gather("Marcador","Genotipo",2:11)

# Save the dataset
write.xlsx(tidy_all_G, file="tidy_all_G.xlsx",row.names = FALSE)

# Calculate and export frecuency
Freq_G <- tidy_all_G %>%
  group_by(Marcador, Genotipo) %>%
  summarize(n=n()) %>%
  mutate(freq = n/sum(n))
Freq_G <- as.data.frame(Freq_G)

# Save the dataset
write.xlsx(Freq_G, file="Freq_G.xlsx",row.names = FALSE)

