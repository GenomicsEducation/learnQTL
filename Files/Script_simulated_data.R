# Scrip learnQTL: Simula marcadores genéticos con (QTL) y sin asociación a un rasgo cuantitativo. 
# Dr. José Gallardo Matus y Dra. María Angélica Rueda
# Pontificia Universidad Católica de Valparaíso
# Abril 2022

# Habilita paquetes
library(ggplot2)
library(xlsx)
library(dplyr)
library(readxl)
library(tidyr) # Para manipular datos

# Remover objetos de la lista
rm(list=ls())


# Simulating genotype data
set.seed(2022)
genotypes_1 <- sample(c("CC","TC","TT"), size = 1000, replace = TRUE)
genotypes_2 <- sample(c("CC","AC","AA"), size = 1000, replace = TRUE)
G1<- matrix(genotypes_1, nrow = 1000, ncol= 2, byrow = TRUE)
G2<- matrix(genotypes_2, nrow = 1000, ncol= 2, byrow = TRUE)
G3<- matrix(genotypes_1, nrow = 1000, ncol= 2, byrow = TRUE)
G4<- matrix(genotypes_2, nrow = 1000, ncol= 2, byrow = TRUE)
G5<- matrix(genotypes_1, nrow = 1000, ncol= 2, byrow = TRUE)

G <- data.frame(G1,G2,G3,G4,G5)

colnames(G) <- c("M1", "M2", "M3", "M4", "M5", "M6", "M7", "M8", "M9", "M10")
G

# Simulating Molecular markers
set.seed(2022)
MM_1 <- sample(c("0","1","2"), size = 1000, replace = TRUE)
MM_2 <- sample(c("0","1","2"), size = 1000, replace = TRUE)
M1<- matrix(MM_1, nrow = 1000, ncol= 2, byrow = TRUE)
M2<- matrix(MM_2, nrow = 1000, ncol= 2, byrow = TRUE)
M3<- matrix(MM_1, nrow = 1000, ncol= 2, byrow = TRUE)
M4<- matrix(MM_2, nrow = 1000, ncol= 2, byrow = TRUE)
M5<- matrix(MM_1, nrow = 1000, ncol= 2, byrow = TRUE)

MM <- data.frame(M1,M2,M3,M4,M5)

colnames(MM) <- c("M1", "M2", "M3", "M4", "M5", "M6", "M7", "M8", "M9", "M10")
MM

# Simulating Phenotype data
set.seed(2022)
WFE <-  rnorm(1000, mean = 6078, sd = 1190)
ID <- seq(1:1000)
pheno_data_WFE <- data.frame(ID,WFE)

# Database with molecular markers and phenotype information
data_all_MM <- data.frame(ID,MM,WFE)

# From messy data to tidy data
tidy_all_MM <- data_all_MM %>% gather("Marcador","Genotipo",2:11)

# Save the dataset
write.xlsx (tidy_all_MM , file="tidy_all_MM.xlsx", row.names = FALSE)

# Database with genotypes and phenotype information
data_all_G <- data.frame(ID,G,WFE)

# From messy data to tidy data
tidy_all_G <- data_all_G %>% gather("Marcador","Genotipo",2:11)
class(tidy_all_G)
# Save the dataset
write.xlsx(tidy_all_G, file="tidy_all_G.xlsx",row.names = FALSE)

# Calcula y exporta frecuencia
Freq_G <- tidy_all_G %>%
  group_by(Marcador, Genotipo) %>%
  summarize(n=n()) %>%
  mutate(freq = n/sum(n))
Freq_G <- as.data.frame(Freq_G)
class(Freq_G)

# Save the dataset
write.xlsx(Freq_G, file="Freq_G.xlsx",row.names = FALSE)

