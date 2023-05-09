# Programming Assignment 3 INSTRUCTIONS: Hospital Quality
* Download Programming Assignment 3 Data, unzip, and set working directory.
* Write function best.
  + This function takes arguments: state and outcome. This function reads the outcome-of-care measures.csv file and returns a character vector with the name of the hospital that has the best (i.e. lowest) 30 day mortality for the specified outcome in that state. If there is a tie, then the hospital names should be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals "b", "c" and "f" are tied for best, then hospital "b" should be returned).
* Write function rankhospital.
  + This function takes arguments: state, outcome, and num = "best". This function reads the outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that has the ranking specified by num argument. If there is a tie, thenties should be broken by using the hospital name. 
* Write function rankall.

## You will use best(), rankhospital(), and rankall() to complete Programming Assignment 3: Quiz

#### Function 1: best

```{r}
library(dplyr)
best <- function(state, outcome){
  data <- data.table::fread("outcome-of-care-measures.csv")
  outcome <- tolower(outcome)
  chosen_state <- state 
  if (!chosen_state %in% unique(data[["State"]])) {
    stop("Invalid state")
  }
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("Invalid outcome")
  }
  data <- data %>% 
    rename_with(~ tolower(gsub("^Hospital 30-Day Death \\(Mortality\\) Rates from ", "", .x)))
  data <- data[which(data$state == chosen_state),]
  data <- data%>%
    mutate(rate = suppressWarnings(as.numeric(get(outcome)))) %>%
    clean_names() %>%
    select(hospital_name, state, rate)
  data <- na.omit(data)
  data <- data %>%
    arrange(rate, hospital_name) %>%
    mutate(rank = row_number())  
  return(unlist(data[1,1]))
}
```

#### Function 2: rankhospital

```{r}
rankHospital <- function(state, outcome, num="best") {
  data <- data.table::fread("outcome-of-care-measures.csv")
  outcome <- tolower(outcome)
  chosen_state <- state
  if (!chosen_state %in% unique(data[["State"]])) {
    stop("Invalid state")
  }
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop("Invalid outcome")
  }
  data <- data %>% 
    rename_with(~tolower(gsub("^Hospital 30-Day Death \\(Mortality\\) Rates from ", "", .x)))
  data <- data[which(data$state == chosen_state),]
  data <- data%>%
    mutate(rate = suppressWarnings(as.numeric(get(outcome)))) %>%
    clean_names() %>%
    select(hospital_name, state, rate)
  data <- na.omit(data)
  data <- data %>%
    arrange(rate, hospital_name) %>%
    mutate(rank = row_number())    
  if (num == "best") {
    unlist(head(dt[[1]], 1))
  }
  if (num == "worst") {
    unlist(tail(dt[[1]], 1))
  }
  data <- data %>% 
    slice(num) 
  data <- data %>%
    select(hospital_name)
  return(data$hospital_name)
}
```

#### Function 3: rankall
```{r}
rankall <- function(outcome, num = "best") {
  data <- data.table::fread("outcome-of-care-measures.csv")
  outcome <- tolower(outcome)
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop('invalid outcome')
  }
  data <- data %>% 
    rename_with(~ tolower(gsub("^Hospital 30-Day Death \\(Mortality\\) Rates from ", "", .x)))
  data <- data %>%
    mutate(rate = suppressWarnings(as.numeric(get(outcome)))) %>%
    clean_names() %>%
    select(hospital_name, state, rate)
  data <- na.omit(data)
  data <- data %>% 
    group_by(state)
  data <- data %>%
    arrange(rate, hospital_name, .by_group = T) %>%
    mutate(rank = row_number()) 
  if (num == "best") {
    data <- data %>% 
      filter(rank == 1) 
    data %>%
      select(hospital_name, state)
  }else if (num == "worst") {
    data <- data %>%
      group_by(state) 
    data %>%
      filter(rank == max(rank)) %>%
      select(hospital_name, state)
  }else{ 
    data <- data %>%
      group_by(state) %>%
      filter(rank == num) %>%
      select(hospital_name, state)
  }
}
```
