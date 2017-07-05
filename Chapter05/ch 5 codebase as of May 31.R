# # 5
# Using Survival Analysis to Predict and Analyze Customer Churn
# In an Infinite Universe anything can happen,’ said Ford, ‘Even survival. Strange but true.’ 
# Douglas Adams The Restaurant at the End of the Universe (1980)
# What is Survival Analysis?
# 
# Survival Analysis covers a broad range of topics. Here is the list of topics that we will cover in this chapter:
# •	Survival Analysis
# •	Time based variables and regression
# •	R survival objects
# •	Customer attrition or Churn
# •	Survival Curves
# •	Cox Regression
# •	Plotting Methods
# •	Variable Selection
# •	Model Concordance
# Often predictive analytic problems deal with various situations concerning the tracking of  important events along a customers journey, and predicting when these events will occur. Survival analysis is a form of analysis which is based upon the concept of “time to event”. The time to event is simply the number of units of time which have elapsed until something ‘happens’. The event can be just about anything; a car crash, a stock market crash, or a devastating phenomenon.
# Survival analysis originated in the studying of patients who developed terminal diseases, such as cancer. Hence the term ‘survival” However, conceptually, it can even be applied to many marketing applications in which you are following the occurrence of an “Event” over a customer’s lifetime. In this case the “Time to Event” can mean a customer response, or purchase. 
# In our example, we will use a “Customer Churn” example. Customer Churn is a term that you will hear often in the context of how a company retains its customer. Churn is very important, since it often costs more to acquire new customers, than it would by offering some discounts or promotions to existing customers in order to keep them happy and not leave.
# There are many different statistical modelling techniques you can choose for churn analysis, including regression, decision trees, random forests, naive Bayes, and neural networks. 
# Survival Analysis is a good technique to use with customer churn problems since it is able to deal specifically with two aspects of marketing data, which other techniques have problems with. These involve the concept of Time dependent data and Censoring.
# Time Dependent Data
# In many analytic techniques, all data is treated as static at the time of analysis, and these techniques are not well equipped to deal with data that changes over time. Any event that measures a change in a variable over time,  e.g. Age, or changes in attitudes via surveys can be treated as time dependent variables, and are handled well by survival techniques. This works well within a marketing concept since the treatment of customers are always changing, and we need a mechanism to measure the effect of any interventions such as promotions, advertising which can change customer behaviour over time.
# Censoring
# In general, censoring is a term which is used to describe data which is only partially known. The reason it is considered partially known is that all data is constrained between the starting and ending periods of an observational study. This can be information which occurs before a study has begun or after a study has ended. If all the information is contained within the study period itself, the data is NOT censored. However, this rarely happens. Censored data can be Left or Right Censored.
# Left Censoring
# In a marketing context, studies usually begin with customers already in place, and without any knowledge of how they were acquired.
# Additionally, not all customers start at the same time. When a customer has already started prior to the beginning of a study or analysis, the some customer attributes can be referred to as “Left Censored”.  If you start an analysis which includes all of your customers, you will not have knowledge of some of the events that preceded the start of the study. This knowledge may include very important information, such as customer dissatisfaction with a prior customer policy that was implemented way before the start of the study, but there is not much we can do about it, if we don’t have the information. In a survival analysis, everyone starts of on an even footing.
# Right Censoring
# Studies also have an ending period, and customers who may leave a day after the study ends, would still be considered “Active”. This is another example of data that wouldn’t be recorded. Therefore, a customer is considered “Right Censored”, if a study ends before the customer terminates. However, it also includes some other special situations, such as when a customer is still active at the end of the study, or is ‘lost’ due to events not related to the study variables. 
# For example, a customer who has been active only for 10 days would still be expected to be active if the study happens to be ending a short time after that. Or, if a customer did not respond to follow up questionnaires, due to change of address, they could be thrown out of the study. These are all naturally occurring events.
# In the diagram below, the black vertical lines indicate the beginning and end dates of a hypothetical churn study. The first dot in each row indicates the point in which the customer was acquired, and the last dot indicates the point in time that the customer left.  Only the data available within the begin and end date periods are available for analysis. The diagram shows vertical lines in places where a customer could be considered as left or right censored. 
# •	As indicated in the top bar, we see that a customer was acquired after the study began, and left before the study ended.  Therefore, we have complete information about the customer, with regard to tenure, and the customer is considered not censored.
# •	The middle bar also shows a customer which was acquired after the study begins, however the customer is still active at the end of the study, and the dot slightly past the right vertical line shows that the customer left shortly after the end of the study.   However this churn activity will not be reflected in the data, so this is an example of  right censored data.
# •	The bottom bar shows a customer who was acquired prior to the start of the study, with an unknown start date.  This is an example a left censored observation..
#  
#  
# 
# Insert Image B05033_05_01.png
# 
# 
# 
# 
# Our Customer Satisfaction Dataset
# In this chapter we will be looking at dataset of hypothetical customers who are subscribed to an online service, and who have responding to a customer satisfaction survey prior to the beginning of the study. This survey was then matched to transactional as well as demographic data to produce this simple analysis data set, consisting of an “Event” variable (Churn), which will represent whether or not a customer unsubscribed from the service.  We will also include some transaction data (number of purchases last month), as well as some demographic data (Gender, Educational Level), as well as an overall satisfaction survey administered prior to the start of the study.
# Variable	Description
# Monthly.Charges	Average dollar amount of previous purchases
# Purch.last.Month	Number of purchases in the month before the study begins
# 
# Satisfaction	Overall Satisfaction with the service supplied on a Likert scale
# Satisfaction2	Follow up Satisfaction score
# Gender	Male or Female
# 
# Education Level	Bachelors/Masters/Doctorate
# Churn	1 if customer left before the study ended. 0 if customer was still active at the end of the study
# 
# Generating the data using probability functions
# Rather than use a pre-existing data set, we will generate our own data by using some built-in sampling and probability functions. This will be a valuable way to learn how to perform analysis, since it will enable you to alter the makeup of your own data and observe how it changes the models produced. Some of the code that you will see also incorporate some of the concepts of reproducible research that we discussed in Chapter 1, Getting Started with Predictive Analytics. 
# To ensure that these examples run correctly, make sure that “setwd” is set to the correct folder on your computer. This function is illustrated in the first few lines of the code below. In addition to setwd(), you will also see a few other functions within the code examples given which will help in promoting reproducibility.
# •	Set.seed() – This is always supplied with a constant. This guarantees that any sampled data can be reproducible exactly over different computers which use the same seed. In this example I will use the number 1 as a seed.
# •	Dev.copy() – This copies the plot which is displayed on the screen to the file name specified within the directory set by “setwd ()” above. That way you can keep all off your images in the appropriate directory applicable to the project, or sub-project you are working on. When you are done with your dev.copy(), use dev.off() to reset the plots. Note: you may need to specify dev.off() twice for it to complete. 
# •	Clearhistory(),Savehistory() – All code contained between these two functions are copied to the filename specified in “Savehistory()”.This will allow you to keep a permanent record of the code, separate from the code editor. This is important if you are manually keeping track of versions, or are using it to include in other word processing programs.
# •	Code labels – You will see some code labels which start with # and end with ==== (4 equal signs). While they are technically comments, they also serve as labels or bookmarks by identifying specific sections of the code. For example, Our first section of code will begin using the #simulate churn====   label as shown in the figure
# In Rstudio, use the up/down arrows at the bottom of source pane jump to an area in the code which has a defined label
#  
# Insert Image B05033_05_02.png
# After locating the section of the code below, select and run it. Here is a brief outline of what the code does,by labelled section..  For each item, jump to the code label indicated.
# Creating the Churn and No Churn Dataframes
# The code begins by simulating data for the response variable (XChurn). Remember this variable can take on only two values; 0 and 1. Since we want these groups to behave differently we will simulate separate data separately for each of the two groups, the churners (xchurn), and those that remained active at the end of the 12 month period (xnochurn). 
rm(list = ls())
#simulate churn data====
setwd('C:/PracticalPredictiveAnalytics/Outputs')
frame.size <- 1000
xchurn <- data.frame(Churn=rep(c(1),frame.size))
xnochurn <- data.frame(Churn=rep(c(0),frame.size))
# 
# Creating and verifying the new simulated variables
# 
# This section simulates the independent variables Xeducation,Xgender,Xsatisfaction,Xpurch.last.month, and Xmonthly.charges, The code uses the sample() function to generate slightly different data for each of those two data frames based upon a probability vector. Some of the generated data distributions will have only slight differences between the Churners and Non-churners (e.g Education Levels), while other variables will be generated  specifically to show the differences between members who stayed and who left (Tenure2, and purchases last month).

#create new vars====
# set the seed for reproduceability

set.seed(1)

#set the gender and Education Vectors.
ed.vector <- c("Bachelor's Degree", "Master's Degree", "Doctorate Degree")
gen.vector <- c("M", "F")

#sample from each of the vector elements with the associated probabilities given in the probability vector.

xchurn$Xeducation <- sample(ed.vector, nrow(xchurn),replace = TRUE, prob = c(.8,.15,.05))
xnochurn$Xeducation <- sample(ed.vector, nrow(xnochurn),replace = TRUE, prob = c(.7, .10, .05))
xchurn$Xgender <- sample(gen.vector, nrow(xchurn),replace = TRUE, prob = c(.8,.2))
xnochurn$Xgender <- sample(gen.vector, nrow(xnochurn),replace = TRUE, prob = c(.75,.25))

#do the same for the service vector. 1=not at all satisfied, 5=very satisfied.

