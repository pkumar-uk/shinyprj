
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(googleVis)
library(plyr)

whod<-read.csv("whodata1.csv")
selp<- c("GHOCD","YEAR","REGIOND","INCMCD",  "CNTRYCD","SEXCD","Year")
selpd<- c("Life Expectancy Type","YEAR","Region","Income Group",  "Country","Sex","Expectancy in Year")




shinyServer(function(input, output) {
        
        formulaText <- reactive({
                paste("(Selection: Life Expectancy years > ",input$year, 
                      ";Data year~", input$syear, 
                      ";Population Type~", input$spop,
                      ";Type of Life Expectancy~", input$sghoc,")")       })
        formulaText1 <- reactive({
                paste("(Selection: Life Expectancy years > ",input$year, 
                      ";Population Type~", input$spop,
                      ";Type of Life Expectancy~", input$sghoc,")")       })
        
        output$caption <- renderText({
                                formulaText()
        })
        
        output$caption3 <- renderText({
                formulaText1()
        })
        
        output$caption1 <- renderText({
                tx1<-input$sghoc
                if (tx1=="WHOSIS_000001") {tx2 <- "Life expectancy at birth"}
                if (tx1=="WHOSIS_000002") {tx2 <- "Healthy life expectancy (HALE) at birth"}
                if (tx1=="WHOSIS_000015") {tx2 <- "Life expectancy at age 60"}
                tx2 <- paste("Type of Life Expectancy:",tx2, " for year ", input$syear)
                return(tx2)
        })
        
        output$caption2 <- renderText({
                tx1<-input$sghoc
                if (tx1=="WHOSIS_000001") {tx2 <- "Life expectancy at birth"}
                if (tx1=="WHOSIS_000002") {tx2 <- "Healthy life expectancy (HALE) at birth"}
                if (tx1=="WHOSIS_000015") {tx2 <- "Life expectancy at age 60"}
                tx2 <- paste("Type of Life Expectancy:",tx2)
                return(tx2)
        })
        
        
        output$mplot1 <- renderGvis({
                pyears <- input$year
                psyear <- input$syear
                pspop  <- input$spop
                psghoc <- input$sghoc
                if (input$WB_HI == TRUE) { w1<-c("WB_HI")}   else { w1<-c("")}
                if (input$WB_LI == TRUE) { w2<-c("WB_LI")}   else { w2<-c("")}
                if (input$WB_LMI == TRUE) { w3<-c("WB_LMI")} else { w3<-c("")}
                if (input$WB_UMI == TRUE) { w4<-c("WB_UMI")} else { w4<-c("")}
                pinc<-c(w1,w2,w3,w4)
                p1 <- whod[whod$SEXC==pspop & whod$GHOC==psghoc & whod$YEAR==psyear & whod$INCMC %in% pinc & whod$Year > pyears,selp]
                p2<-p1[,c("CNTRYCD","Year")]
                names(p2)<- c("Country","Life Expectancy(yrs)")
                p3 <- ddply(p1,.(REGIOND,INCMCD),summarize,Life=floor(mean(Year)))
                names(p3)<-c("Region","Income Group","Life Expectancy(yrs)")

                m<-gvisGeoChart(p1, locationvar="CNTRYCD",colorvar="Year",  
                                options=list( height=350,displayMode='auto', 
                                              colorAxis="{values:[40,60,75,80],colors:[\'red', \'pink\', \'orange',\'green']}"))
                q<-gvisTable(p3,options=list(page="enable",pageSize=5,sort="enable"))
                p<-gvisTable(p2,options=list(page="enable",pageSize=5,sort="enable"))
                gt<-gvisMerge(q,p,horizontal=TRUE,
                              tableOptions="cellspacing=\"20\" bgcolor=\"#AABBCC\"")
                gtm <- gvisMerge(m,gt, horizontal=FALSE,
                             tableOptions="bgcolor=\"#CCCCCC\" cellspacing=10")
                return(gtm)
        })

        output$mplot2 <- renderGvis({
                pyears <- input$year
                psyear <- input$syear
                pspop  <- input$spop
                psghoc <- input$sghoc
                if (input$WB_HI == TRUE) { w1<-c("WB_HI")}   else { w1<-c("")}
                if (input$WB_LI == TRUE) { w2<-c("WB_LI")}   else { w2<-c("")}
                if (input$WB_LMI == TRUE) { w3<-c("WB_LMI")} else { w3<-c("")}
                if (input$WB_UMI == TRUE) { w4<-c("WB_UMI")} else { w4<-c("")}
                pinc<-c(w1,w2,w3,w4)
                p1 <- whod[whod$SEXC==pspop & whod$GHOC==psghoc & whod$YEAR==psyear & whod$INCMC %in% pinc & whod$Year > pyears,selp]
                p2 <- whod[whod$SEXC==pspop & whod$GHOC==psghoc & whod$INCMC %in% pinc & whod$Year > pyears,selp]
                p3<- p2
                names(p3)<- selpd
                p<-t<-gvisMotionChart(p2,idvar="CNTRYCD",timevar="YEAR", colorvar="CNTRYCD")
                
                return(p)
                
        })
        


})
