library(shiny)
library(plotly)
library(stringr)
library(rvest)
library(httr)

shinyServer(function(input, output) {
  output$plot1 <- renderPlotly({
    #set.seed(2016-05-25)
    #number_of_points <- input$numeric
    url<-"http://www.metacritic.com/browse/games/release-date/new-releases/ps4/metascore"
    webpage<-read_html(url)
    selector<-'[class*="metascore_w"]' 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    metascore<-data
    selector<-'[class*="data textscore"]' 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    userscore<-data
    selector<-'[class*="basic_stat product_title"]>a' #a tag descendants from class that contains basic_stat product title 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    title<-lapply(data, function(x) str_replace_all(str_replace_all(x,"  ",""),"\\n",""))
    PS4_DF<-as.data.frame(cbind(title,metascore,userscore))
    PS4_DF$title<-as.character(PS4_DF$title)
    PS4_DF$userscore<-as.numeric(PS4_DF$userscore)
    PS4_DF$metascore<-as.numeric(PS4_DF$metascore)

    url<-"http://www.metacritic.com/browse/games/release-date/new-releases/xboxone/metascore"
    webpage<-read_html(url)
    selector<-'[class*="metascore_w"]' 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    metascore<-data
    selector<-'[class*="data textscore"]' 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    userscore<-data
    selector<-'[class*="basic_stat product_title"]>a' #a tag descendants from class that contains basic_stat product title 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    title<-lapply(data, function(x) str_replace_all(str_replace_all(x,"  ",""),"\\n",""))
    XOne_DF<-as.data.frame(cbind(title,metascore,userscore))
    XOne_DF$title<-as.character(XOne_DF$title)
    XOne_DF$userscore<-as.numeric(XOne_DF$userscore)
    XOne_DF$metascore<-as.numeric(XOne_DF$metascore)
  
    url<-"http://www.metacritic.com/browse/games/release-date/new-releases/pc/metascore"
    webpage<-read_html(url)
    selector<-'[class*="metascore_w"]' 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    metascore<-data
    selector<-'[class*="data textscore"]' 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    userscore<-data
    selector<-'[class*="basic_stat product_title"]>a' #a tag descendants from class that contains basic_stat product title 
    data<-html_nodes(x=webpage,css=selector) %>% html_text()
    title<-lapply(data, function(x) str_replace_all(str_replace_all(x,"  ",""),"\\n",""))
    PC_DF<-as.data.frame(cbind(title,metascore,userscore))
    PC_DF$title<-as.character(PC_DF$title)
    PC_DF$userscore<-as.numeric(PC_DF$userscore)
    PC_DF$metascore<-as.numeric(PC_DF$metascore) 
    
    
    minX <- input$sliderX[1] #userscore
    maxX <- input$sliderX[2]
    minY <- input$sliderY[1] #metascore
    maxY <- input$sliderY[2]
    
    PC_DF<-PC_DF[PC_DF$userscore>minX&PC_DF$userscore<maxX,]
    PC_DF<-PC_DF[PC_DF$metascore>minY&PC_DF$metascore<maxY,]
    
    XOne_DF<-XOne_DF[XOne_DF$userscore>minX&XOne_DF$userscore<maxX,]
    XOne_DF<-XOne_DF[XOne_DF$metascore>minY&XOne_DF$metascore<maxY,]
    
    PS4_DF<-PS4_DF[(PS4_DF$userscore>minX&PS4_DF$userscore<maxX),]
    PS4_DF<-PS4_DF[(PS4_DF$metascore>minY&PS4_DF$metascore<maxY),]
    
    #dataX <- runif(number_of_points, minX, maxX)
    #dataY <- runif(number_of_points, minY, maxY)
    #xlab <- ifelse(input$show_xlab, "X Axis", "")
    #ylab <- ifelse(input$show_ylab, "Y Axis", "")
    #main <- ifelse(input$show_title, "Title", "")
    p<-plot_ly(mode="markers",type="scatter") %>% layout(
        xaxis = list(title = "User Score"),
        yaxis = list(title = "Metascore")
        ) 
    if (input$show_PS4 == TRUE)
    {    
      #plot(PS4_DF$userscore, PS4_DF$metascore, xlab = "User Score", ylab = "Metascore", main = "Top Releases",
      #xlim = c(0, 10), ylim = c(0, 100))
      #subplot
      #{
          p <- add_markers(p,x=PS4_DF$userscore, y=PS4_DF$metascore, text=PS4_DF$title, name = "PS4", color = I("blue"), mode="markers") 
      #}
      #p<-plot_ly(mode="markers",type="scatter") %>% add_markers(x=PS4_DF$userscore,y=PS4_DF$metascore,color=PS4_DF$userscore)
    }
    if (input$show_XOne == TRUE)
    {
      p <- add_markers(p,x=XOne_DF$userscore, y=XOne_DF$metascore, text=XOne_DF$title, name = "X-Box One", color = I("red"), mode="markers")
    }
    if (input$show_PC == TRUE)
    {
      p <- add_markers(p,x=PC_DF$userscore, y=PC_DF$metascore, text=PC_DF$title, name = "PC", color = I("green"), mode="markers")
    }
    
    p
  })
})