serv.vector <- c("1","2","3","4","5",NA)
#make the churners not very satisfied. Note that the probability is higher for the lower service categories than for the higher satisfaction scores.  (e.g .35 vs. .01)

xchurn$Xsatisfaction <- sample(serv.vector, nrow(xchurn),replace = TRUE, prob = c(.35,.35,.2,.2,.2,.01))

#non churners get an increased probability of a higher satisfaction score

xnochurn$Xsatisfaction <- sample(serv.vector, nrow(xnochurn),replace = TRUE, prob = c(.2,.2,.2,.35,.35,.01))

# simulate incremental increase in satisfaction after the 2nd survey for the churners category (by adding 1 across the board).  This is to simulate something the company did to get them to stay.

xchurn$Xsatisfaction2 <- as.integer(xchurn$Xsatisfaction) + 1

#For the 2nd survey. keep the satisfaction level the same for the others

xnochurn$Xsatisfaction2 <- sample(serv.vector, nrow(xnochurn),replace = TRUE, prob = c(.2,.2,.2,.35,.35,.01))

#simulate a higher increase in calls to customer service for the churners.

xchurn$Xservice.calls <- sample(c(0,1,2,3,4,5), nrow(xchurn),replace = TRUE, prob = c(.80, .20, .05, .03, .05, .01))
xnochurn$Xservice.calls <- sample(c(0,1,2,3,4,5), nrow(xnochurn),replace = TRUE, prob = c(.80, .10, .05, .03, .02, .01))

#Simulate tenure of 12 months to 1 month. Notice, for example, that churners have a lower probability of being assigned a tenure of 12 months (.8) than the nonchurners do. (.9)

xchurn$Xtenure2 <- sample(c(12:1), nrow(xchurn),replace = TRUE, prob = c(.8,.7,.7,.6,.5,.4,.3,.2,.1,.3,.3,.1))
xnochurn$Xtenure2 <- sample(c(12:1), nrow(xnochurn),replace = TRUE, prob = c(.9,.8,.7,.6,.5,.4,.3,.2,.1,.1,.1,.1))

#simulate the number of purchases last month. We do the simulation a bit differently this time, since there is no predefined vector to sample from. The rep() function is used to repeat a value a specified number of time. For churners, 1 purchase last month has the highest probability of being selected since it is repeated 150 times. 

xchurn$Xpurch.last.month <- sample(c(rep(10,5),rep(1,150),rep(3,10)),nrow(xchurn),replace = TRUE)
xnochurn$Xpurch.last.month <- sample(c(rep(0,5),rep(1,20),rep(3,10)),nrow(xnochurn),replace = TRUE)

#monthly charges are selected via a normal distribution. Churners will end up having average monthly charges of $215.  This is used to simulate “High Charges” as a reason for leaving

xchurn$Xmonthly.charges <- rnorm( nrow(xchurn), mean=215,sd=70)
xnochurn$Xmonthly.charges <- rnorm( nrow(xnochurn), mean=75,sd=50)
#also convert to a list
xchurn.list <-lapply(xchurn, function(x) sample(x,replace=TRUE))
xnochurn.list <-lapply(xnochurn, function(x) sample(x,replace=TRUE ))

# After the data has been generated, you can use some additional R functions to verify that the data has been generated as intended
# 
# For example, in the command line, you can use the prop.table function to verify that the percentages were generated correctly.

prop.table(table(xchurn$Xeducation))
# 
# Bachelor's Degree  Doctorate Degree   Master's Degree 
#             0.802             0.053             0.145 
# 
# > prop.table(table(xnochurn$Xeducation))
# 
# Bachelor's Degree  Doctorate Degree   Master's Degree 
#             0.819             0.060             0.121 
# 
# 
# This shows the data for the churners was generated correctly from the original parameters specified in the sample(ed.vector) code line. There are only minor differences between the two churn/nochurn  groups.
# 
# However, note that since this is simulated data, you could alter the prob= option in the sample() function to correspond to whatever scenario is applicable to your industry. This is desirable since it will ultimately suggest to you how robust your model is when the assumptions change. If you wish, you can experiment with some different scenarios by changing the probability vector.  
# 
# 
# 
# For example ,If we wanted to drastically alter the makeup of the education levels  by increasing the occurance of Doctorate degrees , we would increase the probability of the 3rd slot of the probability vector again.  
# 
Xeducation_PHD <- sample(ed.vector, 1000,replace = TRUE, prob = c(.7, .10, .95))

# We can then see the differences by plotting the percentages

par(mfrow=c(1,3))
barplot(table(xchurn$Xeducation),names.arg=c('B.A','Ph.D','Masters'),cex.names=.75,ylim=c(0,800),main='Slightly higher proportion of Bachelors and Masters Degree',cex.main=1)
barplot(table(xnochurn$Xeducation),names.arg=c('B.A','Ph.D','Masters'),cex.names=.75,ylim=c(0,800),main='Slightly lower  proportion of Bachelors and Masters Degree',cex.main=1)
barplot(table(Xeducation_PHD),names.arg=c('B.A','Ph.D','Masters'),cex.names=.75,ylim=c(0,800),main='Exaggered number of Doctorate Degrees',cex.main=1)







# Recombining the Churner and Nonchurners
# 
# Now that we have simulated the variables separately for the two group, we will recombine them and them and then remove some of the NA’s.
#bind them back together==== 

#bind them back together====

d1 <- data.frame(xchurn.list)
d2 <- data.frame(xnochurn.list)
ChurnStudy <- rbind(d1,d2)
ChurnStudy <- na.omit(ChurnStudy)
summary(ChurnStudy)
nrow(ChurnStudy)
savehistory (file="ch5 generate churn data")
 
# The str, summary, and nrow functions will output to the console, and the savehistory() function will save all of the commands that were run to an external file.
# 
#  
# 
# Notice that the summary output shows satisfaction as a factor, and satisfaction2 as a character variable.  We will alter the format and the values of satisfaction2 later in the chapter when we discuss the follow-up survey.
# 
# Try plotting some of the histograms which show the difference in Tenure and the number of purchase last month for the 2 groups, the churners, and those who remained active
par(mfrow=c(2,2))
hist(xchurn$Xtenure2,main="Churners Tenure")
hist(xnochurn$Xtenure2,main="Non-Churners Tenure")
hist(xchurn$Xpurch.last.month, col = "grey", labels = FALSE,main="Churners Purch last Month")
hist(xnochurn$Xpurch.last.month, col = "black", labels = FALSE,main="Non-Churners Purch last Month")
dev.copy(jpeg,'Ch5 - Plots after dataset creation.jpg'); dev.off()


# Compare the churners to the non-churners with respect to tenure, and number of purchases in the last month.
# 
#  
# Insert Image B05033_05_03.png
# We can see from the above plots that the churners generally have a lower number of purchases last month than those who remained active. For the churners, there seems to be some churn activity after 1 or 2 months, but this is a premature assessment, since we do not know at which period of time the customer came aboard. 
# 
# Creating Matrix plots
# If we would want to explore Tenure a bit further for the churners, we could also produce a matrix plot showing the association between tenure and any other variables we choose. In this example we will use the function ggpairs() to plot the matrix plots for Tenure, Gender, Satisfaction, and monthly charges. 

str(xchurn)
#install.packages("GGally")
library(GGally)
library(ggplot2)
ggpairs(xchurn,c(3,4,7,9),lower=list(combo=wrap("facethist",binwidth=30)))

# We can see from the plot below that Males  churn quicker than Females. This is indicated by the matrix plot in the 1st row and 3rd column.  Note that a boxplot is produced since a continuous variable (Tenure) is being compared with a categorical variable (Gender).  The matrix plot is a great way to quickly observe the single variable distribution as well as the pairwise plots.  Single variable intersections which are continuous typically show density plots for that variable.  For example monthly charges (row 4, column 4) is clearly normally distributed with an average monthly charge of about $240.  For count variables, barcharts are typically shown.  However you can override the default presentation, so check the documentation for the ggpairs function.
# 
#  
# Insert Image B05033_05_04.png
# Partitioning into Training and Test Data
# Next, we will generate test and training datasets, so that we can validate any models produced. There are many ways of generating test and training sets.
# In earlier chapters we used the createDataPartition function.  For this example, we will generate the test and training data using native R functions.  Please refer to the outline of the code below and then run the code that follows.
# •	Set a variable corresponding to the percentage of the data to designate as training data (TrainingRows). In this example we will use 75%.
# •	Use the sample() function to randomize the rows and assign to a new dataframe named ChurnStudy. 
# •	Then select the first “TrainingRows” rows.  Since the “df” data frame has already been sampled, selecting a percentage of rows sequentially from a random sample is a convenient and valid way to select a training sample.
# •	The remaining rows (TrainingRows+1 to the end) will be the testing data set.  Assign it to ‘ChurnStudy.test’
# Once we have generated the test and training validation dataset, we will use the stargazer package (which we used in Chapter 1, Getting Started with Predictive Analytics), to generate html output for the original ChurnStudy data set as show below. 

#divide into train and test====
TrainingRows <- round(.75 * nrow(ChurnStudy))	
TrainingRows
set.seed(1020)
#randomize rows
df <- ChurnStudy[sample(nrow(ChurnStudy)), ]
rows <- nrow(df)
ChurnStudy <- df[1:TrainingRows, ]  #training set
ChurnStudy.test <- df[(TrainingRows+1):rows, ]    #test set
nrow(ChurnStudy)
nrow(ChurnStudy.test)
str(ChurnStudy)
str(ChurnStudy.test)
library(stargazer)
stargazer(ChurnStudy[1:10,1:9],out=c("ch 5 AnalysisDataFrame.html"),summary=FALSE,type='html')
browseURL("ch 5 AnalysisDataFrame.html")
savehistory (file="ch5 generate test and train")

