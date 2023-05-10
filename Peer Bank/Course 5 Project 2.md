# Peer-graded Assignment: Course Project 2 [Course 5]

## For this assignment, you need to do the following:
* Download Storm data, unzip, and setting to working directory.
* Answer "Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect to population health?"
* Answer "Across the United States, which types of events have the greatest economic consequences?"

## To pass the assignment, you need to do the following:
* Check 1: has either a (1) valid RPubs URL pointing to a data analysis document for this assignment been submitted; or (2) a complete PDF file presenting the data analysis.
* Check 2: description and justification for any data transformations?
* Check 3: title that briefly summarizes the data analysis.
* Check 4: describes and summarizes the data analysis in less than 10 sentences.
* Check 5: a section titled "Data Processing" that describes how the data were loaded into R and processed for analysis.
* Check 6: a section titled "Results" where the main results are presented.
* Check 7: at least one figure in the document that contains a plot.
* Check 8: at most 3 figures in this document.
* Check 9: analysis start from the raw data file (i.e. the original .csv.bz2 file).
* Check 10: address the question of which types of events are most harmful to population health.
* Check 11: address the question of which types of events have the greatest economic consequences.
* Check 12: reproducible results.
* Check 13:  figure(s) have descriptive captions.

## R code:
```{r}
require(gridExtra)
library(ggplot2)
library(plyr)
library(dplyr)
if(!exists("storm.data")) {
  storm.data <- read.csv(bzfile("repdata_data_StormData.csv.bz2"),header = TRUE)
}
vars <- c( "EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP")
data <- storm.data[, vars]
sort(table(data$EVTYPE), decreasing = TRUE)[1:10]
sort(table(data$CROPDMGEXP), decreasing = TRUE)[1:10]
data$PROPDMGEXP <- as.character(data$PROPDMGEXP)
data$EVENT<- "OTHER"
data$EVENT[grep("HAIL", data$EVTYPE, ignore.case = TRUE)] <- "HAIL"
data$EVENT[grep("HEAT", data$EVTYPE, ignore.case = TRUE)] <- "HEAT"
data$EVENT[grep("FLOOD", data$EVTYPE, ignore.case = TRUE)] <- "FLOOD"
data$EVENT[grep("WIND", data$EVTYPE, ignore.case = TRUE)] <- "WIND"
data$EVENT[grep("STORM", data$EVTYPE, ignore.case = TRUE)] <- "STORM"
data$EVENT[grep("SNOW", data$EVTYPE, ignore.case = TRUE)] <- "SNOW"
data$EVENT[grep("TORNADO", data$EVTYPE, ignore.case = TRUE)] <- "TORNADO"
data$EVENT[grep("WINTER", data$EVTYPE, ignore.case = TRUE)] <- "WINTER"
data$EVENT[grep("RAIN", data$EVTYPE, ignore.case = TRUE)] <- "RAIN"
data$PROPDMGEXP[is.na(data$PROPDMGEXP)] <- 0 
data$PROPDMGEXP[!grepl("K|M|B", data$PROPDMGEXP, ignore.case = TRUE)] <- 0 
data$PROPDMGEXP[grep("K", data$PROPDMGEXP, ignore.case = TRUE)] <- "3"
data$PROPDMGEXP[grep("M", data$PROPDMGEXP, ignore.case = TRUE)] <- "6"
data$PROPDMGEXP[grep("B", data$PROPDMGEXP, ignore.case = TRUE)] <- "9"
data$PROPDMGEXP <- as.numeric(as.character(data$PROPDMGEXP))
data$property.damage <- data$PROPDMG * 10^data$PROPDMGEXP
data$CROPDMGEXP <- as.character(data$CROPDMGEXP)
data$CROPDMGEXP[is.na(data$CROPDMGEXP)] <- 0 
data$CROPDMGEXP[!grepl("K|M|B", data$CROPDMGEXP, ignore.case = TRUE)] <- 0
data$CROPDMGEXP[grep("K", data$CROPDMGEXP, ignore.case = TRUE)] <- "3"
data$CROPDMGEXP[grep("M", data$CROPDMGEXP, ignore.case = TRUE)] <- "6"
data$CROPDMGEXP[grep("B", data$CROPDMGEXP, ignore.case = TRUE)] <- "9"
data$CROPDMGEXP <- as.numeric(as.character(data$CROPDMGEXP))
data$crop.damage <- data$CROPDMG * 10^data$CROPDMGEXP
A <- ddply(data, .(EVENT), summarize, 
            Total = sum(FATALITIES + INJURIES,  na.rm = TRUE))
A$type <- "fatalities and injuries"
B <- ddply(data, .(EVENT), summarize, 
           Total = sum(FATALITIES, na.rm = TRUE))
B$type <- "fatalities"
C <- ddply(data, .(EVENT), summarize, 
           Total = sum(INJURIES, na.rm = TRUE))
G <- ddply(data, .(EVENT), summarize, 
           Total = sum(property.damage + crop.damage,  na.rm = TRUE))
H <- ddply(data, .(EVENT), summarize, 
           Total = sum(property.damage, na.rm = TRUE))
I <- ddply(data, .(EVENT), summarize, 
           Total = sum(crop.damage, na.rm = TRUE))
C$type <- "injuries"
D <- rbind(B, C)
D$EVENT <- as.factor(D$EVENT)
E <- join(B, C, 
           by="EVENT", type="inner")
G$type <- "property and crop damage"
H$type <- "property"
I$type <- "crop"
temp <- rbind(H, I)
temp2 <- join(H, I, by = "EVENT", type = "inner")
temp2
p1 <- ggplot(D, aes(x = EVENT, y = Total, fill = type)) + geom_bar(stat = "identity") +
  coord_flip() +
  xlab("Event Type") + theme(legend.position="bottom")+
  ylab("Total number of health impact") +
  theme(plot.title = element_text(hjust = 0.5))
p2 <- ggplot(temp, aes(x = EVENT, y = Total, fill = type)) + geom_bar(stat = "identity") +
  coord_flip() +
  xlab("Event Type") + theme(legend.position="bottom")+
  ylab("Total damage in dollars") +
  theme(plot.title = element_text(hjust = 0.5))
grid.arrange(p1, p2, ncol=2)
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/5e76f190-0ece-48a6-b19d-963a87198df0)

