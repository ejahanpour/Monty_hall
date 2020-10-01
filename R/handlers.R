source('R/door_class.R')

#' @title Set the Monty Hall Scene
#' 
#' @description generates a scene with three doors with car behind one door and goats behind the other two
#' @param prize_prob probability that prize lays behind each door
#' 
#' @return vector of Door object including number, prize_prob and whether car is behind it or not
set_the_scene <- function(prize_prob = 1/3) {
  door1 <- Door$new(1, prize_prob)
  door2 <- Door$new(2, prize_prob)
  door3 <- Door$new(3, prize_prob)
  
  door1$close()
  if (door1$car == 0) {
    door2$close()
    if (door2$car == 0) {
      door3$car = 1
    }
  }
  
  return(c(door1, door2, door3))
}


#' @title Open a door with goat behind it
#' 
#' @description this function opens a door not selected by user that has goat behind it
#' 
#' @param scene vector of Door objects including the data whether which one has car behind
#' @param selected_door Door object being selected by user
#' 
#' @return door_to_open Door object including the number that has goat behind it
open_door_with_goat <- function(scene, selected_door) {
  print(paste('door selected:', selected_door$number))
  # all_doors <- c(door1, door2, door3) 
  other_doors <- scene[sapply(scene, FUN = function(x) x$number != selected_door$number)]
  if (selected_door$car == 0) {
    door_to_open = other_doors[sapply(other_doors, FUN = function(x) x$car == 0)][[1]]
  } else {
    door_to_open = sample(other_doors, 1)[[1]]
  }
  # print(paste('door opened:', door_to_open$number))
  return(door_to_open)
}

#' @title Final Score 
#' 
#' @description gets the initially selected door and decision on changing the door and return whether user won
#' 
#' @param selected_door Door object including users initial selection
#' @param change_selection boolean indicating wether user has changed his opinion or not
#' 
final_score <- function(selected_door, change_selection) {
  result = ifelse(selected_door$car == 1, 
                      ifelse(change_selection == FALSE, 'Won', 'Lost'), 
                      ifelse(change_selection == TRUE, 'Won', 'Lost'))
  return(c(change_selection, result))
}

# scene <- set_the_scene()
# print(c(scene[[1]]$car, scene[[2]]$car, scene[[3]]$car))
# selected_door = scene[sample(1:3, 1)][[1]]
# opened_door <- open_door_with_goat(scene = scene, selected_door = selected_door)
# final_score(selected_door = selected_door, change_selection = TRUE)
