# Programming Assignment 1 INSTRUCTIONS: Air Pollution

## For this assignment, you need to do the following:
* Download specdata.zip, unzip, create directory "specdata".
* Write function pollutantmean.
* Write function complete.
* Write function corr.

### You will use pollutantmean(), complete(), and corr() to complete Programming Assignment 1: Quiz:

#### Function 1: pollutantmean

```{r}
pollutantmean <- function(directory, pollutant, id = 1:332) {
    means <- c()
    for(monitor in id){
        path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
        monitor_data <- read.csv(path)
        interested_data <- monitor_data[pollutant]
        means <- c(means, interested_data[!is.na(interested_data)])
    }
    mean(means)
}
```

#### Function 2: complete

```{r}
complete <- function(directory, id = 1:332){
  results <- data.frame(id=numeric(0), nobs=numeric(0))
  for(monitor in id){
    path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
    monitor_data <- read.csv(path)
    interested_data <- monitor_data[(!is.na(monitor_data$sulfate)), ]
    interested_data <- interested_data[(!is.na(interested_data$nitrate)), ]
    nobs <- nrow(interested_data)
    results <- rbind(results, data.frame(id=monitor, nobs=nobs))
  }
  results
}
```

#### Function 3: corr()

```{r}
corr <- function(directory, threshold = 0){
  cor_results <- numeric(0)
  complete_cases <- complete(directory)
  complete_cases <- complete_cases[complete_cases$nobs>=threshold, ]
  if(nrow(complete_cases)>0){
    for(monitor in complete_cases$id){
      path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
      monitor_data <- read.csv(path)
      interested_data <- monitor_data[(!is.na(monitor_data$sulfate)), ]
      interested_data <- interested_data[(!is.na(interested_data$nitrate)), ]
      sulfate_data <- interested_data["sulfate"]
      nitrate_data <- interested_data["nitrate"]
      cor_results <- c(cor_results, cor(sulfate_data, nitrate_data))
    }
  }
  cor_results
}
```
