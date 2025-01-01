# Problem
# In pitstop.R, write a program that prompts the user to enter a CSV file to analyze.
# Your program should then print the following information:

#     The total number of pit stops
#     The duration of the shortest pit stop
#     The duration of the longest pit stop
#     The total time spent on pit stops during the race, across all racers

# You may assume the user will not enter an invalid filename. All CSV files will have the same column names.


# ---- Clean Environment ----
rm(list = ls())

# ---- Load Packages ----

box::use(
  glue[glue],
  here[here],
  purrr[map_vec],
  readr[read_csv],
  tools,
)

# ---- Create Functions ----

analyze_csv  <- function(file) {
  file  <- here("week_1", "data", "bahrain.csv") # for testing
  ds    <- read_csv(file)
  race  <- basename(file) |> sub(".csv$", "", x = _)  |> tools$toTitleCase()
  total_stops <- nrow(ds)
  short_stop  <- min(ds$time)
  long_stop   <- max(ds$time)
  total_time  <- sum(ds$time)
  results  <- glue("
    Race: {race}
    Total Pit Stops: {total_stops}
    Shortest Pit Stop: {short_stop}
    Longest Pit Stop: {long_stop}
    Total Time in Pits: {total_time}
  ")
  return(results)
}

create_menu_choices  <- function() {
  files  <- list.files(here("week_1", "data"))
  names  <- map_vec(files, \(x) {
    sub(".csv$", "", x)  |> tools$toTitleCase() 
  })
  return(names)
}

while (TRUE) {
  choices  <- create_menu_choices()
  selection  <- menu(choices, "Choose Race to Analyze")
  if (selection == 0) {
    break
  }
  
}
