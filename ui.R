library(shinyjs)



shinyUI(
  fluidPage(
    title = "Monty Hall-How your brain confidently lies to you",
    useShinyjs(),
    # extendShinyjs(text = jsCode),
    theme = "style.css",
    includeScript("www/doors.js"),
    titlePanel("Monty Hall-How your brain confidently lies to you"),
    # fluidRow(
      # tags$head(tags$script(src = "doors.js")),
    
    tags$table(style = 'height: 400px',
      tags$tr(
        tags$td(
          column(4,
                 # tags$input(type = "checkbox", name = 'door1', id = 'door1'),
                 div(class = 'container',
                     div(class = 'card1', id = 'door1',
                         div(class = 'front', 
                             p(id = 'front_lebel1', "Door 1")
                         ), 
                         div(img(id= 'doorimage1', src = 'goat.jpg', alt = 'goat', height="100%", width="100%", style="vertical-align:unset;"), class = 'back'))),
                 actionButton('door1_btn', 'Select Door 1')
          ), 
          column(4, 
                 div(class = 'container', 
                     div(class = 'card1', id = 'door2',
                         div(class = 'front', 
                             p(id = 'front_lebel2', "Door 2")
                         ), 
                         div(img(id= 'doorimage2', src = 'goat.jpg', alt = 'goat', height="100%", width="100%", style="vertical-align:unset;"), class = 'back'))),
                 actionButton('door2_btn', 'Select Door 2')
          ), 
          column(4, 
                 div(class = 'container', 
                     div(class = 'card1', id = 'door3',
                         div(class = 'front',
                             p(id = 'front_lebel3', "Door 3")
                         ), 
                         div(img(id= 'doorimage3', src = 'goat.jpg', alt = 'goat', height="100%", width="100%", style="vertical-align:unset;"), class = 'back'))),
                 actionButton('door3_btn', 'Select Door 3')
          )
        )
        ),
      tags$tr(
        tags$td(
          hidden(textOutput('invisible_text'))
        )
      ),
      tags$tr(
        tags$td(
        hidden(actionButton('change_option_btn', 'Yes'),
               actionButton('not_change_option_btn', 'No'))
        )
      ),
      tags$tr(
        tags$td(
          hidden(
            # tagList(p(id = 'invisible_text', "Would you like to change your option"),
            
            textOutput('final_result'),
            actionButton('retry', 'Try again'))          
        )
      ),
      tags$tr(
        tags$td(
          plotOutput("visual_stat")
        )
      # )
    )

    
    )
  )
)