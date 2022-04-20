

library(shiny)
library(knitr)
library(readxl)
library(ggplot2)
library(dplyr)

# Load the database
tidy_all_G <- read_excel("tidy_all_G.xlsx")
Freq_G  <- read_excel("Freq_G.xlsx")

server <- function(input, output, session) {

	output$plot <- renderPlot({

		# Histogram for WFE

		tidy_all_G %>%
		ggplot(aes(WFE))+
		geom_histogram(color="white",fill="deepskyblue4")+
		labs(title="Histograma", x="WFE", 
		     y="Frecuencia") 

		})

	output$plot2 <- renderPlot({

		# Gráfica de boxplot

		tidy_all_G %>% 
			filter(Marcador==input$marker) %>%
			ggplot(aes(x=Genotipo, y=WFE))+
			geom_boxplot(fill="deepskyblue4")+
			labs(title="Boxplot", x="Genotipo", y="Fenotipo") 

		})

	output$plot3 <- renderPlot({

		# Barplot for each QTL
		Freq_G  %>% 
			filter(Marcador==input$marker2) %>%
			ggplot(aes(x = Genotipo, y = n, fill=Genotipo)) +
			geom_col(position = position_dodge())+
			labs(title="QTL2", x= "Genotypes", y="Number of fish")+ 
			theme(text = element_text(size=20))+
			theme (axis.text.x = element_text(face="bold", colour="black"), axis.text.y = element_text(face="bold", colour="black", angle=90, hjust=0.5))+theme_classic(base_size=15)+
			theme(plot.title = element_text(size = 15, face = "bold"))+
			theme(axis.text.x = element_text(size = 15,face="bold",colour="black"))+
			theme(axis.text.y = element_text(size = 15,face="bold",colour="black"))+
			scale_y_continuous(limits=c(0,450))+
			theme(legend.position="none")+
			geom_text(aes(label =n),vjust =-0.5,position = position_dodge(0.9),size =5)+
			scale_x_discrete(labels=c("CC","TC","TT"))+
			scale_fill_manual(values = c("lightgray", "deepskyblue4", "coral"))
			})

}