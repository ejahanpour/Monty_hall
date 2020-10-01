source('R/handlers.R')
library(ggplot2)

update_stat <- function(current_stat, changed = TRUE, win = TRUE) {
  if (changed & win) {
    current_stat[1, 'freqs'] = current_stat[1, 'freqs'] + 1
  }
  if (changed & !win) {
    current_stat[2, 'freqs'] = current_stat[2, 'freqs'] + 1
  }
  if (!changed & win) {
    current_stat[3, 'freqs'] = current_stat[3, 'freqs'] + 1
  }
  if (!changed & !win) {
    current_stat[4, 'freqs'] = current_stat[4, 'freqs'] + 1
  }
  
  # I do not want to add dependancy only for calculating the grouped percentages, so using hardcoded calculations
  current_stat[1, 'percentages'] = current_stat[1, 'freqs'] / sum(current_stat[1:2, 'freqs'])
  current_stat[2, 'percentages'] = current_stat[2, 'freqs'] / (sum(current_stat[1:2, 'freqs']))
  current_stat[3, 'percentages'] = current_stat[3, 'freqs'] / (sum(current_stat[3:4, 'freqs']))
  current_stat[4, 'percentages'] = current_stat[4, 'freqs'] / (sum(current_stat[3:4, 'freqs']))
  current_stat[is.na(current_stat$percentages), 'percentages'] <- 0
  return(current_stat)
}
