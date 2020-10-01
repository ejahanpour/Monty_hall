source('R/global.R')


# Define server logic required to draw a histogram ----
server <- function(input, output, session) {
  options <- c('change', 'change', 'no_change', 'no_change')
  results <- c('win', 'lost', 'win', 'lost')
  freqs <- c(0, 0, 0, 0)
  percentages <- c(0, 0, 0, 0)
  game_stats <- data.frame(options, results, freqs, percentages)
  
  
  onclick('door1_btn', {
    scene <- set_the_scene()
    user_selection <- 1
    selected_door = scene[1][[1]]
    # send the message as a string including the first character as the selected door and the second one as opened one
    opened_door = open_door_with_goat(scene = scene, selected_door = selected_door)$number
    session$sendCustomMessage("door_to_open", paste0(selected_door$number,opened_door))
    output$invisible_text <- renderText({
      paste('You have selected door 1 and door', opened_door, 'is empty, \n
            would you like to change your option?')
    })
    show('invisible_text')
    show('change_option_btn')
    show('not_change_option_btn')
  })
  
  onclick('door2_btn', {
    scene <- set_the_scene()
    user_selection <- 2
    selected_door = scene[2][[1]]
    opened_door = open_door_with_goat(scene = scene, selected_door = selected_door)$number
    session$sendCustomMessage("door_to_open", paste0(selected_door$number,opened_door))
    output$invisible_text <- renderText({
      paste('You have selected door 2 and door', opened_door, 'is empty, \n
            would you like to change your option?')
    })
    show('invisible_text')
    show('change_option_btn')
    show('not_change_option_btn')
    
  })
  
  onclick('door3_btn', {
    scene <- set_the_scene()
    user_selection <- 3
    selected_door = scene[3][[1]]
    opened_door = open_door_with_goat(scene = scene, selected_door = selected_door)$number
    session$sendCustomMessage("door_to_open", paste0(selected_door$number, opened_door))
    output$invisible_text <- renderText({
      paste('You have selected door 3 and door', opened_door, 'is empty, \n
            would you like to change your option?')
    })
    show('invisible_text')
    show('change_option_btn')
    show('not_change_option_btn')
    
  })
  
  onclick('change_option_btn', {
    options = c(1, 2, 3)
    new_selection <- which(! options %in% c(user_selection, opened_door))
    # message to js would be 0 and 1 for goat and car (the index is the door number)
    message_to_js <- '000'
    if (scene[new_selection][[1]]$car == 1) {
      # the message is a concatenation of the user's new selection and the door with car, 
      # in this case changing the door worked
      message_to_js <- new_selection
      message_to_user <- 'Yaaay! You changed your option and you won!!! :)'
      game_stats <- update_stat(game_stats, changed = TRUE, win = TRUE)
    } else {
      # otherwise the user's first selection was the one with the car
      message_to_js <- user_selection
      message_to_user <- 'Oooops! You changed your option and you lost!!! :('
      game_stats <- update_stat(game_stats, changed = TRUE, win = FALSE)
    }
    
    # modify the text to show to user
    output$final_result <- renderText({
      message_to_user
    })
    
    show('final_result')
    show('retry')
    output$visual_stat <- renderPlot(
      
      ggplot(game_stats, aes(y = freqs,  fill = results, x = options)) + 
        ggtitle('Real-time Monty Hall game results') +
        ylab('Trials') + 
        geom_bar(position="stack", stat="identity")  + 
        geom_text(aes(label=percentages), position = position_stack(vjust = .5)) + 
        theme(plot.title = element_text(hjust = 0.5))      
    )
    
    # send the message with desirable input to Javascript for flipping the doors and show the final result
    session$sendCustomMessage("open_all_doors", message_to_js)
  })
  
  onclick('not_change_option_btn', {
    options = c(1, 2, 3)
    alt_selection <- which(! options %in% c(user_selection, opened_door))
    print(alt_selection)
    print(scene[user_selection][[1]]$car == 1)
    if (scene[user_selection][[1]]$car == 1) {
      # if the first selectio of the user has the car and she decided not to change it
      message_to_js <- user_selection
      message_to_user <- 'Yaaay! You stayed on your option and you won!!! :)'
      game_stats <- update_stat(game_stats, changed = FALSE, win = TRUE)
    } else {
      # otherwise the user's first selection was the one with the car
      message_to_js <- alt_selection
      message_to_user <- 'Oooops! You stayed on your option and you lost!!! :('
      game_stats <- update_stat(game_stats, changed = FALSE, win = FALSE)
    }
    output$final_result <- renderText({
      message_to_user
    })
    show('final_result')
    show('retry')
    
    output$visual_stat <- renderPlot(
      
      ggplot(game_stats, aes(y = freqs,  fill = results, x = options)) + 
        ggtitle('Real-time Monty Hall game results') +
        ylab('Trials') + 
        geom_bar(position="stack", stat="identity")  + 
        geom_text(aes(label=percentages), position = position_stack(vjust = .5)) + 
        theme(plot.title = element_text(hjust = 0.5))
      
    )
    
    # send the message with desirable input to Javascript for flipping the doors and show the final result
    session$sendCustomMessage("open_all_doors", message_to_js)
  })
  
  onclick('retry', {
    # scene <- set_the_scene()
    hide('not_change_option_btn')
    hide('change_option_btn')
    hide('final_result')
    hide('invisible_text')
    hide('retry')
    session$sendCustomMessage("refresh_scene", 'all_doors')
  })
  
}