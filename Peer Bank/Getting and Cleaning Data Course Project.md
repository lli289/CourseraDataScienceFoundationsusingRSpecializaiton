# Peer-graded Assignment: Getting and Cleaning Data Course Project

## For this assignment, you need to do the following:
* create and save a R script called run_analysis.R.
* Extract only the measurements on the mean and standard deviaiton for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data with descriptive variable names, then creates a second, independent tidy data set with the average of each variable for each activity and each subject. Call this data set tidy.
* Copy and paste the link to your repo.
* In your repo, make sure it contains tidy data set, CodeBook.md (this file contains a code book tht modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information), and README.md (this file explains the analysis files).

## To pass the assignment, you need to do the following:
* Check 1: upload correct tidy data set.
* Check 2: copy and paste the link to your completed R code or repo that contains:
  + run_analysis.R
  + original data (optional)
  + tidy
  + README.md
  + CodeBook.md

## R code:

#### run_analysis.R
```{r}
s.train <- read.table("subject_train.txt", header = FALSE)
y.train <- read.table("y_train.txt", header = FALSE)
x.train <- read.table("X_train.txt", header = FALSE)
s.test <- read.table("subject_test.txt", header = FALSE)
y.test <- read.table("y_test.txt", header = FALSE)
x.test <- read.table("X_test.txt", header = FALSE)
temp <- read.table("features.txt")
temp2 <- read.table("activity_labels.txt", header = FALSE)
A <- rbind(s.train, s.test)
B <- rbind(y.train, y.test)
C <- rbind(x.train, x.test)
colnames(A) <- "Subject"
colnames(B) <- "Activity"
colnames(C) <- t(temp[2])
D <- cbind(C,B,A)
MeanSTD <- grep(".*Mean.*|.*Std.*", names(D), ignore.case=TRUE)
temp3 <- D[,c(MeanSTD, 562, 563)]
temp3$Activity <- as.character(temp3$Activity)
for (i in 1:6){
  temp3$Activity[temp3$Activity == i] <- as.character(temp2[i,2])
}
temp3$Activity <- as.factor(temp3$Activity)
names(temp3)<-gsub("Acc", "Accelerometer", names(temp3))
names(temp3)<-gsub("Gyro", "Gyroscope", names(temp3))
names(temp3)<-gsub("BodyBody", "Body", names(temp3))
names(temp3)<-gsub("Mag", "Magnitude", names(temp3))
names(temp3)<-gsub("^t", "Time", names(temp3))
names(temp3)<-gsub("^f", "Frequency", names(temp3))
names(temp3)<-gsub("tBody", "TimeBody", names(temp3))
names(temp3)<-gsub("-mean()", "Mean", names(temp3), ignore.case = TRUE)
names(temp3)<-gsub("-std()", "STD", names(temp3), ignore.case = TRUE)
names(temp3)<-gsub("-freq()", "Frequency", names(temp3), ignore.case = TRUE)
names(temp3)<-gsub("angle", "Angle", names(temp3))
names(temp3)<-gsub("gravity", "Gravity", names(temp3))
temp3$Subject <- as.factor(temp3$Subject)
tidy <- aggregate(. ~Subject + Activity, temp3, mean)
tidy <- tidy[order(tidy$Subject,tidy$Activity),]
write.table(tidy, "tidy.txt", row.name=FALSE)
```