# Towards the end of the code shown above, The browseURL() function will open up your browser and view the HTML file which has been generated.
# 
# 
#  
# Insert Image B05033_05_05.png 
# 
# Setting the Stage by creating Survival Objects
# Coding Survival Analysis in R usually starts with creating what is known as a survival object using the Surv() function.  A survival object contains more information that a regular dataframe. The purpose of the survival object is to keep track of each time and the event status (0 or 1) for each observation.  It is also to designate what the response (dependent) variable is. 
# At minimum, you need to supply a single time variable and an event when defining a survival object.  In our case, we will use the tenure time (Xtenure2) as the time variable, and a formula which designates the defining event. In our case this will be “Churn==1”, since that means that the customer churned in that month.
 
#install.packages("survival")
library(survival)
ChurnStudy$SurvObj <- with(ChurnStudy, Surv(Xtenure2, Churn == 1))

# As I mentioned in earlier chapters, I always like to issue a str() command after I create a new data frame, just to make sure the results are as expected. 

str(ChurnStudy$SurvObj)
head(ChurnStudy$SurvObj)
ChurnStudy$SurvObj[1:10,1:2]
#       time status
#  [1,]    7      1
#  [2,]    9      1
#  [3,]    6      1
#  [4,]   11      0
#  [5,]   11      1
#  [6,]    1      0
#  [7,]    4      1
#  [8,]   12      1
#  [9,]   12      1
# [10,]    3      1
# 
# You can also tabulate the data by time and event.  We can see that at the end of the study period, approximately 50% of the members have churned. 

table(ChurnStudy$SurvObj[,1],ChurnStudy$SurvObj[,2])
    
#        0   1
#   1   18  15
#   2   10  52
#   3   17  34
#   4    7  20
#   5   31  39	
#   6   47  42
#   7   76  60
#   8  102  68
#   9   96  89
#   10 115 115
#   11 105 105
#   12 113 112
# 
# If you prefer to work using column names rather than column numbers, try converting the survival object to a dataframe first.  This will produce the same results as above, but will allow you to use column names instead of indices.  This is a handier way of referencing a large number of columns. 
Surv.df <- data.frame(ChurnStudy$SurvObj[,1:2])
table(Surv.df$time,Surv.df$status)

# Let’s try a summary. The summary function shows an average tenure of ~8.5 months
summary(ChurnStudy$SurvObj)
#       time            status     
#  Min.   : 1.000   Min.   :0.000  
#  1st Qu.: 7.000   1st Qu.:0.000  
#  Median : 9.000   Median :0.000  
#  Mean   : 8.474   Mean   :0.495  
#  3rd Qu.:11.000   3rd Qu.:1.000  
#  Max.   :12.000   Max.   :1.000  
# 
# When we created the survival object, we created it as part of the original ChurnStudy data frame. To view the full data frame with the survival datat appended, use the View(ChurnStudy) command.  
# Note that the SurvObj time corresponds to the Xtenur2 time.  However, the + designation after the number indicates that the customer was still active at the end of the study period.
# 
#  
# Insert Image B05033_05_05.png
# 
# 
# Examining Survival Curves
# Kaplan Meir survival curves are usually a good place to start to examine the effect of different single factors upon the ‘survival rate, since they are easy to construct and are visualize. (Later on, we will example Cox Regression which can examine multiple factors). 
# Kaplan Meir (KM)  Curves are actually step functions in which the survival, or hazard rate, is estimated at each discrete time point.  This survival rate is computed by calculating the number of customers who have ‘survived’ (still active), divided by the number of customers ‘at risk’.   The number of customers at risk, (which is the denominator) excludes all customers who have already churned, or haven’t achieved the tenure specified at any particular time point. 
# To illustrate if we table ChurnStudy by the number of months active (Xtenure2), we can see that for month 1, there were 44 members whothe survival rate is calculated as (1984 -19) (Number left after end of month 1 / 1984)
table(ChurnStudy$Xtenure2,ChurnStudy$Churn)

#     
#        0   1
#   1   25  19
#   2   12  69
#   3   24  45
#   4    9  29
#   5   50  50
#   6   63  61
#   7  100  73
#   8  124  98
#   9  132 114
#   10 150 159
#   11 144 129
#   12 159 146
# 
# 
# 
# Three elements are needed to construct a KM curve;  
# •	A serial time, which is simply the time interval (months, day, years) reckoned from the start of the study. What that means for customer retention is that a subscriber who has been with a company for 5 yrs. is treated the same as someone joined 1 month ago, if the start period for the study begins 1 month ago. (The 5 prior year is considered ‘censored’ information).
# •	An ‘event flag’, usually 0 or 1 which designates whether or not the event has occurred during that time period.  A customer will have multiple event flags corresponding to each month in the study.
# •	A classification or grouping variable.  This is usually a single variable.
# Kaplan Meir survival curves are then generated by using the Survfit() function which is contained within the survival package. 
# We can begin by examining the survival curve for the entire dataset, without grouping.  In this case we use a unity operator, or ‘1’ using formula notation, to designate the entire dataset as a single group. 

km <- survfit(SurvObj ~ 1, data = ChurnStudy, conf.type = "log-log")
plot(km,col='red')
title(main = "Survival Curve Baseline")
dev.copy(jpeg,'Ch5 - Survival Plot Baseline.jpg'); dev.off()


# The curve shows all members as being active at the beginning of the study.  As members leave, the plot monotonically decreases in value. You can see that the variance of each estimate (the dashed lines which appear above and below the estimate), is much larger as the time period extends in duration. That is because the sample size becomes smaller as the number of customers shrink, and the estimates become less accurate.  For the baseline estimate, we can see that at 6 months, the (theoretical) estimate shows about 86% customers have remained.  
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 	
# Insert Image B05033_05_06.png
# Plots are great for visually observing where the major churn occurs, but you will also want to look at the underlying data,
# First, look at how “summary(km)” describes  survival object.  The output is a bit  different from how the summary object typically describes a normal R dataframe.
# •	The output will first list the function call which was used to produce the km survival object.

summary(km)
# Call: survfit(formula = SurvObj ~ 1, data = ChurnStudy, conf.type = "log-log")
# 
# 
# •	Next the output lists the data points which were plotted above, along with the probability of survival for that point, along with the 95% confidence intervals.
# 
#  time n.risk n.event survival std.err lower 95% CI upper 95% CI
#     1   1984      19    0.990 0.00219        0.985        0.994
#     2   1940      69    0.955 0.00467        0.945        0.963
#     3   1859      45    0.932 0.00569        0.920        0.942
#     4   1790      29    0.917 0.00625        0.904        0.928
#     5   1752      50    0.891 0.00708        0.876        0.904
#     6   1652      61    0.858 0.00797        0.841        0.873
#     7   1528      73    0.817 0.00892        0.799        0.834
#     8   1355      98    0.758 0.01008        0.737        0.777
#     9   1133     114    0.682 0.01131        0.659        0.703
#    10    887     159    0.559 0.01278        0.534        0.584
#    11    578     129    0.435 0.01387        0.407        0.462
#    12    305     146    0.227 0.01438        0.199        0.255
# 
# You can see by looking at the survival percentages, that the survival rate is cumulative and monotonically descending. What that means is that every subsequent time interval has a decreasing survival probability from the last period. 
# You can also calculate the survival rate for a given month, given that the customer has remained.  For example, in month 12 it will be 48% (146 customers churned /305 customers who were at risk for churning)
# 
# Better Plots
# There is another function which you could use which gives you better graphics and is a bit more customizable than the generic plot function. It is the survplot()  function which is contained in the rms library. Since we will want to demonstrate this function a few different ways with varying parameters, we will wrap a few of the native functions into a new function called “Plotsurv()” which will allow us to customize some of the plots.    
# First, define the function:
library(rms)
plotsurv <- function(x,y,z=c('bars'),zz=FALSE){
  objNpsurv <- npsurv(formula = Surv(Xtenure2,Churn ==1) ~ x, data = ChurnStudy)
  class(objNpsurv)
  survplot(objNpsurv,col=c('green','red','blue','yellow','orange','purple'), 
           label.curves=list(keys=y),xlab='Months',conf=z,conf.int=.95,n.risk=zz)
  mtext(date(),side=3,line=0,adj=1,cex=.5)
  
}

# We will call the baseline plot again, but this time we will include the number of members at risk, which can be found at the top of the horizontal time access.  (You can verify that these numbers conform to the summary(km) function which was run earlier). These numbers correspond to the number of subscribers which were still active at the end of the time period specified. The confidence intervals have also been replaced by short error bars at each marking point.

#baseline plot again
par(mfrow=c(1,1))
ChurnStudy$unity <- 1
plotsurv(ChurnStudy$unity,c(1),c('bars'),TRUE)
title(main = "1 KM Curve with Bands and number at risk")
dev.copy(jpeg,'Ch5 - baseline again.jpg'); 
dev.off()

# A simpler plot is now produced, which contains additional data, and is easier on the eyes.
#  
# Insert Image B05033_05_07.png
# 
# Contrasting Survival Curves
# A baseline survival curve by itself is useful, but the most meaningful analysis comes from looking at the different curves which are generated by different segments of groups.  That way, you can see where any intervention might be required. To generate this curve for gender, we will again use the survfit() function, and specify XGender on the right side of the ~ operator.  This code will give us separate survival curves for Male and Female. 

