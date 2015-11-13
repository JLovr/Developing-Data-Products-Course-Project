
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(UsingR)
library(caret)
library(ggplot2)
library(grid)

dat<-fat
rmlist=c(-182,-42,-48,-76,-96)
wn<-c("body.fat","age","weight","height","neck" ,"chest","abdomen")
dat<-dat[rmlist,wn]
set.seed(12432)
modbf<-lm(body.fat~age+weight+height+neck+chest+abdomen,data=dat)

# Multiple plot function
# from the Cookbook for R
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

shinyServer(function(input, output) {

  
  output$bf<-renderText({
      userdat<-data.frame(age=input$age,weight=input$weight,height=input$height,neck=input$neck*2.54,chest=input$chest*2.54,abdomen=input$abdomen*2.54)
      predict(modbf,newdata=userdat)

  })
  
  output$bfplot<-renderPlot({
    userdat<-data.frame(age=input$age,weight=input$weight,height=input$height,neck=input$neck*2.54,chest=input$chest*2.54,abdomen=input$abdomen*2.54)
    
    bf<-predict(modbf,newdata=userdat)
    
    bfp1<-ggplot(data=dat)
    bfp1<-bfp1 + geom_point(aes(y=body.fat,x=age,color="blue"))
    bfp1<-bfp1 + geom_point(y=bf,x=userdat$age,aes(color="red"),shape=18,size=5)
    bfp1<-bfp1 + ggtitle("Body Fat versus Age")
    bfp1<-bfp1 + scale_colour_manual(name = 'legend', 
                                     values =c('blue'='blue','red'='red'), labels = c('dataset','you'))

    
    bfp2<-ggplot(data=dat)
    bfp2<-bfp2 + geom_point(aes(y=body.fat,x=weight),color="blue")
    bfp2<-bfp2 + geom_point(y=bf,x=userdat$weight,color="red",shape=18,size=5)
    bfp2<-bfp2 + ggtitle("Body Fat versus Weight")
    
    bfp3<-ggplot(data=dat)
    bfp3<-bfp3 + geom_point(aes(y=body.fat,x=height),color="blue")
    bfp3<-bfp3 + geom_point(y=bf,x=userdat$height,color="red",shape=18,size=5)
    bfp3<-bfp3 + ggtitle("Body Fat versus Height")
    
    bfp4<-ggplot(data=dat)
    bfp4<-bfp4 + geom_point(aes(y=body.fat,x=abdomen),color="blue")
    bfp4<-bfp4 + geom_point(y=bf,x=userdat$abdomen,color="red",shape=18,size=5)
    bfp4<-bfp4 + ggtitle("Body Fat versus abdomen")
    
    multiplot(bfp1,bfp2,bfp3,bfp4)

  },
  height=600,
  width=400
  )
 })
