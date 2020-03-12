
library(shiny)
library(rvest)
library(stringr)

ui <- fluidPage(

    textInput("url", "Enter UKC logbook URL"),
    actionButton("submit_url", "Analyse my logbook"),
    uiOutput("status_message")

    
)

server <- function(input, output) {

    logBook_html <- reactiveVal(NULL)
    
    observeEvent(input$submit_url, {
        
        logBook_html <- tryCatch(
            
             read_html(input$url),
            
            error = function(cond) {
                output$status_message <- renderUI({"Sorry! We couldn't read this URL, please try again!"})
                return(NULL)
                
            }
        )
        
        print(logBook_html)
        
    })
    
    
    observeEvent(logBook_html, {

        output$status_message <- renderUI({"Success! Analysing your profile ..."})


    })
    
    
}




shinyApp(ui = ui, server = server)