km.gender <- survfit(SurvObj ~ Xgender, data = ChurnStudy, conf.type = "log-log")
km.gender	
plot(km.gender,col=c('red','blue') ,lty=1:2)
legend('left', col=c('red','blue') ,c('F', 'M'), lty=1:2)
title(main = "Survival Curves by Gender")
dev.copy(jpeg,'Ch5 - Survival Plot by Gender.jpg'); dev.off()

# 
# The two curves plotted below indicate that Females are more likely to be retained over all time periods, and suggests that useful marketing incentives could target Males early on.
#  
# Insert Image B05033_05_08.png
# Testing for the Gender difference between survival curves
# On examination of the survival curve, it is apparent that Females are ‘surviving’ longer than males at every time period.   However, we are judging this purely based upon visual inspection.  Often, the results are not as obvious.  Even if they were obvious, it is good statistical practice to construct a statistical hypothesis test for this.  We will use the log-rank test, which is implemented in R using the survdiff() function.
# The output from the function prints the Chi-square statistics associated with the test, which will demonstrate any significant difference between the two curves, along with the associated p-value.
# For gender, there is a significant difference at the .01 level , as shown by the low p value which is much less that this cutoff.
survdiff(SurvObj ~ Xgender, data = ChurnStudy)
# Call:
# survdiff(formula = SurvObj ~ Xgender, data = ChurnStudy)
# 
#              N Observed Expected (O-E)^2/E (O-E)^2/V
# Xgender=F  341      137      177      9.24      14.5
# Xgender=M 1147      614      574      2.86      14.5
# 
#  Chisq= 14.5  on 1 degrees of freedom, p= 0.000143 
# 
# Testing for the Educational difference between survival curves
# # Now run the survdiff function for any differences in education
# 
survdiff(SurvObj ~ Xeducation, data = ChurnStudy)
# Call:
# survdiff(formula = SurvObj ~ Xeducation, data = ChurnStudy)
# 
#                                 N Observed Expected (O-E)^2/E (O-E)^2/V
# Xeducation=Bachelor's Degree 1186      592    594.8   0.01291   0.07392
# Xeducation=Doctorate Degree    88       45     45.4   0.00301   0.00382
# Xeducation=Master's Degree    214      114    110.9   0.08896   0.12417
# 
#  Chisq= 0.1  on 2 degrees of freedom, p= 0.94 
# 
# Now look the the p value above. The p value for the chi-square test is .94. That means than we cannon conclude that a significant difference exists for the education survival curves.
# This also suggests a closer look at the plot below. We can see that often, the 3 levels of education cluster within 1 standard deviation of the point estimate. Overlapping data points within confidence intervals suggest that there is not enough separation between the means to attain significance.
#
plotsurv(ChurnStudy$Xeducation,c(1:3),c('bars'))
title(main = "3 KM Curve Education")
dev.copy(jpeg,'Ch5 - 3 KM Curve Education.jpg'); dev.off()

# Time 12 (the end of the study) is a perfect example of illustrating this. The three confidence intervals encompass a large ‘swatch’ of survival probability for the 3 education levels, so it is difficult to discern any difference.  As a follow up, it would make sense to combine Master’s and Doctorate Degree into an “Advanced Degree” category and then measure the difference between 2 categories instead of 3.  
#  
# 
# Insert Image B05033_05_09.png
# Plotting the Customer Satisfaction and number of Service call curves
# 
# We will also generate 2 more curves, corresponding to the variables Satisfaction, and number of service calls.
par(mfrow=c(1,1))
plotsurv(ChurnStudy$Xsatisfaction,c(1:5),c('bars'))
title(main = "2 KM Curve Satisfaction")/
dev.copy(jpeg,'Ch5 - 2 KM Curve Satisfaction.jpg'); dev.off()


plotsurv(as.factor(ChurnStudy$Xservice.calls),c(1:6),c('none'))
dev.copy(jpeg,'Ch5 - 4 KM Curve Service Calls.jpg'); 
title(main = "4 KM Curve Service Calls")

dev.off()

# The plots for the curves are sent to the output window, and are copied to the file specified in the code above. 
# 
#  
# 
# 
# 
# Insert Image B05033_05_10.png
# User Exercise:
# Plot the survival curves above and run the log-rank test using survdiff() to see if there is a significant difference.
survdiff(SurvObj ~ Xsatisfaction, data = ChurnStudy)
survdiff(SurvObj ~ Xpurch.last.month, data = ChurnStudy)
survdiff(SurvObj ~ Xservice.calls, data = ChurnStudy)

# Improving the Education Survival curve by adding Gender
# As we have seen, We cannot conclude that a significant difference exists among the Education levels.  Often analyzing interaction effects can uncover significance when other covariates are added.  If we are interested in seeing if there is a difference in education levels which depends on gender, we can create a new variable which contains dummy variables for each combination of Gender and Education. 
# •	We will first create this new variable (factorC) by using the interaction() function. Then we will use our new plotsurv() function, to plot the curve based upon all interactions of education and sex.
# •	Next we will use the survdiff() function to test for the significance of these effects.

#create a new factor with interaction between education and gender
#first check the number of satisfaction levels
#
levels(ChurnStudy$Xsatisfaction)
#
#create and store it in the data frame
#
ChurnStudy$factorC <- with(ChurnStudy, interaction(Xeducation,  Xgender))
#

# Now plot the Survival Curves for each level of Education (3 levels) and Gender (2 levels). That will be a total of 6 plots.  However not all combinations survive to month 12, since there are only 5 levels at the end.

plotsurv(ChurnStudy$factorC,c(1:6),c('none'))
title(main = "4 KM Curve Gender*Education")
#
dev.copy(jpeg,'Ch5 - 4 KM Curve Gender Education.jpg');
dev.off()







# Insert Image B05033_05_11.png
# Call survdiff to see if there is a significant difference among the curves.  The output from  the survdiff function is shown below. 
# 
options(scipen=3)
survdiff(SurvObj ~ ChurnStudy$factorC, data = ChurnStudy)
#
#




# > survdiff(SurvObj ~ ChurnStudy$factorC, data = ChurnStudy)
# Call:
# survdiff(formula = SurvObj ~ ChurnStudy$factorC, data = ChurnStudy)
# 
# 
#                                  N Observed Expected (O-E)^2/E (O-E)^2/V
# ChurnStudy$factorC=Bachelor's Degree.F 279      111   150.49 10.361225 15.550628
# ChurnStudy$factorC=Doctorate Degree.F   22        8     8.21  0.005201  0.006050
# ChurnStudy$factorC=Master's Degree.F    40       18    18.81  0.034461  0.041049
# ChurnStudy$factorC=Bachelor's Degree.M 907      481   444.28  3.034267  8.884136
# ChurnStudy$factorC=Doctorate Degree.M   66       37    37.16  0.000714  0.000903
# ChurnStudy$factorC=Master's Degree.M   174       96    92.05  0.169101  0.230200
# 
#  Chisq= 16.3  on 5 degrees of freedom, p= 0.00597 
# 
# 
# The Chi square test looks at all of the groups together, and will indicate significance if any one of the groups is significantly different from the others.  To see which particular group behaves differently, you need to examine the observed, and expected column, as well as the squared error terms in the last two columns.  Higher values indicate deviation from the expected. On examination of the output, we see that there are 2 effects which seem to be the significant groups.  
# •	Females with Bachelor degrees. We expected 150 churners and we observed 111. This is a group that has relatively lower churn than the others.
# •	Males with Doctorate degrees.  The observed survival rate is higher than what would be expected. 
# Earlier we saw that college degree by itself didn’t make much of difference.  But adding gender to the mix can identify specific cohorts which can be targeted.
# 
# Save the history

savehistory (file="ch5 interaction plot km curves.log")


# Transforming Service Calls to a binary variable
# Variables with a higher number of levels will often be difficult to manage even though there may be statistically significant differences shown in the curves. This can be due to the smaller sizes of the groups. Rather than try to analyse all the groups at once, it often make more senses to first find a cutoff point which collapses the variable into a binary outcome.
# For example, running the survdiff function on the number of service calls (ranging from 0 to 5) shows a significant difference among the individual survival curves 

survdiff(SurvObj ~ Xservice.calls, data = ChurnStudy)
# Call:
# survdiff(formula = SurvObj ~ Xservice.calls, data = ChurnStudy)
# 
#                     N Observed Expected (O-E)^2/E (O-E)^2/V
# Xservice.calls=0 1103      507   542.87     2.371    10.322
# Xservice.calls=1  222      154   116.77    11.873    16.992
# Xservice.calls=2   58       23    32.72     2.888     3.711
# Xservice.calls=3   51       33    28.43     0.734     0.923
# Xservice.calls=4   47       31    25.95     0.985     1.215
# Xservice.calls=5    7        3     4.26     0.373     0.448
# 
#  Chisq= 23.3  on 5 degrees of freedom, p= 0.000301 
# 
# The last two columns give the chi square values, and you can see that most of the higher values are for the lower number of service calls.  There seems to be a ‘break’ between Xservice.calls 1 and 2.   So, we can treat that as a natural breakpoint.
# Alternatively, we can formulate a hypothesis that there is difference between low and high service calls, we can create a new binary variable which simply designates whether there were any service calls or not.
# We can then plot the results, and use the log-rank test again to test for the difference

ChurnStudy$called.binary <- as.factor(ifelse(ChurnStudy$Xservice.calls ==0,'NONE','CALLED'))
survdiff(SurvObj ~ ChurnStudy$called.binary, data = ChurnStudy)
plotsurv(ChurnStudy$called.binary,c(1:2),c('none'))
title(main = "5 KM Curve Called")
dev.copy(jpeg,'Ch5 - 5 KM Curve Called.jpg'); dev.off()

survdiff(SurvObj ~ ChurnStudy$called.binary, data = ChurnStudy)


