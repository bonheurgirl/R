######Useful and common tasks & functions in R #######

#######Load Libraries###########n##
library(tidyverse)
library(dplyr)
library(sqldf)
library(data.table)
library(ggpubr)
library(openintro)

if(!require(c(tidyverse, sqldf, data.table, ggpubr,
  openintro))) install.packages(c("tidyverse", "sqldf", "data.table", "ggpubr", "openintro"),repos = "http://cran.us.r-project.org")


if(!require(weatherData)) install.packages("weatherData",repos = "http://cran.us.r-project.org")

#check which packages were installed/loaded - saved as data frame
pack <- as.data.frame(installed.packages())

#to see all currently loaded packages
search()

par("mar")
par(mar=c(1,1,1,1))

###########Resources###########
#Data visualizations
#browseURL("http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html#Ordered%20Bar%20Chart")

###########Rename columns############

#call data
data("iris")

#check column names
names(iris)

#rename columns using rename but must save results to the dataframe
#keeps all columns
iris <- rename(iris, sepal_len = Sepal.Length)

#check results
names(iris)

############Create dot plots####################

#call data
data("mtcars")

#check results
glimpse(mtcars)

#create dotplot
ggplot(data = mtcars, aes(x = wt)) +
  geom_dotplot()

###########Create categorical data#########################


#browseURL("http://www.sthda.com/english/wiki/ggplot2-barplots-quick-start-guide-r-software-and-data-visualization")

#generate data 
ad_type <- c("Poster", "Billboard", "Bus", "Subway")
num_ads<- c(sample(250:1000, 4, replace = FALSE)) #generate 4 random numbers for our data set

#create data frame
ads <- data.frame(ad_type, num_ads, stringsAsFactors = FALSE)

# calculate percentages of each category
ads <- ads %>%
  mutate(pct = num_ads/sum(num_ads) * 100) %>% 
  arrange(desc(pct))

#check results
ads

###########Create bar chart - order bars - add data values#############
#plot as bar chart
ggplot(data = ads, aes(x = reorder(ad_type, -num_ads), y = num_ads)) +
  geom_bar(stat = "identity", fill = "steelblue") +
   ggtitle("Number of ads by channel")+
  xlab(" ") +
  ylab("total ads") +
  geom_text(aes(label = num_ads), vjust = 1.6,
    color = "white", size = 3.5) + theme_minimal()



