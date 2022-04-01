library(ggplot2)
library(xlsx)
library(dplyr)
library(readxl)


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

# Save the dataset
write.xlsx (data_all_MM, file="data_all_MM.xlsx", row.names = FALSE)

# Load the database
data_all_MM <- read_excel("data_all_MM.xlsx")

# Database with genotypes and phenotype information
data_all_G <- data.frame(ID,G,WFE)

# Save the dataset
write.xlsx (data_all_G, file="data_all_G.xlsx",row.names = FALSE)

# Load the database
data_all_G <- read_excel("data_all_G.xlsx")

# QTLs frequency
Frec_M1<- data_all_G%>%
      group_by(M1)%>%
      summarise(n= n())

Frec_M2<- data_all_G%>%
          group_by(M2)%>%
          summarise(n= n())

Frec_M3<- data_all_G%>%
          group_by(M3)%>%
          summarise(n= n())

Frec_M4<- data_all_G%>%
          group_by(M4)%>%
          summarise(n= n())

Frec_M5<- data_all_G%>%
          group_by(M5)%>%
          summarise(n= n())

Frec_M6<- data_all_G%>%
          group_by(M6)%>%
          summarise(n= n())

Frec_M7<- data_all_G%>%
          group_by(M7)%>%
          summarise(n= n())

Frec_M8<- data_all_G%>%
          group_by(M8)%>%
          summarise(n= n())

Frec_M9<- data_all_G%>%
          group_by(M9)%>%
          summarise(n= n())

Frec_M10<- data_all_G%>%
           group_by(M10)%>%
           summarise(n= n())

# Barplot for each QTL
ggplot(data = Frec_M2, aes(x = M2, y = n,fill=M2)) +
  geom_col(position = position_dodge())+labs(title="QTL2", x= "Genotypes", y="Number of fish")+ 
  theme(text = element_text(size=20))+
  theme (axis.text.x = element_text(face="bold", colour="black"), axis.text.y = element_text(face="bold", colour="black", angle=90, hjust=0.5))+theme_classic(base_size=15)+
  theme(plot.title = element_text(size = 15, face = "bold"))+
  theme(axis.text.x = element_text(size = 15,face="bold",colour="black"))+
  theme(axis.text.y = element_text(size = 15,face="bold",colour="black"))+
  scale_y_continuous(limits=c(0,450))+
  theme(legend.position="none")+geom_text(aes(label =n),vjust =-0.5,position = position_dodge(0.9),size =5)+
  scale_x_discrete(labels=c("CC","TC","TT"))+
  scale_fill_manual(values = c("lightgray", "deepskyblue4", "coral"))+
  geom_segment(aes(x =1,y =310,xend =3,yend =350),
                arrow = arrow(length = unit(0.5,"cm")),size = 2)