# The plotsurv call specified above produces the following plot:
#  
# 
# Insert Image B05033_05_12.png
# 
# Testing the difference between Customers who called and those who did not. 
# 
# # Calling the survdiff function above produces the chi square test
# survdiff(SurvObj ~ ChurnStudy$called.binary, data = ChurnStudy)
# Call:
# survdiff(formula = SurvObj ~ ChurnStudy$called.binary, data = ChurnStudy)
# 
#                            N Observed Expected (O-E)^2/E (O-E)^2/V
# ChurnStudy$called.binary=CALLED  385      244      208      6.18      10.3
# ChurnStudy$called.binary=NONE   1103      507      543      2.37      10.3
# 
#  Chisq= 10.3  on 1 degrees of freedom, p= 0.00131 
# 
# This show are clear break between a customer calling or not, and indicates that customer calls might require an intervention plan so that any potential churn can be addressed.
# Cox Regression Modelling
# 
# Kaplan-Meir tests can be satisfactory in many situations, especially during preliminary analysis; however KM test are non-parametric, and typically are less powerful than parametric equivalents. Cox Regression extends survival analysis to a parametric regression type framework under which it assumes more power. If there are several independent variables which need to be incorporated into a model, and some of them are continuous, it is advantageous to perform Cox Proportional Hazard modelling, rather than KM.
# Our first model
# Cox modelling also starts with creating as survival object as we did in the previous examples. Other than that, a Cox model looks very similar to a standard regression model with the response variables specified to the left of the ~, and the independent variables specified to the right.
# In Cox regression modelling, we use the coxph function over the surv() function to specify the dependent variable.  This can be done directly in the formula, or by assigning it to a new variable, and specifying the new variable to the left of the ~.
# Recall that in defining our original survival object we defined Xtenure2 as the time variable and Churn as the outcome of interest. In our example below, we will specify coxph(Surv(Xtenure2, Churn) as the left side of the predictive model.
# Proceed with this next part of the exercise by running the following code which will run a Cox Regression model which predicts churn using Education, Gender, Customer Satisfaction, Number of Service Calls,  Monthly Charge, and number of purchases last month as independent variables.
##?? clearhistory()
#start CoxModel.1====
rm(CoxModel.1)
ChurnStudy$SurvObj <- with(ChurnStudy, Surv(Xtenure2, Churn == 1))
CoxModel.1 <- coxph(Surv(Xtenure2, Churn) ~
                      Xeducation + Xgender + Xsatisfaction + Xservice.calls +
                      Xpurch.last.month + Xmonthly.charges,
                    data=ChurnStudy)
  
# To view the results we will use the stargazer library.  

library(stargazer)
stargazer(CoxModel.1,single.row=TRUE,multicolumn=TRUE,font.size='large',
no.space = TRUE,column.separate = c(1,2,3),
out=c("CoxModel1.html"),type='html')
browseURL("CoxModel1.html")

summary(CoxModel.1)
# Call:
# coxph(formula = Surv(Xtenure2, Churn) ~ Xeducation + Xgender + 
#     Xsatisfaction + Xservice.calls + Xpurch.last.month + Xmonthly.charges, 
#     data = ChurnStudy)
# 
#   n= 1488, number of events= 751 
# 
#                                  coef  exp(coef)   se(coef)      z Pr(>|z|)    
# XeducationDoctorate Degree -0.0067422  0.9932804  0.1568365 -0.043  0.96571    
# XeducationMaster's Degree  -0.0411774  0.9596589  0.1031115 -0.399  0.68964    
# XgenderM                    0.2809885  1.3244384  0.0954112  2.945  0.00323 ** 
# Xsatisfaction2             -0.0031029  0.9969019  0.1010203 -0.031  0.97550    
# Xsatisfaction3             -0.2305492  0.7940974  0.1240880 -1.858  0.06318 .  
# Xsatisfaction4             -0.2503191  0.7785523  0.1105464 -2.264  0.02355 *  
# Xsatisfaction5             -0.1879801  0.8286312  0.1247098 -1.507  0.13172    
# Xservice.calls              0.0303329  1.0307976  0.0336934  0.900  0.36798    
# Xpurch.last.month          -0.0160869  0.9840418  0.0243041 -0.662  0.50803    
# Xmonthly.charges            0.0082750  1.0083093  0.0003928 21.064  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Examining the Cox Regression output
# 
# Since we are essentially running an adapted logistic regression, the coefficients in a cox model are always in log form.  To transform them to a likelihood ratio you need to take the exponent. This is also part of the summary output.
# First, take a look at the value of the exponentiated coefficient, listed under the column exp(coef). Any coefficients significantly greater than 1 indicates that the customer is more likely to churn, than not.  On the other hand, exp(coef) < 1 indicate that the variable is less likely to churn.  The magnitude of the difference from 1 will indicate higher probabilities in one direction. 
# The model results indicate that Gender(Males), Satisfaction, and monthly charges are the significant variables. 
# Males and those customers with higher monthly charges have a higher prospensity to churn as indicated by their likelihood score above 1 with low p-values
# Customers with satisfaction scores of 4 have a lower propensity to churn as indicated the likelihood score below 1 with a low p-value. Even though customers with satisfaction score of 5 were not found significant, it would make sense to include them as well, since their coefficients indicate that they are likely to stay, and their p-value is somewhat low (but not significant at the .05 level).   It would also be interesting to pull these customers out separately and see if there are any other factors which lead to some of them churning.  That we indicate that an interation factor might be needed in the model.
# Proportional Hazards Test
# Some follow up tests are needed after a Cox Regression is run. One assumption of Cox Regression that needs to be tested is that the hazard for an event is purely dependent upon the variables, and not dependent upon time. If it was, time could not be treated as an independent variable. So, we need to test for what is known as ‘proportional hazards”.  This can be done using the cox.zph function.
# Run the portion of the code below which is listed under the label #coxproptext====
# It will:
# •	Assign the output of the proportional hazard test to the temp object 
# •	Print the results of the test to the console
# •	Loop through all of the model variables contained in the temp object and plot the proportional hazards

#coxproptext====
#test for proportional hazards
temp <- cox.zph(CoxModel.1, transform = 'log')
print(temp)
par(mfrow=c(2,5))
for (i in 1:10){
plot(temp[i])
}
dev.copy(jpeg,'Ch5 - Coxmodel1 zph.jpg');
dev.off()
savehistory (file="Ch5 CoxModel zph.txt")

# First look at the output of the print(temp) command. 
print(temp)
summary(survfit(CoxModel.1))
# Call: survfit(formula = CoxModel.1)
# 
#  time n.risk n.event survival std.err lower 95% CI upper 95% CI
#     1   1488      15    0.993 0.00185        0.989        0.996
#     2   1455      52    0.967 0.00404        0.960        0.975
#     3   1393      34    0.950 0.00505        0.940        0.960
#     4   1342      20    0.940 0.00559        0.929        0.951
#     5   1315      39    0.919 0.00655        0.906        0.932
#     6   1245      42    0.896 0.00752        0.881        0.911
#     7   1156      60    0.861 0.00884        0.844        0.879
#     8   1020      68    0.818 0.01033        0.798        0.838
#     9    850      89    0.754 0.01233        0.731        0.779
#    10    665     115    0.657 0.01500        0.628        0.687
#    11    435     105    0.536 0.01789        0.502        0.572
#    12    225     112    0.278 0.02226        0.237        0.325
# 
# Plotting the curve
# The curve can be plotted using the generic plot function

plot(survfit(CoxModel.1),col=c('red','blue') ,lty=1,xlab="Months", ylab="Hazard")
title(main = "Model Survival Curve")
dev.copy(jpeg,'Ch5 - Coxmodel1 plot.jpg'); dev.off()



# You can also plot a prettier version of the curve using ggplot and ggfortify
library(ggplot2)
library(ggfortify)

autoplot(survfit(CoxModel.1), surv.linetype = 'dashed', surv.colour = 'blue',
         conf.int.fill = 'dodgerblue3', conf.int.alpha = 0.5, censor = FALSE)

# Here is a side by side comparison of the curves produced by the native plot function (left plot), and autoplot functions (right plot) described above. The major difference is that the shaded bands replace the confidence interval dotted lines
# 
# 
# 
# 
# 
# 
# 
#  
# Image B05033_05_14.png
# Partial Regression Plots
# 
# Partial Regression plots are useful in regression to observe the effect of the individual variables independently of the other variables. Use the termplot() function to view the variables in the model separately. The termplot curves roughly correspond to the slopes of the regression line, so you can visually observe the effect of each variable as the levels or continuous values change. 
# For the regression that we just ran, Males, Satisfaction levels 3 and 4, and Monthly Charges are all starred as significant in the regression output, so we can observe their individual slopes by looking at the plots.
# The code below will loop through all the variables in the model, and produce the plots below. The 6th term (Monthly Charges), which is a continuous variable, is produced with standard error bars.  Notice the increasing variance as the monthly charges increase.

par(mfrow=c(3,3))
for(i in 1:5) termplot(CoxModel.1,term=i,col.se='grey',se=TRUE,partial.resid =FALSE,smooth=panel.smooth)
termplot(CoxModel.1,term=6,col.se='grey',se=TRUE,partial.resid =TRUE,smooth=panel.smooth)
dev.copy(jpeg,'Ch5 - Coxmodel1 termplot.jpg'); 
dev.off()

