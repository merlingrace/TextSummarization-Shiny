
library(shiny)
library(shinythemes)
library(wordcloud2)
library(reticulate)
library(tm)

#------------------Functions------------------

source("./R/functions.R")
source_python("./PY/py_functions.py")
#----------------------UI----------------------
ui <- navbarPage( 
  title = "Text Summarizer",
          theme = shinytheme("cyborg"),
  #----------------------Home----------------------------------------------------
  tabPanel("Home",
           div(img(src='bg2.png', align = "left",width = 600,height = 600)),
           div(style = "margin-left:650px",
               
           HTML("<p text-align:center;'> <br><br><br><br><br><br><br><h1> Welcome!</h1><br> 
           Text summarization is the problem of creating a short, accurate,
           and fluent summary of a longer text document.Automatic text summarization
           methods are greatly needed to address the ever-growing amount of text data
           available online to both better help discover relevant
           information and to consume relevant information faster.
           <br><br>
           In this Tool, you will discover the problem of text summarization in natural language processing.<p>"))
           
           ),
  #----------------------Summary----------------------------------------------------
  tabPanel("Summary",
             fluidRow(column(4,
             textAreaInput("tab2_txt", "Enter Text",width = 500,height = 500)
             , actionButton("tab2_sum","Generate Summary"))
             , column(7,offset = 1,
            tabsetPanel(id = "sub_tabs",
              tabPanel("WordCloud"
            , wordcloud2Output("wordcloud_ui",width = 600,height = 500)),#tabPanel
            tabPanel("Summary"
                     ,uiOutput("summary_ui"))#tabPanel
           )#tabsetPanel
           ))
  )#tabPanel
 
)

# Define server logic 
server <- function(input, output,session) {
  hideTab("sub_tabs","WordCloud",session)
  hideTab("sub_tabs","Summary",session)
  # #---------------------wordcloud_ui-----------------------
  observeEvent(input$tab2_sum,{
    showTab("sub_tabs","WordCloud")
    showTab("sub_tabs","Summary")
    withProgress(message = 'Making plot'
                   , value = .5
                   ,{
  output$wordcloud_ui <- renderWordcloud2({
    create_wordcloud(input$tab2_txt, background = "black")
  })#renderWordcloud2
  
  #---------------------summary_ui-----------------------
  # browser()
  output$summary_ui <- renderUI({
   wellPanel(style = "background-color:white;width:700px;overflow-y:scroll; max-height: 300px;",HTML(paste0(get_summary(input$tab2_txt))))
  })#renderText
  })#withProgress
  })#observeEvent
}

#---------------------wordcloud_ui-----------------------

# Run the application 
shinyApp(ui = ui, server = server)
