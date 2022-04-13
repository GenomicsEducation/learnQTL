library(shiny)
library(readxl)

tidy_all_G <- read_excel("tidy_all_G.xlsx")
Freq_G  <- read_excel("Freq_G.xlsx")

ui <- fluidPage(

      br(), br(), br(), br(),

         fluidRow(column(2),
                    column(8,
                           
             navbarPage(

##################################
# ENCABEZADO
				position = "fixed-top",
				title = div(
				            img(src = "fish.jpg",
				                height = "50px",
				                style = "position: relative;
				                bottom: 15px"), 
				            div("learnQTL",
				                style = "position: relative;
				                top: -50px;
				                right: -75px;
				                font-weight: bold;
				                color: #104E8B; 
				                font-size: 25px;
				                width:180px"), 
				            div(img(src = 'logo.png', 
				                height= "50px",
				                width= "130px", 
				                style = "position: relative;
				                top: -85px;
				                left: 1300px") )
				            ),

##################################
# PESTAÑAS

				tabPanel(div("INTRODUCCIÓN"),

				         h1(style="font-weight: bold",
				                   "learnQTL:", tags$br(), tags$br(),
				                   "Aplicación Shiny© para visualizar y comprender el efecto de un QTL sobre un rasgo cuantitativo.", tags$br(),tags$br(),"Una App del Laboratorio Genomica Aplicada.", tags$br()," PUCV."),
				        h2("¿Qué es un QTL?"),
						h2("Simulación de QTL."),
						h2("Interpretación."),
						h2("Uso"),
						h2("Esta aplicación tiene propósitos docentes.")

						),
##################################
# PANEL SELECCION Y GRAFICOS
# HISTOGRAMA

         	      tabPanel(div("HISTOGRAMA"),
                            
         	                  sidebarPanel(
# TEXTO
         	                         h4("texto")
         	                            ),

         	                  mainPanel(plotOutput("plot"))
         	                  ),

# BOX PLOT
				tabPanel(div("BOX PLOT"),

				         sidebarPanel(
				                      selectInput("marker", label = "Marcador:",
				                                  choices = unique(tidy_all_G$Marcador), selected = "M1"),
# TEXTO
									h3("texto")
				                      ),
				         mainPanel(plotOutput("plot2"))

				         ),

# BAR PLOT
				tabPanel(div("BAR PLOT"),

				         sidebarPanel(
				                      selectInput("marker2", label = "Marcador:",
				                                  choices = unique(Freq_G$Marcador), selected = "M1"),
				                      h3("texto")

				                      ),
				         mainPanel(plotOutput("plot3"))

				         ),

				tabPanel(div("", style= "width:400px")),

# LICENCIA
				tabPanel(div("LICENCIA"),

				         mainPanel(

				                   h3("Shiny© es una marca registrada de RStudio, PBC."),
									br(),
				                   h4("This app is distributed under GPL-3 (GNU GENERAL PUBLIC LICENSE version 3). This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3 (GPL-3) as published by the Free Software Foundation."),
									br(),
				                   h4("This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details (https://www.gnu.org/licenses/gpl.txt)."),
									br(), br(), br(), br(),
				                   )
				         ),

# NOSOTROS
				tabPanel(div("NOSOTROS"),

				         mainPanel(

				                    h1("Desarroladores:"),
									h2("José Andrés Gallardo Matus"),
									h4("Doctor en Ciencias por la Universidad de Chile, Chile.
									Biólogo Marino por la Universidad Católica de la Santísima Concepción, Chile.
									Profesor de genética y genómica aplicada en la Pontificia Universidad Católica de Valparaíso, Chile. Laboratorio de genética y genómica aplicada"),

									h2("María Angélica Rueda Calderón:"),
									h4("Licenciada en Matemáticas por la Universidad Industrial de Santander, Colombia.
									Doctora en Ciencias Agropecuarias por la Universidad Nacional de Córdoba, Argentina.
									Investigadora post-doctoral de la Pontificia Universidad Católica de Valparaíso."),

									h2("Rodrigo Javier Badilla Cabrera:"),
									h4("Biólogo Marino por la Universidad de Valparaíso, Chile.
									Diploma de estudios avanzados por la Universidad de la Palmas de Gran Canaria, España.")

				                   )

						)
				),
##################################
# LINKS

actionButton(inputId='ab1', 
          label="https://genomics.pucv.cl/", 
          icon = icon("th"), 
          onclick ="window.open('https://genomics.pucv.cl/', '_blank')"),

actionButton(inputId='ab1', 
             label="Github learnQTL", 
             icon = icon("th"), 
             onclick ="window.open('https://github.com/GenomicsEducation/learnQTL', '_blank')")

)))