# Each termplot call produces the following 3 plots in a 3*3 matrix format as defined by the supplied mfrow specification
#  
# Insert Image B05033_05_15.jpeg
# Examining subset survival curves
# As we did with the Kaplan-Meir curves above, we can also produce separate plots for subsets of the data. We will do this by applying the regression coefficients we obtained above to subsets of the data with each subset containing an approximately equal number of rows.  That way we will be able to compare the density across groups.  
# •	In the following code we will first subset our original dataset (ChurnStudy) by gender level
# •	Then we will score the new subsets by applying the coefficients of CoxModel.1
# •	We will then reduce the density of the plots by sampling 300 observations each from the Males and Females subsets
# •	Finally we will plot the results
# Run the following code to produce some interesting subsets of the survival curves.

par(mfrow=c(1,2))
#
males <-subset(ChurnStudy,Xgender=='M')
males.nrow <- nrow(males)
females <-subset(ChurnStudy,Xgender=='F')
nrow(females)
females.fit <- survfit(CoxModel.1, newdata=females)
plot(females.fit,col=c('blue') ,lty=1,xlab="Months", ylab="Hazard")
title(main = "Females Survival Curve")
mtext(paste("Observations=",nrow(females)),side=3,line=0,adj=1,cex=1)
#
males.fit <- survfit(CoxModel.1, newdata=males)
plot(males.fit,col=c('red') ,lty=1,xlab="Months", ylab="Hazard")
title(main = "Males Survival Curve")
mtext(paste("Observations=",nrow(males)),side=3,line=0,adj=1,cex=1)
#
par(mfrow=c(1,2))
#
#sample the males population
#
males.sample <- sample(males)[1:300,]
males.sample.fit <- survfit(CoxModel.1, newdata=males.sample)
plot(males.sample.fit,col=c('orange') ,lty=1,xlab="Months", ylab="Hazard")
title(main = "Males (Sample) Survival Curve")
mtext(paste("Observations=",nrow(males.sample.fit)),side=3,line=0,adj=1,cex=1)
#
#sample the females population
#
females.sample <- sample(females)[1:300,]
females.sample.fit <- survfit(CoxModel.1, newdata=females.sample)
plot(females.sample.fit,col=c('red') ,lty=1,xlab="Months", ylab="Hazard")
title(main = "FeMales (Sample) Survival Curve")
mtext(paste("Observations=",nrow(females.sample.fit)),side=3,line=0,adj=1,cex=1)
#
dev.copy(jpeg,'Ch5 - CoxModel1 Gender.jpg'); 
dev.off()
sat.fit.low <- survfit(CoxModel.1, newdata=subset(ChurnStudy[1:300,],as.integer(Xsatisfaction) == 1))
plot(sat.fit.low,col=c('red') ,lty=1,xlab="Months", ylab="Hazard")
title(main = "Sat (Lowest) Survival")
#
sat.fit.high <- survfit(CoxModel.1, newdata=subset(ChurnStudy[1:300,],as.integer(Xsatisfaction) == 5))
plot(sat.fit.high,col=c('blue') ,lty=1,xlab="Months", ylab="Hazard")
title(main = "sat (Highest) Survival")
dev.copy(jpeg,'Ch5 - CoxModel1 sat.jpg'); 
dev.off()
savehistory (file="Ch5 CoxModel Contrast Curves.txt")


# Comparing Gender differences
# In the comparison of Males (Left plot) with Females (Right Plot) we can see that there is slightly more density in the upper left quadrant for Males than there are for Females. This supports the hypothesis that the Males will churn earlier.
# 
# 
#  
# B05033_05_16.png
# 
# Comparing Customer Satisfaction Differences
# First extract a sample for the highest and lowest satisfaction scores   Satisfaction=1 indicates more early churners than Satisfaction=5, due to the density of the points.

sat.fit.low <- survfit(CoxModel.1, newdata=subset(ChurnStudy[1:300,],as.integer(Xsatisfaction) == 1))
plot(sat.fit.low,col=c('red') ,lty=1,xlab="Months", ylab="Hazard")

title(main = "Sat (Lowest) Survival")
#
sat.fit.high <- survfit(CoxModel.1, newdata=subset(ChurnStudy[1:300,],as.integer(Xsatisfaction) == 5))
plot(sat.fit.high,col=c('blue') ,lty=1,xlab="Months", ylab="Hazard")
title(main = "sat (Highest) Survival")
dev.copy(jpeg,'Ch5 - CoxModel1 sat.jpg'); 
dev.off()

# Here is the side by side comparison of the highest and lowest satisfaction scores
#  
# 
# 
# 
# Validating the Model
# Earlier we create the testing data set ChurnStudy.test and did not use it to train our Cox Regression Model. After we created it, we just put it off to the side. We will demonstrate one way to use this hold out data set to validate the training results obtained from CoxModel.1
# Locate the #predict=== label and run the following code:
#predict====
par(mfrow=c(1,1))
#

# Compute Baseline Estimates
# We will first determine the baseline (or average) estimates for the regression model we have just run, using the basehaz() function. We will assign it to an object named base, and then we will print and plot it.
#Let's start by looking at the baseline estimates for each time period.
#
base <- basehaz(CoxModel.1)
print(base)


# > print(base)
#         hazard time
# 1  0.007174321    1
# 2  0.033151848    2
# 3  0.051088747    3
# 4  0.062057960    4
# 5  0.084305023    5
# 6  0.109773610    6
# 7  0.149493300    7
# 8  0.200891166    8
# 9  0.281904190    9
# 10 0.420681696   10
# 11 0.623702585   11
# 12 1.281690658   12
# 
# Recall that the hazard is the likelihood that an event(Churn) will happen, given that it hasn't already happened.  This terminology is slightly different from the term survival rate, which we originally discussed, which is the percentage of the population in which the event did NOT happen.
# We can see that the likelihood of churn always increases as time progress.
# Churn seems to increase linearly until month 7 or 8, and then begins to increase exponentially with the greatest churn at the end of 12 months.  This could occur as customers begin to approach the end of any contract which is in place.
# 
# 
# 
# 
# 
# 
# 
# 
# 
# Plot the baseline hazard. for each time period.
ggplot(base, aes(base$time, base$hazard)) + geom_bar(stat = "identity",fill='blue') +
  ggtitle("Churn Baseline Hazard by Time") +
  labs(x="Month",y="Hazard")
dev.copy(jpeg,'Ch5 - baseline hazard.jpg');
dev.off()


 
# Insert Image B05033_05_18.png
# 
# Running the predict() function
# Next, we will use the predict() function to score the test data in ChurnStudy.test, based upon the prediction model trained on ChurnStudy. ‘Newdata=’ designates the new data set to be stored.  ‘Lp’ is one of several types used for prediction, and this method uses the linear predictor.
pred_validation <- predict(CoxModel.1, newdata=ChurnStudy.test, type='lp')

# The resulting predictions will be in log form.
# Predicting the outcome at time 6 
#the predictions are in log form. Take the exponent and multiply by the base hazard estimate
#to obtain the predicted value at 6 months.
#
head(pred_validation)
#	
pred.val <- base[6,1]*exp(pred_validation)

# Let’s assume we want to predict the risk of churn which occurs halfway thru the analysis period (time=6).
# •	First, we will first take the exponents of the prediction and multiply them by the base hazard estimate which was shown in the ‘hazard’ column at time=6 above. This method in effect adds the predictive power of the coefficients to the base hazard rate.

pred.val <- base[6,1]*exp(pred_validation)


# We will now merge the predicted values in with the raw values from the test dataset and view the results after verifying that the number of rows what we expect.

combine <- cbind(ChurnStudy.test,pred_validation,pred.val)
nrow(combine)
# [1] 496
View(combine)

# The View function opens up the dataframe so that it can be examined.
# 
#  
# B05033_05_19.png
# Look at the last column which contains the prediction. The prediction is essentially a risk score which ranges from 0 to 1.
# Examine the predicted value (pred_val) with the actual Churn output (Churn) to get an idea of how the predicted values vary with the outcomes.  Also examine the relationship between the independent variables and the predicted values. For example, you can see within the first few rows that the churn=1 event contains a much higher monthly charge than the other surrounding rows.
# To see the difference in the average scores between the churners and non-churners we can take some mean aggregate functions and print the results.  After running the code below, we can see  difference between  the churners (who have higher risk scores) and the non-churners.
y <- aggregate(combine$pred.val, by=list(combine$Churn),FUN=mean, na.rm=TRUE)
print(y)
# > print(y)
#   Group.1         x
# 1       0 0.0646759
# 2       1 0.2326843
# 
# 
# 
# 
# Determine concordance
# A concordance index is another measure which is used in survival analysis to determine how well the model is able to discern between the observed and predicted responses.  For our churn example, we would expect the churners to have higher hazard rates than those customers who remain active.  If the concordance index is above .5, that indicates that there is some predictive ability built into the model.
# To compute the index we will use the concordance.index function from the survcomp package to measure the agreement of the pred_validation statistic, with the actual churn outcome.  
# 
#  As in previous examples, one needs to supply the predictions, time variable, and event variable as arguments to the function. We will also print the associated confidence intervals.
library(survcomp)

cindex_validation = concordance.index (pred_validation, surv.time = ChurnStudy.test$XTenure2,
                                       surv.event=ChurnStudy.test$Churn)
#
print(cindex_validation$c.index)
print(cindex_validation$upper)
print(cindex_validation$lower)


