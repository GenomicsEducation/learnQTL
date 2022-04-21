# Script learnQTL: Analiza marcadores genéticos con (QTL) y sin asociación a un rasgo cuantitativo. 
# Dr. José Gallardo Matus y Dra. María Angélica Rueda Calderón.
# Pontificia Universidad Católica de Valparaíso.
# Abril 2022

# Load the libraries
library(ggplot2)
library(xlsx)
library(dplyr)
library(readxl)

# Remove objects in workspace
rm(list=ls())

# Load the database
tidy_all_G <- read_excel("tidy_all_G.xlsx")

# Load the database
tidy_all_MM <- read_excel("tidy_all_MM.xlsx")

# Load the database
Freq_G  <- read_excel("Freq_G.xlsx")

# Histogram for WFE
ggplot(tidy_all_G, aes(WFE))+
  geom_histogram(color="white",fill="deepskyblue4",bins = 30)+
  labs(title="Histograma", x="WFE", 
       y="Frecuencia") 

# Graph boxplot
tidy_all_G %>% filter(Marcador=="M2") %>%
  ggplot(aes(x=as.factor(Genotipo), y=WFE))+
  geom_boxplot(fill="deepskyblue4")+
  labs(title="Boxplot", x="Genotipo", y="Fenotipo") 


# Barplot for each QTL
Freq_G  %>% filter(Marcador=="M1") %>% 
  ggplot(aes(x = Genotipo, y = n, fill=Genotipo)) +
  geom_col(position = position_dodge())+labs(title="QTL", x= "Genotypes", y="Number of fish")+ 
  theme(text = element_text(size=20))+
  theme (axis.text.x = element_text(face="bold", colour="black"), axis.text.y = element_text(face="bold", colour="black", angle=90, hjust=0.5))+
  theme_classic(base_size=15)+
  theme(plot.title = element_text(size = 15, face = "bold"))+
  theme(axis.text.x = element_text(size = 15,face="bold",colour="black"))+
  theme(axis.text.y = element_text(size = 15,face="bold",colour="black"))+
  scale_y_continuous(limits=c(0,900))+
  theme(legend.position="none")+geom_text(aes(label =n),vjust =-0.5,position = position_dodge(0.9),size =5)+
  scale_fill_manual(values = c("lightgray", "deepskyblue4", "coral"))