#plot as bar chart but with percentages
ggplot(data = ads, aes(x = reorder(ad_type, -num_ads), y = num_ads)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  ggtitle("Distribution of ads by channel") +
  labs(caption="Based on data from Google Analytics \n Time frame: Jan 2018 - Feb 2018") +
  xlab(" ") +
  ylab("total ads") +
  geom_text(aes(label = paste(round(pct,2), "%", sep = ""), family = "Arial",
  fontface = "bold", size = 14), vjust = 1.6,
  color = "white", size = 3.5) + theme_minimal()

##################ggpubr Bar plots#########################

#to look at the different color palettes
#browseURL("https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html")

library(RColorBrewer) #load library
display.brewer.pal(4, "Blues") #display a color palette
display.brewer.all()
#brewer.pal #does list all the color palettes (i.e. sequential
#, diverging, etc...)

bluesPal <- brewer.pal(3, "Blues")
outlier <- "red"
myOrange <- rgb(225,151,76, max = 255)

#ordered bar plots - need to arrange column in desc order b4 plotting
ggbarplot(ads, x = "ad_type", y = "num_ads",
          fill = "ad_type",               # change fill color by cyl
          color = "white",            # Set bar border colors to white
          palette = c(myOrange, bluesPal),
          sort.val = "desc",          # Sort the value in dscending order
          sort.by.groups = FALSE,     # Don't sort inside each group
          x.text.angle = 0,          # Rotate vertically x axis texts
          legend = "none",
          xlab = " Ad type",
          ylab = " Total ads",
          label = paste(round(ads$pct,2),"%", sep = ""),
          label.pos = "out",
          title = "Ad type breakdown")


#################Create continuous data############

#generate data 
qualityScore <- as.numeric(c(0:10))
keywords<- c(sample(1:200, 11, replace = FALSE)) #generate 10 random numbers for our data set

#create data frame
df <- data.frame(qualityScore, keywords, stringsAsFactors = TRUE)
df


# calculate percentages of each category
df <- df %>%
  mutate(pct = keywords/sum(keywords) * 100) %>% 
  arrange(qualityScore) 

#check results
df

#brewer.pal.info #check color palletes
myPalette <- brewer.pal(11, "RdYlGn")


#ordered bar plots - need to arrange column in desc order b4 plotting
ggbarplot(df, x = "qualityScore", y = "keywords",
          fill = "qualityScore",               # change fill color
          color = "white",            # Set bar border colors to white
          palette = myPalette,            #  color palette.
          sort.val = NULL,          # Sort the value in dscending order
          sort.by.groups = FALSE,     # Don't sort inside each group
          x.text.angle = 0,          # Rotate vertically x axis texts
          legend = "none",
          xlab = " Quality Scores",
          ylab = " Total Keywords",
          label = paste(round(df$pct,2),"%", sep = ""),
          label.pos = "out",
          title = "Breakdown of spending by quality score")


########Quick Dplyr Operations - Summarize & group by functions###############
#install and load data package
install.packages("dslabs")
library(dslabs)
data(heights)


#filter and summarizing by groups
s <- heights %>%
  filter(sex =="Male") %>%
  summarize(average = mean(height), standard_dev = sd(height))


#make dplyr functions return vectors as opposed to data
#frames
data(murders)

murders <- murders %>%
  mutate(murder_rate = total/population * 100000)
  summarize(murders, mean(murder_rate))
  
us_murder_rate <- murders %>%
    summarize(rate = sum(total)/sum(population)*100000)
  
  
#group by functions (split data into groups and compute summaries)
  heights %>% group_by(sex)
  
  heights %>%
    group_by(sex) %>%
    summarize(average = mean(height),
      standard_dev = sd(height))

########Dplyr row filters#####################    
#Let's explore the NHANES data. We will be exploring blood pressure
#in this dataset.
    
library(NHANES)
data(NHANES)
head(NHANES)

names(NHANES)

#check number of unique ages 
unique(NHANES$Age)

#Filter the NHANES dataset so that only 20-29 year old females are included
tab <- NHANES %>%
  filter(Gender == "female")%>%
  filter(between(Age, 20, 29))

#or
tab2 <- NHANES %>%
  filter(Gender == "female" & AgeDecade == " 20-29")
  
#save the average and standard deviation of
#systolic blood pressure as average and
#standard_deviation to a variable called ref
ref <- NHANES %>% 
  filter(AgeDecade == " 20-29" & Gender == "female") %>%
  summarize(average = mean(BPSysAve, na.rm = TRUE),
      standard_deviation = sd(BPSysAve, na.rm = TRUE))

#how many females are married
NHANES %>% 
  filter(Gender == "female" & MaritalStatus == "Married") %>% 
  summarise(marr_women = n())
  
#create pivot table of marital status of women
NHANES %>% 
  group_by(MaritalStatus) %>% 
  filter(Gender == "female") %>% 
  summarise(num_women = n())

#pivot table with 2 variables  
NHANES %>% 
  group_by(MaritalStatus, Race1) %>% 
  filter(Gender == "female") %>% 
  summarise(num_women = n()) 

#Use spread from long to wide
#creating a contingency/cross tabs data
NHANES %>% 
  group_by(MaritalStatus, Race1) %>% 
  filter(Gender == "female") %>% 
  summarise(num_women = n()) %>% 
  spread(Race1, num_women) %>% 
  kable()

#cross tabs-the entire dataset
tab <- table(NHANES$MaritalStatus, NHANES$Race1)

#for column frequences
margin.table(tab,2)

#cross tab again
table(NHANES$Marijuana, NHANES$Race1)

#filter out those NA rows
filter(weather, month != "NA")

############# Selecting columns in dplyr ##########################

#looking for columns that contain a letter or string
select(mtcars, contains("c"))

select(mtcars, starts_with("m"))

select(mtcars, ends_with("t"))

#select columns based on data type
select_if(mtcars,is.numeric)

select_if(mtcars,is.character)


#############Grouping and summarizing data dplyr vs. sql #################
tab3 <- NHANES %>%
  group_by(SurveyYr) %>%
  filter(Age < 45) %>%
  summarize (average = mean(Height, na.rm = TRUE),
  maxH = max(Height, na.rm = TRUE))

#same as above in SQL language
tab4 <- sqldf('SELECT SurveyYr, AVG(Height) AS
            avg_height, MAX(Height) as max_height
            FROM NHANES
            WHERE AGE < 45
            GROUP BY SurveyYr')


################Distinct function################

#check number of unique ages using base R
#this creates a list
unique(NHANES$Age)

#the dplyr way
summarise(NHANES, result = n_distinct(Age))

summarise(NHANES, result = n_distinct(Gender))



#########Aggregate function in R############
# aggregate() basically takes a
# numeric variable as a function of a categorical
# variable and will produce a certain descriptive statistic for every
# single group. The way you enter the first
# argument is just the variable name, “Days”, and then the tilde again,
# and then the categorical variable. We actually give it the data frame name in the second argument.
# So this is going to tell the function, "go
# into the film data frame, find the variable, “Days”, and show it as a
# function of “Genre”." And then the final
# argument is the actual function we want to run on this variable. So
# let’s say, we want to look at the means.

#import data
film<-fread("https://d37djvu3ytnwxt.cloudfront.net/assets/courseware/v1/d1c5e00eb9597e12480cd507b93cbb26/asset-v1:UTAustinX+UT.7.21x+2T2017+type@asset+block/FilmData.csv")

aggregate(Days ~ Genre, film, mean) #Compute Summary Statistics of Data Subsets
# we can see that the animated movies spent the longest average of days in the theater, while
# the comedies spent the least number of days.

#Example
## Formulas, one ~ one, one ~ many, many ~ one, and many ~ many:
aggregate(weight ~ feed, data = chickwts, mean)
## Dot notation:
aggregate(. ~ Species, data = iris, mean) #calculates the mean of all columns grouped by species

# And what our ANOVA is going to tell us is, are these means significantly different from each other or not. So
# one way we can actually use aggregate to test the assumption of ANOVA, which is the groups have equal
# variances, we can actually ask for, instead of the mean, the standard deviation. So by changing that third
# argument, we’re going to get, instead of the mean days, the standard deviation for each group.
aggregate(Days ~ Genre, film, sd)

##############ANOVA##########################
# If we wanted to test the hypothesis, the mean number of days spent in
# theaters is equal across all four genres,
# we could run a one-way ANOVA on the data above.

#visualize means
film %>%
  ggplot(aes(x = Genre, y = Days)) +
  geom_boxplot() + coord_flip() + ggtitle("Days in Theaters")

#create model
daysmodel <- aov(film$Days ~ film$Genre)

summary(daysmodel)

p_value <-
  
  daysmodel$"Pr(>F)"[1]

p_value<-0.504
p_value <= .05 #reject null hypothesis if true
p_value > .05 #fail to reject null hypothesis if true

# So we can see here with a p-value greater
# than 0.05, we would fail to reject the null hypothesis that the mean
# of all four groups are equal to each other.
# So if it were the case that we had a significant p-value for this ANOVA, we would follow up this analysis
# with a post hoc analysis, where we find which means are different from each other.
# So just to illustrate that process, I want to show you one more function, which will run the Tukey pairwise
# comparisons for every single group in your model. All you have to do is give the object name, daysmodel,
# into this function, called TukeyHSD().

TukeyHSD(daysmodel)
plot(TukeyHSD(daysmodel)) #plot the differences visually

# And what it will output for you are every single pairwise comparison, the difference and the means, a lower
# and upper confidence interval for that difference, and then the p-value that is adjusted based on the Tukey
# adjustment. We can see that none of these pairwise comparisons are significant, which makes sense because
# our overall ANOVA wasn’t significant. But if you did have a significant ANOVA, you would go into this
# table and see where those differences actually occur.


########Finding unique values###############
#check values of unique ages 
unique(NHANES$Age)

########Ordering & arranging################

#Order rows by values of a column (low to high).
arrange(NHANES, Age)

#Order rows by values of a column (high to low)
arrange(NHANES, desc(Age))

###############Counting, Summarizing, Grouping, Mutating#######################

#Count number of rows with each unique value of variable (with or without weights).
count(iris, Species, wt = Sepal.Length)

#counts the rows
tally(iris, sort = FALSE)

data(mlbBat10)
head(mlbBat10)

#grouping and counting using tally
mlbBat10 %>%
  group_by(team) %>%
  tally() %>%  #you can only count or sum variables with tally
  View()
 
#summarize is much more powerful-does the same as above
mlbBat10 %>%
  group_by(team) %>%
  summarise(num_players = n()) %>% 
  arrange(desc(num_players)) %>% 
  View()

#keeping the top 5 rows only and adding percentage
topTeams<-mlbBat10 %>%
            group_by(team) %>%
            summarise(num_players = n()) %>% 
            arrange(desc(num_players)) %>% 
            top_n(5) %>% 
            mutate(perc_total = round(num_players/sum(num_players) * 100))

#check results
topTeams

#basic bar chart
ggplot(data=topTeams, aes(x=reorder(team, -perc_total), y=perc_total)) +
  geom_bar(stat="identity", fill="steelblue") +
  geom_text(aes(label=paste(perc_total, "%", sep = "")), vjust=-0.3, size=4.5) +
  theme_minimal()

myBlue <- rgb(114,147,203, max = 255)

#using ggpubr - you have to make sure data frame is sorted
#Sort bars inside each group.
ggbarplot(topTeams, x = "team", y = "perc_total",
          fill = myBlue,               # change fill color by cyl
          color = myBlue,            # Set bar border colors to whatever            # jco journal color palett. see ?ggpar
          sort.val = "desc",           # Sort the value in dscending order
          x.text.angle = 0 ,          # Rotate vertically x axis texts
          label =  paste(topTeams$perc_total,"%", sep = ""),
          label.pos = "out",
          ylab = FALSE,
          xlab = FALSE,
          title = "Distribution",
          legend = "none"
          )


#remove all categorical variables - keep top 10 rows only
films <- film %>% 
      select(Film, Rank, Gross, Gross.Dom, Rotten, IMDB, Days, Budget) %>% 
      top_n(10, Gross)

aggregate(. ~ Film, data = films, mean) #calculates the mean of all columns grouped by film


#summarize if - summarizing all the columns
mlbBat10 %>%
  group_by(team) %>%
  summarise_if(is.numeric, mean) %>% 
  View()


#################Count groups and sub groups############

df <- data.frame(month=c("Feb-14", "Feb-14", "Feb-14", "Mar-14", "Mar-14", "Mar-14", "Apr-14", "Apr-14", "Apr-14", "May-14"),
                 type=c("bbb", "ccc", "aaa", "bbb", "ccc", "aaa", "bbb", "ccc", "aaa", "bbb"),
                 count=c(341, 527, 2674, 811, 1045, 4417, 1178, 1192, 4793, 916))

View(df)

df %>% group_by(month) %>% 
  mutate(per=paste0(round(count/sum(count)*100, 2), "%")) %>% 
  ungroup

#n() function tells you how many items are in the group
#you are currently looking at

#if you want to see how many groups there are in the dataset
#in this data the groups are the months - 4 months worth
#of data therefore 4 groups
df %>% group_by(month) %>% 
  mutate(per=paste0(round(count/sum(count)*100, 2), "%")) %>% 
  n_groups()

###############Cumulative sums and more: cumsum, cumall, and cumany#################

#calculate cumulative values
#extract rows before/after a value


###############ggpubr table#################
# Access and modify the font and
# the background of table cells
# :::::::::::::::::::::::::::::::::::::::::::::
tab <- ggtexttable(head(iris), rows = NULL,
                  theme = ttheme("classic"))

tab <- table_cell_font(tab, row = 3, column = 2,
                      face = "bold")

tab <- table_cell_bg(tab, row = 4, column = 3, linewidth = 5,
                    fill="darkolivegreen1", color = "darkolivegreen4")

tab

########ggpubr boxplot#############

# Load data
data("ToothGrowth")
df <- ToothGrowth
head(df, 4)

 p <- ggboxplot(df, x = "dose", y = "len",
                color = "dose", palette =c("#00AFBB", "#E7B800", "#FC4E07"),
                add = "jitter", shape = "dose")
 p
 
 # Add p-values comparing groups
 # Specify the comparisons you want
my_comparisons <- list( c("0.5", "1"), c("1", "2"), c("0.5", "2") )
p + stat_compare_means(comparisons = my_comparisons)+ # Add pairwise comparisons p-value
  stat_compare_means(label.y = 50)                   # Add global p-value


#######ggpubr graphs#############
# Load data
data("mtcars")
dfm <- mtcars
# Convert the cyl variable to a factor
dfm$cyl <- as.factor(dfm$cyl)
# Add the name colums
dfm$name <- rownames(dfm)
# Inspect the data
head(dfm[, c("name", "wt", "mpg", "cyl")])

#ordered bar plots
ggbarplot(dfm, x = "name", y = "mpg",
          fill = "cyl",               # change fill color by cyl
          color = "white",            # Set bar border colors to white
          palette = "jco",            # jco journal color palett. see ?ggpar
          sort.val = "desc",          # Sort the value in dscending order
          sort.by.groups = FALSE,     # Don't sort inside each group
          x.text.angle = 90           # Rotate vertically x axis texts
          )

#Sort bars inside each group. Use the argument sort.by.groups = TRUE.
ggbarplot(dfm, x = "name", y = "mpg",
          fill = "cyl",               # change fill color by cyl
          color = "white",            # Set bar border colors to white
          palette = "jco",            # jco journal color palett. see ?ggpar
          sort.val = "asc",           # Sort the value in dscending order
          sort.by.groups = TRUE,      # Sort inside each group
          x.text.angle = 90           # Rotate vertically x axis texts
          )

# Calculate the z-score of the mpg data
dfm$mpg_z <- (dfm$mpg -mean(dfm$mpg))/sd(dfm$mpg)
dfm$mpg_grp <- factor(ifelse(dfm$mpg_z < 0, "low", "high"), 
                     levels = c("low", "high"))
# Inspect the data
head(dfm[, c("name", "wt", "mpg", "mpg_z", "mpg_grp", "cyl")])

#Create an ordered barplot, colored according to the level of mpg:
ggbarplot(dfm, x = "name", y = "mpg_z",
          fill = "mpg_grp",           # change fill color by mpg_level
          color = "white",            # Set bar border colors to white
          palette = "jco",            # jco journal color palett. see ?ggpar
          sort.val = "asc",           # Sort the value in ascending order
          sort.by.groups = FALSE,     # Don't sort inside each group
          x.text.angle = 90,          # Rotate vertically x axis texts
          ylab = "MPG z-score",
          xlab = FALSE,
          legend.title = "MPG Group"
          )

#rotate the plot
ggbarplot(dfm, x = "name", y = "mpg_z",
          fill = "mpg_grp",           # change fill color by mpg_level
          color = "white",            # Set bar border colors to white
          palette = "jco",            # jco journal color palett. see ?ggpar
          sort.val = "desc",          # Sort the value in descending order
          sort.by.groups = FALSE,     # Don't sort inside each group
          x.text.angle = 90,          # Rotate vertically x axis texts
          ylab = "MPG z-score",
          legend.title = "MPG Group",
          rotate = TRUE,
          ggtheme = theme_minimal()
          )

#Lollipop chart is an alternative to bar plots, when you have a large set of values to visualize.
#Lollipop chart colored by the grouping variable “cyl”:
ggdotchart(dfm, x = "name", y = "mpg",
           color = "cyl",                                # Color by groups
           palette = c("#00AFBB", "#E7B800", "#FC4E07"), # Custom color palette
           sorting = "ascending",                        # Sort value in descending order
           add = "segments",                             # Add segments from y = 0 to dots
           ggtheme = theme_pubr()                        # ggplot2 theme
           )

ggdotchart(dfm, x = "name", y = "mpg",
           color = "cyl",                                # Color by groups
           palette = c("#00AFBB", "#E7B800", "#FC4E07"), # Custom color palette
           sorting = "descending",                       # Sort value in descending order
           add = "segments",                             # Add segments from y = 0 to dots
           rotate = TRUE,                                # Rotate vertically
           group = "cyl",                                # Order by groups
           dot.size = 6,                                 # Large dot size
           label = round(dfm$mpg),                        # Add mpg values as dot labels
           font.label = list(color = "white", size = 9, 
                             vjust = 0.5),               # Adjust label parameters
           ggtheme = theme_pubr()                        # ggplot2 theme
           )

###################Stacked Bar Chart - Grouped Variables###############################
df2 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
                  dose=rep(c("D0.5", "D1", "D2"),2),
                  len=c(6.8, 15, 33, 4.2, 10, 29.5))
print(df2)

# Stacked bar plots, add labels inside bars
ggbarplot(df2, x = "dose", y = "len",
  fill = "supp", color = "supp", 
  palette = c("orange", "blue"),
  label = TRUE, lab.col = "white", lab.pos = "in")

myBlue <- rgb(114,147,203, max = 255)
myOrange <- rgb(225,151,76, max = 255)
myGreen <- rgb(132,186,91, max = 255)

# Change position: Interleaved (dodged) bar plot
ggbarplot(df2, x = "dose", y = "len",
          fill = "supp", color = "supp", 
          palette = c(myOrange, myBlue),
          position = position_dodge(0.9),
          xlab = " Type",
          ylab = " Total ads",
          label =  TRUE, #paste(round(df2$len,2),"", sep = ""),
          label.pos = "out",
          title = "Expected")


# Plot "len" by "dose" and change color by a second group: "supp"
# Add labels inside bars
ggbarplot(df2, "dose", "len",
  fill = "supp", color = "supp", palette = "Paired",
  label = TRUE, paste(df2$len,"%", sep = ""),
  lab.col = "white", lab.pos = "in")




df3 <- data.frame(supp=rep(c("VC", "OJ", "DJ"), each=3),
                  dose=rep(c("D0.5", "D1", "D2"),3),
                  len=c(9, 90, 1, 75, 13, 12, 33.3, 33.3, 33.3))
print(df3)


# Change position: Stacked bar plot
ggbarplot(df3, x = "dose", y = "len",
          fill = "supp", color = "supp", 
          palette = c(myOrange, myBlue, myGreen),
          position = position_stack(),
          xlab = " Type",
          ylab = " Total ads",
          label =  FALSE,# paste(round(df2$len,2),"", sep = ""),
          label.pos = "in",
          title = "Stacked Bar Plot")
###################ggpubr Line Chart###############################
# Data
df <- data.frame(dose=c("D0.5", "D1", "D2"),
len=c(4.2, 10, 29.5))
print(df)


# Basic plot
# +++++++++++++++++++++++++++
ggline(df, x = "dose", y = "len")

# Plot with multiple groups
# +++++++++++++++++++++
# Create some data
df2 <- data.frame(supp=rep(c("VC", "OJ"), each=3),
dose=rep(c("D0.5", "D1", "D2"),2),
len=c(6.8, 15, 33, 4.2, 10, 29.5))
print(df2)

# Plot "len" by "dose" and
# Change line types and point shapes by a second groups: "supp"
ggline(df2, "dose", "len",
linetype = "supp", shape = "supp")

# Change colors
# +++++++++++++++++++++

mylineBlue <- rgb(57,106,177, max = 255)
mylineOrange <- rgb(218,124,48, max = 255)
mylineGreen <- rgb(62,150,81, max = 255)
mylineRed <- rgb(204, 37,41, max = 255)

# Change color by group: "supp"
# Use custom color palette
ggline(df2, "dose", "len",
linetype = "supp", shape = "supp",
color = "supp", palette = c("#00AFBB", "#E7B800"))


ggline(df2, "dose", "len",
linetype = "supp", shape = "supp",
color = "supp", palette = c(myBlue, myOrange))

# Data: ToothGrowth data set we'll be used.
df3 <- ToothGrowth
head(df3, 10)

# It can be seen that for each group we have
# different values
ggline(df3, x = "dose", y = "len")

# Visualize the mean of each group
ggline(df3, x = "dose", y = "len",
add = "mean")

# Add error bars: mean_se
# (other values include: mean_sd, mean_ci, median_iqr, ....)
# Add labels
ggline(df3, x = "dose", y = "len", add = "mean_se", title = "with Error Bars")

#############Time Series Plotting#############
#browseURL("http://www.sthda.com/english/articles/32-r-graphics-essentials/128-plot-time-series-data-using-ggplot/")

head(economics)

# Basic line plot
ggplot(data = economics, aes(x = date, y = pop))+
  geom_line(color = "#00AFBB", size = 2)

# Plot a subset of the data
ss <- subset(economics, date > as.Date("2006-1-1"))
ggplot(data = ss, aes(x = date, y = pop)) + 
  geom_line(color = "#FC4E07", size = 2)

# gather() rearranges the data frame by specifying the columns that are
# categorical variables with a - notation.

# Gather takes multiple columns and collapses into key-value pairs, duplicating
# all other columns as needed. You use gather() when you notice that you have
# columns that are not variables.





gather(data, key = "key", value = "value", ..., na.rm = FALSE,
  convert = FALSE, factor_key = FALSE)

detach("package:ggpubr", unload=TRUE)
detach("package:dplyr", unload=TRUE)
library(dplyr)

#Use gather from wide to long
#transform dataframe
 df4 <- economics %>%
  select(date, psavert, uempmed) %>%
  gather(key = "variable", value = "value", -date)

head(economics,3)
head(df4, 3)

# Multiple line plot
ggplot(df4, aes(x = date, y = value)) + 
  geom_line(aes(color = variable), size = 1) +
  scale_color_manual(values = c("#00AFBB", "#E7B800")) +
  theme_minimal()

# Multiple line plot w/ trend smoothed line
ggplot(df4, aes(x = date, y = value)) + 
  geom_line(aes(color = variable), size = 1) +
  scale_color_manual(values = c("#00AFBB", "#E7B800")) +
  theme_minimal() + stat_smooth(
  color = "#FC4E07", fill = "#FC4E07",
  method = "loess"
  )

###################Color Palettes###############################

browseURL("https://www.datamentor.io/r-programming/color")

###############Group Sizes#####################

library(nycflights13)

flights <-as.data.frame(nycflights13::flights)

dim(flights)

#how many carriers
flights %>% group_by(carrier) %>% 
  n_groups()

#summarize does the same as above
flights %>% summarise(n_distinct(carrier))

flights %>% group_by(carrier) %>% 
  group_size()

#how many flights per carrier
flights %>% group_by(carrier, dest) %>% 
  n_groups()

#how many flights per carrier - same as above
flights %>% summarise(n_distinct(carrier,flight))

################Word Count############################
# NOT RUN {
library(ngram)
library(stringr)

words <- c("a", "b", "c")
words
wordcount(words)

words2<-c("abc", "d ef", "g h i")

df <- data.frame(words, words2)
df

apply(df, 2, wordcount)

wordcount(df$words, sep = " ")

df$freq<-str_count(df$word,'\\w+')

# str <- concatenate(words, collapse="")
# str
# wordcount(str)
?str_count

library(splitstackshape)
library(dplyr)

#this works well for splitting words from dataframe
#and then counting them
cSplit(df, "words2", sep = " ", direction = "long") %>%
      group_by(tolower(words2)) %>%
      summarise(Count = n())

#does same as above - gives frequency count
data.frame(table(unlist(strsplit(tolower(df$words2), " "))))


#works well but returns a list
str_count(df$words2, '\\s+')+1

# \\s - matches single whitespace character
# \\s+ - matches sequence of one or more whitespace characters.

#PERFECT!!!!!!
df %>% 
  mutate(word_count = str_count(df$words2, '\\s+')+1) %>% 
  arrange(desc(word_count))

################is.na count########################

#if the sum is = 0, this means there are no missing values
sum(is.na(restData$councilDistrict))
#if there is any value = n/a it returns false
any(is.na(restData$councilDistrict))
##################t-test#####################

#the R function t.test() can be used as follow:

t.test(x, y, alternative = "two.sided", var.equal = FALSE)

# Data in two numeric vectors
women_weight <- c(38.9, 61.2, 73.3, 21.8, 63.4, 64.6, 48.4, 48.8, 48.5)
men_weight <- c(67.8, 60, 63.4, 76, 89.4, 73.3, 67.3, 61.3, 62.4) 
# Create a data frame
my_data <- data.frame( 
                group = rep(c("Woman", "Man"), each = 9),
                weight = c(women_weight,  men_weight)
                )

head(my_data)

group_by(my_data, group) %>%
  summarise(
    count = n(),
    mean = mean(weight, na.rm = TRUE),
    sd = sd(weight, na.rm = TRUE)
  )

ggboxplot(my_data, x = "group", y = "weight", 
          color = "group", palette = c("#00AFBB", "#E7B800"),
        ylab = "Weight", xlab = "Groups")

# Assumption 1: Are the two samples independents?
#   -Yes, since the samples from men and women are not related.

# Assumption 2: Are the data from each of the 2 groups follow a normal distribution?
#  -Use Shapiro-Wilk normality test as
#   described at: Normality Test in R. - Null hypothesis: 
#   the data are normally
#   distributed - Alternative hypothesis: the data are not
#   normally distributed
#
#   We’ll use the functions with() and shapiro.test()
#    to compute Shapiro-Wilk test for each group of samples. 
    

# Shapiro-Wilk normality test for Men's weights
with(my_data, shapiro.test(weight[group == "Man"]))# p = 0.1
# Shapiro-Wilk normality test for Women's weights
with(my_data, shapiro.test(weight[group == "Woman"])) # p = 0.6
        # From the output, the two p-values are greater than the significance level 0.05
        # implying that the distribution of the data are not significantly different
        # from the normal distribution. In other words, we can assume the normality.


# Assumption 3. Do the two populations have the same variances?

# We’ll use F-test to test for homogeneity in variances. This can be performed
# with the function var.test() as follow:

res.ftest <- var.test(weight ~ group, data = my_data)
res.ftest

# The p-value of F-test is p = 0.1713596. It’s greater than the significance
# level alpha = 0.05. In conclusion, there is no significant difference between
# the variances of the two sets of data. Therefore, we can use the classic
# t-test witch assume equality of the two variances.

# Compute t-test: Method 1 - lists
res <- t.test(women_weight, men_weight, var.equal = TRUE)
res

# Compute t-test: Method 2 - Dataframe
res <- t.test(weight ~ group, data = my_data, var.equal = TRUE)
res

# printing the p-value
res$p.value
p_value <- res$p.value

# INTERPRETATION OF RESULT:
    # The p-value of the test is 0.01327, which is less than the significance level
    # alpha = 0.05. We can conclude that men’s average weight is significantly
    # different from women’s average weight with a p-value = 0.01327.

# if you want to test whether the average men’s weight is less than the average
# women’s weight, type this:
t.test(weight ~ group, data = my_data,
        var.equal = TRUE, alternative = "less")

# Or, if you want to test whether the average men’s weight is greater than the
# average women’s weight, type this

t.test(weight ~ group, data = my_data,
        var.equal = TRUE, alternative = "greater")

############### CROSS TABS ###################

#the next thing you want to do is make summaries or cross tabs about the data sets that you observe

data("UCBAdmissions")
DF=as.data.frame(UCBAdmissions)
summary(DF)
#identify where the realtionship exists in this data
#the left variable ("freq") is the variable that you want displayed in the table and then you can break that down with different sorts of variables (i.e. "gender", "admit")
xt<-xtabs(Freq ~ Gender +Admit, data=DF)
xt

############ Merge datasets##############


file_list <- list.files()
 
for (file in file_list){
       
  # if the merged dataset doesn't exist, create it
  if (!exists("dataset")){
    dataset <- read.table(file, header=TRUE, sep="\t")
  }
   
  # if the merged dataset does exist, append to it
  if (exists("dataset")){
    temp_dataset <-read.table(file, header=TRUE, sep="\t")
    dataset<-rbind(dataset, temp_dataset)
    rm(temp_dataset)
  }
}

browseURL("https://developers.google.com/analytics/devguides/config/mgmt/v3/user-management#list_all_users_for_an_account")


complete <- function(directory, id){
	dat <- data.frame()
	newdf<-data.frame()
	for (i in id) {
        dat <- rbind(dat, newdf)
	}
}



for (file in file_list) {
  file_list <- list.files()
    print(file)
}

for (file in file_list) {
  file_list <- list.files()
    print(paste(length(file), file))
}

file_list <- list.files()
 myfunction <- function(file_list) {
  dat <- data.frame()
	newdf<-data.frame()
	for (file in file_list) {
    dat <- rbind(dat, newdf)
  }
 }
 myfunction(file_list)
 dat
 
###########Dplyr set operations #######################
 
 
 x <- c(1:4)
 y <- c(2:7)
 
 union(x,y) # combines
 
 intersect(x,y) #calculates the intersect 
 
 setdiff(x,y) #what they don't have in common
 
 setequal(x,y) #tests if 2 sets are equal

 x %in% y  #use in operator for comparing sets
 
 
#computes new columns but drop existing variables
# transmute keeps only the variables you create
transmute(iris, sepal = 2*Sepal.Length)
 
##############Distinct in dplyr############## 
 #vs unique in R
 
 #unique eliminates duplicate elements/rows from vector, df or array
 
 unique(mtcars$gear)
 
#########Pull function#############

# pull function extracts a variable as a vector



############### Seq function #############

seq(1, 10, by= 2)

#######Functions#########3

#Part 1:

coin_sides <- c("head", "tail")
n_flips <- 10

# Sample from coin_sides n_flips times with replacement
sample(coin_sides, size = n_flips, replace = TRUE)

#Part 2:
# Update the function to return n coin tosses
toss_coin <- function(n_flips) {
  coin_sides <- c("head", "tail")
  sample(coin_sides, size = n_flips, replace = TRUE)
}

# Generate 10 coin tosses
toss_coin(10)



print_stuff <- function(x){
  if (x<5)
    print(x)
  else
    print(x+2)
}

print_stuff(10)
print_stuff(4)

for (id in ids){
  print (id)
}

head(mtcars)

x <- c(3,2,4,"NA",1)

replace_mean <- function(x){
  if(is.na(x))
    mean(x)
  else return(x)
}

replace_mean(x)

add_n <- function(x, n=1){
  y <- x + n
  return(y)
}
add_n(x=4)
x

my_list <- c(1,3,4,5,0,21)

for (x in my_list){
  if (x == max(my_list))
  print(max(x))
}

second_largest <- function(my_list)
  large <- 0
  two_large <- 0
for (x in my_list){
  if (large == 0){
    largest <- current_number 
  }else{
    x > large
    two_large <- x
    print(two_large)
}
}

  
wins <- 0
while (wins < 10){
    print ("Does not make playoffs")
    wins <- wins + 1
}

wins <- 0
while (wins <= 10){
    if (wins < 10){
        print("does not make playoffs")
    } else {
        print ("makes playoffs")
    }
    wins <- wins + 1
}



#we get values of x that are both non-missing and greater than 0
x[!is.na(x) & x > 0]

#subset 3rd, 5th, 7th elements of x
x[c(3,5,7)]

#negative indexing
x[c(-2,-10)]
x[-c(2, 10)] #gives exact same result

vect <- c(foo = 11, bar = 2, norf = NA)
vect # each element has a name

#we can get the names of passing vect as an argument to names function
names(vect)

vect2 <- c(11, 2, NA)

#Then, we can add the `names` attribute to vect2 after the fact with names(vect2) <- c("foo", "bar", "norf").
names(vect2) <- c("foo", "bar", "norf")

identical(vect, vect2)


vect[c("foo", "bar")] # specify names with vect

##########Aggregation##########


#fizzbuzz
for (n in 1:100) {
 if (n %% 3 == 0 & n %% 5 == 0) {print("FizzBuzz")}
 else if (n %% 3 == 0) {print("Fizz")}
 else if (n %% 5 == 0) {print("Buzz")}
 else print(n)
}

Fibonacci <- numeric(10)
Fibonacci[1] <- Fibonacci[2] <- 1
for (i in 3:10) Fibonacci[i] <- Fibonacci[i - 2] + Fibonacci[i - 1]
print("First 10 Fibonacci numbers:")
print(Fibonacci)


########Binning Your Data###############

# You have a vector and you want to split the data into groups
# according to intervals. This is binning your data.

x <- rnorm(1000)
hist(x)

breaks <- c(-3,-2,-1,0,1,2,3)
f <- cut(x, breaks)

summary(f)

#########Correlation Matrix#########

# Correlation structure:
parking %>% 
  cor() %>% 
    corrplot(type = "upper", insig = "blank", addCoef.col = "black", diag=FALSE)

