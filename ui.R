rm(list=ls())
source("packages.R")
source("config.R")
navBarPageARGS = list(projectName)
navbarPagePerso = do.call(navbarPage, navBarPageARGS)
fluidPage(theme = shinytheme("flatly"),
          tags$head(
            tags$style(HTML(
              ".navbar .navbar-nav {
                margin-left: 30%"))),
          tags$head(
            tags$style(HTML(
              ".navbar-default {
                background-color: rgb(172,30, 68);
                border-color: transparent;}"))),
          navbarPagePerso,
          sidebarLayout(
            sidebarPanel( 
              br(),
              br(),
              h2(strong("Please fill in the following information"), align ="center"),
              h4(br(),
                 br(),
                 numericInput("age", "1 - Age (in years)", min = 18, max = 120, value = NA),               
                 br(),
                 radioButtons("respiratory", "2 - Respiratory status \n (3 possibilities)", 
                              c("Without oxygen" = 1,
                                "Oxygen by nasal prongs or mask " = 2,
                                "High flow oxygen or non invasive ventilation" = 3),
                              selected = NULL),
                 br(),
                 numericInput("CRP", "3 - C Reactive Protein plasma level \n (in mg/L)", min = 0, max = 500, value = NA),      
                 br(),
                 numericInput("lymphocytes", "4 - Lymphocytes count \n (in number / mm3)", min = 0, max = 10000, value = NA),              
                 br(),
                 br(),
                 div(id="footer",class="flex-row flex-between",
                     div(em("Application optimized for ",
                            a("Chrome",href = "https://www.google.fr/chrome/browser/desktop/",target="_blank")," .")),
                     div("Copyright © ", a("Ményssa CHERIFA", href = "https://fr.linkedin.com/in/menyssacherifa", target="_blank"),
                         ". All rights reserved.")))),
            mainPanel(
              uiOutput("MainAction")
            )
          )
)