# For our example the computed index is 70%, with confidence intervals showing that it can range between 60 and 77%.
# 
# > print(cindex_validation$c.index)
# [1] 0.6973212
# > print(cindex_validation$upper)
# [1] 0.7736508
# > print(cindex_validation$lower)
# [1] 0.6082843
# 
# 
# 
# 
# 
# Time Based Variables
# 
# Up until now, we have treated all of our variables as static, i.e. they maintained their original values measured from the beginning of the measurement period.  
# In reality,values (such as Age, Marital Status etc.) change over time, and these changes can be accounted for by the model.  In the marketing context, surveys might be administered after the study has begin.  Based upon changes in some of these variables, coupons, and other incentives might be offered (“interventions”), for the purpose of changing customer behaviour.  In the model, these interventions can also be accounted for.
# In our example, we will introduce a hypothetical 2nd survey which was introduced 6 months into the measurement period which measured the effect of treating some of the unsatisfied customers.
# Changing the data to reflect the 2nd Survey
# 
# The following code uses the survSplit function to create a new record a time period 6 which will reflect the response to a 2nd hypothetical customer survey administered at that time.
# Copy the following code and run it in a new script window. 
ChurnStudy.save <- ChurnStudy
ChurnStudy$seqid <- seq(1:nrow(ChurnStudy))
View(ChurnStudy)
View(subset(ChurnStudy, select = c(seqid,Xtenure2,Xsatisfaction, Xsatisfaction2, Churn)))

library(survival)
SURV2 <- survSplit(data = ChurnStudy, id="ID.char", cut = 6, end = "Xtenure2",  start = "time0", event = "Churn", episode="period")
SURV2$CustomerID <- as.integer(SURV2$ID.char)

SURV2 <- SURV2[order(SURV2$CustomerID),]

View(subset(SURV2, select = c(CustomerID,time0,period, Xsatisfaction, Xsatisfaction2, Xtenure2, Xmonthly.charges, Churn)))

# How survSplit works
# 
# We will look a bit closer at the survSplit function and how it affects the change of the satisfaction variable.  Since we need to keep track of how customer satisfaction changed at time period 6,  survSplit will alter the dataframe by creating new rows and  and adjusting the time periods to reflect the change in customer satisfaction. In our example that means that the function would create additional rows after the 6 months cutoff  (cut=6), based upon the values of Xtenure2
# As an example of how this would work, first look at the original ChurnStudy dataframe, and observe the very first record has a Tenure of 12 months. This customer would have been around enough for a 2nd survey.
#ChurnStudy$seqid <- seq(1:nrow(ChurnStudy))

# Now look at the output produced by Survsplit.  You can see that the first record (CustomerID=1) has been split into 2 records. One record starting from the first month that the member was active (time0=0), and the 2nd record from the 6th month onward (time 0=6). 
# On the other hand, CustomerID=2 only has 1 record, since the member was only around for 5 months, which is less than the cut=6 cutoff.
View(SURV2)
str(SURV2)
str(ChurnStudy)
View(subset(SURV2, select = c(CustomerID,time0,period, Xsatisfaction, Xsatisfaction2, Xmonthly.charges, Churn)))


# At this point, nothing has really changed analytically.  There have been 2 records created with the exact some information, except that one record shows the information as it exists at the end of period 6, and the other the information at the end of period 12.  
# We can see how months 1-12 align with the periods by running a simple crosstab.
table(SURV2$period,SURV2$Xtenure2)
#    
#        1    2    3    4    5    6    7    8    9   10   11   12
#   0   33   62   51   27   70 1245    0    0    0    0    0    0
#   1    0    0    0    0    0    0  136  170  185  230  210  225
# Adjust records to simulate an intervention
# Now that we have multiple records, we will be able to adjust for the new survey information which changed after month 6, and include that as a time dependent variable.
# Recall that we initially simulated the 2nd survey data for the churners by increasing the satisfaction rating by 1 (Xsatisfaction2).  This resulted in some satisfaction scores of “6” for some members, which would be impossible. So we will first clean those of by setting the “6” ratings to “5”.
# #fix up some “6” satisfaction scores, that are not possible, and make them “5”
SURV2$Xsatisfaction2 <- as.factor(ifelse(SURV2$Xsatisfaction2=="6","5",SURV2$Xsatisfaction2))

# Assume that at month 5 there was a promotion targeted to those members who gave low satisfaction ratings (1 or 2) in the initial survey. This resulting in an increased satisfaction score for some members who would have churned.
# We will simulate a positive response to the survey by upgrading their satisfaction score (Xsatisfaction2) for those that churned from 1 or 2, to 3.  This is to simulate a slight increase in satisfactions. This is only performed for period=1, which is the period following the survey.  Technically, this is the period assigned by survSplit after the cut (Period 1).  Period 0 is the period before the cut. 
# 
# #an intervention increased low satisfaction scores to “Average”.
SURV2$Xsatisfaction2 <- ifelse(SURV2$period==1 & SURV2$Churn==1 & SURV2$Xsatisfaction %in% c("1","2"),"3",SURV2$Xsatisfaction)

# We will also simulate the change in retention status by for these survey2 customers by changing Churn status from 1 (left) to 0 (retained), indicating that the promotion had enough of an effect to keep them from leaving.

#Simulate retaining these customers by changing their status to active
#change is detected when the new score is higher than the old score
SURV2$Churn2 <-ifelse(SURV2$period==1 & SURV2$Churn==1 &
                        (as.integer(SURV2$Xsatisfaction2) > as.integer(SURV2$Xsatisfaction)),
                      0, SURV2$Churn)
SURV2$ChurnChanged <- ifelse(SURV2$Churn==SURV2$Churn2,'N','Y')



nrow(ChurnStudy)
# [1] 1984
nrow(SURV2)
# [1] 3512

# Now, sort the dataframe by id, and view the results.  Records that have multiple id’s have been split by the algorithm.
attach(SURV2)
tmp <- SURV2[order(CustomerID),]
str(tmp)
tmp2 <- subset(tmp, select = c(CustomerID,ChurnChanged,time0,period, Xsatisfaction, Xsatisfaction2, Churn,Churn2))
View(tmp2)

 

# Observe that any customer who has had a tenure of more that 6 months has also had an additional record added.  This additional record reflects the customers updated status and  updates the value of variables which have changed.  
# In this case we have performed one cut at 6 months.  The data also includes 2 new variables ‘time0’ which designates the starting period, and an episode variable, which we named ‘period’, which is incremented sequentially for every time based change in a variable.  We only showed an example with one change in a time based variable.  For longer observation periods you can have many more changes.
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# Running the time-based model
# Now that we have reformatted the data, we already ready to run the 2nd time-based model.
# CoxModel.2 is created in a similar fashion as CoxModel.1, however Xsatisfaction2 is substituted for Xsatisfaction to account for the change in satisfaction due to the follow up study.  The new variable time0 is also substituted for the original Tenure variable, and Churn2 is substituted for the original Churn response variable.
CoxModel.2 <- coxph(Surv(time0,Xtenure2, Churn2) ~
                      Xeducation + Xgender + Xsatisfaction2 + Xservice.calls +
                      Xpurch.last.month + Xmonthly.charges,
                    data=SURV2)


# Avoid overwriting existing variable names. Either create new variables within an existing dataframe or preserve the old one and create a new frame.
# 
# 
# After the model is run, we can use the stargazer command (or summary(CoxModel.2) to view the model output.
# The asterisks after Gender, Satisfaction, and Monthly charges indicate that they are the most significant variables in the model.
# The R-Square of .13 is not a standard linear regression type measure, but is a ‘pseudo-rsquare’ measure that we discussed earlier which is a number between 0 and one that measures the difference between the fitted model and a NULL model.  If you are curious to see how this particular pseudo R-squared is calculated for a Cox Regression, you can issue the following command. 
getS3method("summary","coxph")
# However it is not as high as the original CoxModel.1  This is possibly due to the artificial changing of the data. In any case, it is not a good idea to rely on a single measure, and we will see shortly how the model does improve the retention.

library(stargazer)
stargazer(CoxModel.2,single.row=TRUE,type='text')
# 
# ======================================================
#                                Dependent variable:    
#                            ---------------------------
#                                       time0           
# ------------------------------------------------------
# XeducationDoctorate Degree       -0.159 (0.206)       
# XeducationMaster's Degree        -0.198 (0.136)       
# XgenderM                          0.091 (0.115)       
# Xsatisfaction22                   0.157 (0.197)       
# Xsatisfaction23                 -0.596*** (0.197)     
# Xsatisfaction24                 0.522*** (0.176)      
# Xsatisfaction25                 0.585*** (0.184)      
# Xservice.calls                    0.013 (0.044)       
# Xpurch.last.month                -0.007 (0.029)       
# Xmonthly.charges                0.009*** (0.001)      
# ------------------------------------------------------
# Observations                          2,644           
# R2                                    0.134           
# Max. Possible R2                      0.901           
# Log Likelihood                     -2,868.889         
# Wald Test                     370.360*** (df = 10)    
# LR Test                       380.183*** (df = 10)    
# Score (Logrank) Test          399.088*** (df = 10)    
# ======================================================
# Note:                      *p<0.1; **p<0.05; ***p<0.01
# 
# Let’s start by generating  another survival curve

par(mfrow=c(1,1))
autoplot(survfit(CoxModel.1), surv.linetype = 'dashed', surv.colour = 'blue',
         conf.int.fill = 'dodgerblue3', conf.int.alpha = 0.5, censor = FALSE)
dev.copy(jpeg,'Ch5 - time based variable 1.jpg'); 
dev.off()

autoplot(survfit(CoxModel.2), surv.linetype = 'dashed', surv.colour = 'red',
         conf.int.fill = 'orange', conf.int.alpha = 0.5, censor = FALSE)
dev.copy(jpeg,'Ch5 - time based variable 2.jpg'); 
dev.off()
savehistory (file="Ch5 time based variable.txt")
 

# Here are the original (left plot), and time based survival plot side by side.
#  
# B05033_05_20.png
# 


