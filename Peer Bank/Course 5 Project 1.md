# Peer-graded Assignment: Course Project 1 [Course 5]

## For this assignment, you need to do the following:
* Download Activity monitoring data, unzip, and set to working directory.
* Fork/clone repo [RepData_PeerAssessment1](https://github.com/rdpeng/RepData_PeerAssessment1).
* Process/transform the data (if necessary). 
* Answer "What is mean total number of steps taken per day?", make a histogram of the total number of steps taken each day, and calculate mean and median of the total number of steps taken per day.
* Answer "What is the average daily activity pattern?", make a time series plot (type = "l") of the 5 minite interval (x-axis) and the average number of steps taken, averaged across all days (y-axis).
* Answer "Which 5 minite interval, on average across all  the days in the dataset, contains the maximum number of steps?"
* Imputing missings:
  + Calculate total number of missing values in the data.
  + Devise a strategy for filling in all of the missing values in the data. e.g. use mean/median for that day.
  + Create a new dataset that is equal to the original dataset but with the missing data filled in.
  + Make a historgram of the total number of steps taken each day and calculate and report the mean and median total number of steps taken per day. 
  + Answer "Do these values differ from the estimates from the first part of the assignment?"
  + Answer "What is the impact of imputing missing data on the estimates of the total daily number of steps?"
 * Answer "Are there differences in activity patterns between weekdays and weekends?"
  + Create a new factor variable in the data with two levels weekday and weekend indicating whether a gven date is a weekday or weekend day.
  + Make a panel plot containing a time series plot (type = "l") of the 5 minute interval (x-axis) and the average number of stps taken, averaged across all weekdays or weekend days (y-axis).

## To pass the assignment, you need to do the following:
* Copy and paste the link to your completed repo and make sure it contains:
  + PA1_template.Rmd
  + PA1_template.html 
* Submit SHA-1.

## R code:

```{r}
activity <- read.csv("activity.csv")
activity$date <- as.Date(activity$date)
A <- activity %>%
  group_by(date) 
B <- A %>%
  summarize(totalsteps = sum(steps, na.rm = TRUE))
hist(B$totalsteps, 
     col="red", xlab="Steps", ylim = c(0,30))
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/a79009d7-d197-4149-9948-b3bece35c8a1)

#### Mean and median

```{r}
stepsByDay <- tapply(activity$steps, activity$date, sum, na.rm=TRUE)
mean(stepsByDay)
median(stepsByDay)
```

The mean is 9354 and the median is 10395.

#### Average daily activity pattern? 

Based on the plot below, we see an increase then decrease.

#### time series plot

```{r}
c<- aggregate(x=list(meanSteps=activity$steps), by=list(interval=activity$interval), FUN=mean, na.rm=TRUE)
ggplot(c, aes(x=interval, y=meanSteps)) +
    geom_line() +
    xlab("5-minute interval") +
    ylab("average number of steps taken") 
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/cd7c6aa1-0ecd-4ca1-b200-205df50a703f)
#### which 5 min interval, on average across all the days in the dataset, contains the maximum number of steps?

```{r}
gsub("([0-9]{1,2})([0-9]{2})", "\\1:\\2",c[which.max(c$meanSteps),'interval'])
```

It's at 8:35.

#### Imputing missing values

```{r}
sum(is.na(activity$steps))
```

There are 2304 number of missing values.

```{r}
NoNA <- activity  
for (i in 1:dim(activity)[1]){
  if(is.na(activity$steps[i])){
  NoNA$steps[i]<- c$meanSteps[NoNA$interval[i] == c$interval]
        }
}
NoNAtemp<- tapply(NoNA$steps, NoNA$date, sum)
hist(NoNAtemp, col = "red", xlab='steps')
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/3ea52e24-576b-4638-8bda-4cd548dddeda)


```r
mean(NoNAtemp)
median(NoNAtemp)
```

Mean is 10766.19 and median is 10766.19.

#### Are there differences in activity patterns between weekdays and weekends?

```r
NoNA$Type <-  ifelse(as.POSIXlt(NoNA$date)$wday %in% c(0,6), 'weekend', 'weekday')
NoNAtemp2 <- aggregate(steps ~ interval + Type, data=NoNA, mean)
ggplot(NoNAtemp2, aes(interval, steps)) + 
    geom_line() + 
    facet_grid(Type ~ .) +
    xlab("5-minute interval") + 
    ylab("avarage number of steps")
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/2db4dc51-e5bd-430c-9847-1d66a70328cd)

