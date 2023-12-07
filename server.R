function(input, output) {
  
  score_calculation <- reactive({
    if(is.na(input$age) | is.na(input$respiratory) | is.na(input$CRP) | is.na(input$lymphocytes)){
      score <- " "
    }else if(input$age < 18 | input$age > 120){
      score <- " "
    }else if(input$CRP < 0 | input$CRP > 500){
      score <- " "
    }else if(input$lymphocytes < 0 | input$lymphocytes > 10000 ){
      score <- " "
    }else{
      score <- I(input$age > 60)*1 +
        I(input$respiratory==2)*1 +
        I(input$respiratory==3)*3 +
        I(input$CRP>=10 & input$CRP < 75)*2 +
        I(input$CRP >= 75 & input$CRP <150)*2 +
        I(input$CRP >=150)*3 +
        I(input$lymphocytes < 800)*1
    }
    return(score)
  })
  
  ICU_probability <- reactive({
    if(score_calculation() == " ") {
      return(" ")
    }else{
      prob <- round(tableau[tableau$score == score_calculation(), "prob_pred"],1)
      ci_lower <- round(tableau[tableau$score==score_calculation(), "ic_low_pred"], 1)
      ci_upper <- round(tableau[tableau$score==score_calculation(), "ic_up_pred"], 1)
      return(paste0(prob,"% [ ",ci_lower, " - ", ci_upper," ]"))
    }
  })
  
  output$score <- renderText({
    return(paste0("Score = ", score_calculation()))
  })
  
  output$plot <- renderPlot({
    
    position_score_calcul <-  score_calculation()
    
    q = ggplot(data_score, aes(x = index, y = value_score, color = index, label = index))+
      geom_point(aes(color = index), size = 20) + geom_label(size = 10)+
      geom_segment(aes(x = position_score_calcul, y = 0.5,
                       xend = position_score_calcul , yend = 0.3), 
                   arrow = arrow(length = unit(0.5, "cm")),
                   size = 1, alpha = 0.8, color = "#AC1E44"
      )+
      geom_segment(aes(x = -1, y = 0, xend = 9, yend = 0), 
                   arrow = arrow(length = unit(0.5, "cm")),
                   size = 0.1, alpha = 0.8, color = "grey"
      )+
      theme_bw() + 
      theme(legend.position = "none",
            panel.border = element_blank(), 
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            axis.text.y=element_blank(),
            axis.text.x=element_blank()
      ) +
      annotate("text", x = 0, y = 0.2, label = "Good", size = 10)+
      annotate("text", x = 8, y = 0.2, label = "Poor", size = 10)+
      annotate("text", x = 4, y = -0.25, label = "Score scale", size = 10)+
      ylab("") + xlab("") +
      scale_color_gradient(low="lightblue", high="red")+
      scale_y_discrete(breaks=NULL) +  scale_x_discrete(breaks=NULL)
    return(q)
    
  })
  
  output$prob <- renderText({
    return(paste0("Probability of ICU transfer or death within 14 days of admission = ", ICU_probability(), "*"))
  })
  
  dynamicUi <- reactive({
    if(is.na(input$age) || is.na(input$respiratory) || is.na(input$CRP) || is.na(input$lymphocytes)){
      return(" ")
    }else if(input$age < 18 | input$age > 120){
      return(
        list(
          br(),
          br(),
          br(),
          br(),
          h4(p(strong(span("Error: ", style = "color:#AC1E44")),
               "Please provide a value between 18 and 120 for the variable",
               strong("Age")))
        ))
    }else if(input$CRP < 0 | input$CRP > 500 ){
      return(
        list(
          br(),
          br(),
          br(),
          br(),
          h4(p(strong(span("Error: ", style = "color:#AC1E44")),
               "Please provide a value between 0 and 500 for the variable",
               strong(" C Reactive Protein")))
        ))
    }else if(input$lymphocytes < 0 | input$lymphocytes > 10000 ){
      return(
        list(
          br(),
          br(),
          br(),
          br(),
          h4(p(strong(span("Error: ", style = "color:#AC1E44")),
               "Please provide a value between 0 and 10.000 for the variable",
               strong("lymphocytes count"))) 
        ))
    }else{
      return(
        list(
          br(),
          br(),
          h2(strong("Results"), align ="center"),
          h2(withTags(ul(li(textOutput("score"))))),
          plotOutput("plot"),
          br(),
          h2(withTags(ul(li(textOutput("prob"))))),
          h3(p(em(' *[95% confidence interval]')))
        ))
    }
  })
  
  output$MainAction <- renderUI( {
    dynamicUi()
  })
  
}