summary(survfit(CoxModel.2))
# Call: survfit(formula = CoxModel.2)
# v
#  time n.risk n.event survival std.err lower 95% CI upper 95% CI
#     1   1488      15    0.994 0.00157        0.991        0.997
#     2   1455      52    0.973 0.00359        0.966        0.980
#     3   1393      34    0.958 0.00461        0.949        0.967
#     4   1342      20    0.950 0.00518        0.940        0.960
#     5   1315      39    0.932 0.00624        0.920        0.945
#     6   1245      42    0.913 0.00736        0.898        0.927
#     7   1156      24    0.898 0.00801        0.883        0.914
#     8   1020      32    0.877 0.00902        0.859        0.895
#     9    850      40    0.846 0.01052        0.825        0.866
#    10    665      51    0.797 0.01293        0.772        0.822
#    11    435      54    0.721 0.01688        0.688        0.755
#    12    225      55    0.569 0.02518        0.522        0.621
summary(survfit(CoxModel.1))
# Call: survfit(formula = CoxModel.1)
# 
#  time n.risk n.event survival std.err lower 95% CI upper 95% CI
#     1   1488      15    0.993 0.00185        0.989        s0.996
#     2   1455      52    0.967 0.00404        0.960        0.975
#     3   1393      34    0.950 0.00505        0.940        0.960
#     4   1342      20    0.940 0.00559        0.929        0.951
#     5   1315      39    0.919 0.00655        0.906        0.932
#     6   1245      42    0.896 0.00752        0.881        0.911
#     7   1156      60    0.861 0.00884        0.844        0.879
#     8   1020      68    0.818 0.01033        0.798        0.838
#     9    850      89    0.754 0.01233        0.731        0.779
#    10    665     115    0.657 0.01500        0.628        0.687
#    11    435     105    0.536 0.01789        0.502        0.572
#    12    225     112    0.278 0.02226        0.237        0.325
# 
#  
# Variable Selection
# The model we just worked with had a limited number of variables, so mechanical variable selection methods when dealing with a large number of variables was not really that pertainant. We were able to pinpoint the important ones via the regression model. However for a model with a large number of variables we could use the glmulti package for the purpose of performing variable selection.  
# For the churn example which was generated, we have a small number of variables, so it is easy to demonstrate a variable selection, and not so time consuming.
# In the code below we will set the maximum number of terms to include in the best regression to 10, in order to limit the computational time needed to perform an exhaustive search. We will also use the genetic algorithm option (method=’g’) which can be much faster with larger datasets, since it only considers the best subsets of all of the combinations.  
# If you wish to perform an exhaustive search use method=’’h’.  However, be forewarned, this may tie up your machine for a very long time.
# •	Run the code below to begin the variable selection process:

library(glmulti)
glmulti.coxph.out <-
  glmulti(Surv(Xtenure2, Churn) ~ Xeducation + Xgender + Xsatisfaction + Xservice.calls +
            Xpurch.last.month + Xmonthly.charges, data = ChurnStudy,
          maxsize=10,
       
          level = 2,               # interaction considered
          method = "g",            # Genetic Algorithm
          crit = "aic",            # AIC as criteria
          confsetsize = 5,         # Keep 5 best models
          plotty = T, report = F,  # produce AIC plot
          fitfunction = "coxph")   # coxph function

# •	You will receive the message below in the console when the algorithm has completed.  It should complete in 5 minutes or less.  
# TASK: Genetic algorithm in the candidate set.
# Initialization...
# Algorithm started...
# Improvements in best and average IC have bebingo en below the specified goals.
# Algorithm is declared to have converged.
# Completed.
# 
# •	Print a summary of the output object. The summary includes the best model found from the candidate set.  Notice that the best model does not include  the Education variable.  print(glmulti.coxph.out)

print(glmulti.coxph.out)
# glmulti.analysis
# Method: g / Fitting: coxph / IC used: aic
# Level: 2 / Marginality: FALSE
# From 5 models:
# Best IC: 9213.65479049829
# Best model:
# [1] "Surv(Xtenure2, Churn) ~ 1 + Xsatisfaction + Xservice.calls + "                 
# [2] "    Xpurch.last.month + Xmonthly.charges + Xpurch.last.month:Xservice.calls + "
# [3] "    Xmonthly.charges:Xservice.calls + Xmonthly.charges:Xpurch.last.month + "   
# [4] "    Xgender:Xpurch.last.month + Xsatisfaction:Xpurch.last.month + "            
# [5] "    Xsatisfaction:Xmonthly.charges"                                            
# Evidence weight: 0.448302183864995
# Worst IC: 9223.12072581434
# 3 models within 2 IC units.
# 2 models to reach 95% of evidence weight.
# Convergence after 150 generations.
# Time elapsed: 1.0830335299174 minutes.
# 
# •	
# •	
# •	
# •	Since we specified that interactions should be considered in the model, the algorithm has found several interactions that should be looked at for further model improvement, List of interactions found in the model
# 
# Xpurch.last.month:Xservice.calls
# Xmonthly.charges:Xservice.calls 
# Xmonthly.charges:Xpurch.last.month   
# Xgender:Xpurch.last.month 
# Xsatisfaction:Xpurch.last.month            
# Xsatisfaction:Xmonthly.charges
# 
# •	Two important ones would be one which relates gender with the number of purchases last month, and the interaction which relates satisfaction and monthly charges.  Both of these interactions are specified in the ‘best model’ shown above.
# 
# Incorporating Interaction Terms
# To incorporate these interaction in a future model we specify them directly in the ‘right side’ of the model formula. For example this specification includes Service calls, as well as the interaction between Service calls and the number of purchases last month, as model terms:

CoxModel.2 <- coxph(Surv(time0,Xtenure2, Churn2) ~
                      Xeducation + Xgender + Xsatisfaction2 + Xservice.calls + Xpurch.last.month:Xservice.calls +
                      Xpurch.last.month + Xmonthly.charges,
                    data=SURV2)

glmulti.coxph.out@formulas
# [[1]]
# Surv(Xtenure2, Churn) ~ 1 + Xsatisfaction + Xservice.calls + 
#     Xpurch.last.month + Xmonthly.charges + Xpurch.last.month:Xservice.calls + 
#     Xmonthly.charges:Xservice.calls + Xmonthly.charges:Xpurch.last.month + 
#     Xgender:Xpurch.last.month + Xsatisfaction:Xpurch.last.month + 
#     Xsatisfaction:Xmonthly.charges
# <environment: 0x00000000160ee2e8>
# 
# [[2]]
# Surv(Xtenure2, Churn) ~ 1 + Xgender + Xsatisfaction + Xservice.calls + 
#     Xpurch.last.month + Xmonthly.charges + Xpurch.last.month:Xservice.calls + 
#     Xmonthly.charges:Xservice.calls + Xmonthly.charges:Xpurch.last.month + 
#     Xsatisfaction:Xpurch.last.month + Xsatisfaction:Xmonthly.charges
# <environment: 0x00000000160ee2e8>
# 
# [[3]]
# Surv(Xtenure2, Churn) ~ 1 + Xsatisfaction + Xselirvice.calls + 
#     Xpurch.last.month + Xmonthly.charges + Xpurch.last.month:Xservice.calls + 
#     Xmonthly.charges:Xservice.calls + Xmonthly.charges:Xpurch.last.month + 
#     Xgender:Xpurch.last.month + Xsatisfaction:Xmonthly.charges
# <environment: 0x00000000160ee2e8>
# 
# [[4]]
# Surv(Xtenure2, Churn) ~ 1 + Xsatisfaction + Xservice.calls + 
#     Xpurch.last.month + Xmonthly.charges + Xmonthly.charges:Xservice.calls + 
#     Xmonthly.charges:Xpurch.last.month + Xgender:Xpurch.last.month + 
#     Xsatisfaction:Xpurch.last.month + Xsatisfaction:Xmonthly.charges
# <environment: 0x00000000160ee2e8>
# 
# [[5]]
# Surv(Xtenure2, Churn) ~ 1 + Xgender + Xsatisfaction + Xservice.calls + 
#     Xpurch.last.month + Xmonthly.charges + Xpurch.last.month:Xservice.calls + 
#     Xmonthly.charges:Xservice.calls + Xgender:Xpurch.last.month + 
#     Xsatisfaction:Xservice.calls + Xsatisfaction:Xmonthly.charges
# <environment: 0x00000000160ee2e8>
# 
# Comparing AIC among the candidate models
# 
# As mentioned in earlier chapters, AIC is a metric that you can use to help you select a model. The plotty=’T’ option  also produced a plot of the AIC’s for the top models found. In the function call we indicate that we wanted to see up to 5.
# According to the author of the package, a reasonable rule of thumb is to consider models which fall below the horizontal red line.
#  According to that definitions, that would eliminate models 4 and 5, and leave models 1, 2, and 3 to consider.
# Here is the plot of the AIC’s for the top 5 models.
# 
# 
# B05033_05_21.png
# We can also specify a ‘variable importance’ plot by using the plot statement with type=’s’

plot(glmulti.coxph.out,type = "s")
# This plot gives a nice simple horizontal barchart ordered by the most important features. 
# 
# B05033_05_22.png
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# Summary
# In this chapter we learned about what survival analysis is, and how two main techniques, Kaplan-Meir and Cox Regression can be used to explain and predict customer churn.
# We also learned how we can generate our own data, to test assumptions and test the robustness of the models.
# Finally, we included some coding techniques to help us reproduce and save our generated code and images.
# In the next chapter we will not be concerned with a customer leaving, but will cover how to keep customers happy by predicting what they will purchase next using a technique known as Market Basket Analysis.




