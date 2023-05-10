# Peer-graded Assignment: Course Project 2

## For this assignment, you need to do the following:
* Download and unzip Data for Peer Assessment, set to working directory.
* Address six questions and make plots. For questions, see below.
* Create SEPARATE R code file for each plot.

## To pass the assignment, you need to do the following:
* Check 1: answer and provide plot for question 1 
  + Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
* Check 2: answer and provide plot for quesiton 2
  + Have total emissions from PM2.5 decreased in the  Baltimore City, Maryland (fips == 24510) from 1999 to 2008?
* Check 3: answer and provide plot for quesiton 3
  + Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008?
* Check 4: answer and provide plot for quesiton 4
  + Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
* Check 5: answer and provide plot for question 5
  + How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
* Check 6: answer and provide plot for question 6
  + Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?

## R code:

#### Question 1: Yes, total emissions dfecreased from 1999 to 2008
```{r}
A <- readRDS("summarySCC_PM25.rds")
B <- aggregate(Emissions ~ year,A, sum)
barplot((B$Emissions)/10^6,
  names.arg=B$year,
  xlab="Year", 
  ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/528bf7c3-c111-43aa-be20-6efd693ee6a1)


#### Question 2: Yes, overall, total emissions decreeased in Baltimore city from 1999 to 2008.
```{r}
C <- A[A$fips=="24510",]
D <- aggregate(Emissions ~ year, C, sum)
barplot(D$Emissions, names.arg=D$year,
  xlab="Year", 
  ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/e1296c10-1586-497b-8fe4-cd3745cb448a)

#### Question 3: nonroad, nonpoint, and onroad decrease; point increase.
```{r}
E <- C %>% select (year, type, Emissions) %>% 
  group_by(year, type) 
ggplot(E, aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") +
  labs(x="year", 
       y=expression("Total" ~ PM[2.5] ~ "Emissions (tons)")) 
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/4fc31b83-6fa0-4b6b-bfb7-0a9d7ffe8714)

#### Question 4: we see a decrease.
```{r}
A <- readRDS("summarySCC_PM25.rds")
G <- readRDS("Source_Classification_Code.rds")
H <- A[A$SCC %in% G[(grepl("comb", G$SCC.Level.One, 
      ignore.case=TRUE) & grepl("coal", G$SCC.Level.Four, 
                                ignore.case=TRUE) ),]$SCC,]
ggplot(H,aes(factor(year),Emissions/10^5)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() + guides(fill=FALSE) +
  labs(x="year", 
       y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) 
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/63189335-250a-464b-9a85-75b1df3c2ac4)

#### Question 5: we see a decrease.
```{r}
vehiclesA <- A[A$SCC %in% 
                 G[grepl("vehicle", 
                         G$SCC.Level.Two, 
                         ignore.case=TRUE),]$SCC,]
temp <- vehiclesA[vehiclesA$fips==24510,]
ggplot(temp, aes(factor(year),Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  guides(fill=FALSE) +
  labs(x="year", 
       y=expression("Total PM"[2.5]*" Emission (10^5 Tons)"))
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/b0b71b42-bdf2-44af-a553-be931fcd055c)

#### Question 6: LA
```{r}
vehiclesBaltimoreA <- vehiclesA[vehiclesA$fips == 24510,]
vehiclesBaltimoreA$city <- "Baltimore"
vehiclesLANEI <- vehiclesA[vehiclesA$fips=="06037",]
vehiclesLANEI$city <- "Los Angeles"
temp2 <- rbind(vehiclesBaltimoreA,vehiclesLANEI)
ggplot(temp2, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid( .~city) +
  guides(fill=FALSE) + 
  labs(x="year", 
       y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) 
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/0c14adc5-744f-4927-a52b-b8b5a37371b0)
