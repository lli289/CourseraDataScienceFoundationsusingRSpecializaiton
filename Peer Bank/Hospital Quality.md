# Programming Assignment 3 INSTRUCTIONS: Hospital Quality
* Download Programming Assignment 3 Data, unzip, and set working directory.
* Write function best.
  + This function takes arguments: state and outcome. This function reads the outcome-of-care measures.csv file and returns a character vector with the name of the hospital that has the best (i.e. lowest) 30 day mortality for the specified outcome in that state. If there is a tie, then the hospital names should be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals "b", "c" and "f" are tied for best, then hospital "b" should be returned).
* Write function rankhospital.
  + This function takes arguments: state, outcome, and num = "best". This function reads the outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that has the ranking specified by num argument. If there is a tie, thenties should be broken by using the hospital name. 
* Write function rankall.

## You will use best(), rankhospital(), and rankall() to complete Programming Assignment 3: Quiz

### Function 1: best

### Function 2: rankhospital
