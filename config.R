options(shiny.sanitize.errors = TRUE)
tableau <-  read.csv("data/score_coef.csv", sep = ";", dec = ",") 
projectName <- "Prediction Model for COVID-19 "
data_score = data.frame(value_score = rep(0, 9),
                        index = 0:8)