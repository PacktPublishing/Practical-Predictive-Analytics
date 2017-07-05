# 2[GG[1]
# The Modelling Process
# Remember that all models are wrong; the practical question is how wrong do they have to be to not be useful.
# —George Edward Pelham Box
# Today, we are at a juncture in which many different types of skill sets are needed to participate in predictive analytics projects. Once, this was the pure domain of the statistician, programmer, and business analyst.  Now, the roles have expanded to include visualization experts, data storage experts, and other types of specialists. Yet, so many are unfamiliar with an understanding of how predictive analytics projects can be structured. This lack of structure can be inhibited by several factors. Often there is a lack of understanding the critical parts of a business problem, and a model is developed much too early. Or a formal methodology may be pushed off to the future, in favor of a quick solution.
# In this chapter, we will be start by discussing the advantages of using “Structured Analytics Methodologies”.  Methodologies are a great way to demonstrate value to upper management, and groups or individuals advocating for a structured approach is one way to obtain ‘buy-in’ from management. If the project gain acceptance using a methodology, there is a strong possibility that future projects will have support. 
# We will cover the following points in this chapter:
# * Advantages of a structured methodology
# * Analytic process methodologies
# * Outline of the specific steps used within an analytics process methodology[GG[2]
# * Short descriptions of specific analytic techniques, with code examples
# Advantages of a structured approach
# Analytic projects have many components. That is where a structured methodology can help. Many benefits can be gained if there is a structure which is placed upon discovery and analysis, rather than on only the pure model building.  The discovery and insight gained will certainly be utilized past the original intent of the problem.  
# We assume that the quick-thinking "hare brain" will beat out the slower Intuition of the "tortoise mind." However, now research in cognitive science is changing this understanding of the human mind. It suggests that patience and confusion--rather than rigor and certainty--are the essential precursors of wisdom. – Guy Claxton[GG[3]
# Ways in which structured methodologies can help
# Here are several points to bear in mind concerning the advantages of structured methodologies:
# * Data is coming at us fast and furious.  We need to keep track of the many data sources, evaluate which ones are the best ones to use at any given time, and continually monitor them for data accuracy. Expect changes to come quicker than expected. Predictive modelers need a structured methodology to be able to keep track of things; changes can be disruptive in whatever stage of the modeling process they are in.
# * The difference between useful data and “data masquerading as useful data” is increasing. Structured methodologies help with maintaining metadata repositories for information which can help in determining what data is useful, and what is not.
# * The number of data analysis techniques are increasing. Knowing which analytical techniques to choose can be a daunting task. Dedicating projects purely for evaluating which data techniques are more useful than others for a particular business problem is a laudable goal.
# * Structured methodologies help with objectivity – Everyone has their own subjective technical biases that they bring to the table.  Creating a structured way for sharing code and results can encourage out-of-the box thinking.
# * Incremental Improvement – Often projects are too large or ambitious. Projects can be organized in a way which offers small ways to provide value.  This is easier to attain when projects are encapsulated within a structured methodology
# * Iterative -  Structured techniques enforces good data analytics practice such as being able to iterate in small steps.  If any discrepancies are found later on, it is relatively easy to backtrack thru the incremental updates.
# * Divide and Conquer - This helps to organize projects and has multiple team members work on different parts of project
# * Reproducibility – This helps analytic teams reproduce the same results again and again.  This has always been important in research, but also has implications for any large-scale data project, in which you can be dealing with a multitude of data raw sources. Often, one needs help with transformed data sources in which business rule transformations are unclear and can be changed without your knowledge. Certainly, this is also important when implementing version control, but this is also important when you are upgrading packages and need to recreate results. When data sampling is involved, it also may be possible that the original selection criteria which produced the sample [GG[4]is no longer available, and that reproducibility may be lost.  Therefore, it is important to develop sample strategies in a structured way, which are robust and can be reproduced with future analyses.
# Analytic process methodologies 
# There are several analytic processes methodologies which are currently practiced, however I will be discussing only 2 longstanding [GG[5]methodologies that have been in existence for a while, CRISP-DM and SEMMA, which can help you organize your journey from problem definition to insight.  
# CRISP-DM and SEMMA 
# 
# CRISP-DM (Cross-Industry Standard process for Data Mining) and SEMMA (Sample, Explore, Modify, Model, and Assess) [GG[6]are 2 standard data mining methodologies that have been utilized for many years and describe a general methodology for implementing analytics projects. There is a good deal of overlap between the methodologies, even though the names for each step are different. All of the listed steps are important to the success of a predictive analytics project.  However, tt is not necessary that these steps be followed exactly in order.  The concepts outlined are more or less an outline of best practices.  It helps to be aware of the importance of each of these steps, and understand how each step is built upon the knowledge of the previous ones.
# Although these steps are listed in sequence for reference, [GG[7][rw8][rw9]you will discover that in practice, they are more iterative and that you will often be cycling back to a previous step. This often happens when you discover information which is in conflict with what you have previously discovered:
# As an example: many times you believe that you have been finished with the Data Preparation stage, only to find during the Modelling stage you have discover a glitch in the data collection, and that you need to perform more data prep to accommodate certain conditions.  Solution: Cycle back, but keep your placeholder, and see how you can advance your modelling while bearing in mind that your data will be replaced or augmented.  Sometime this can be tough to do, but it happens a lot.
# 
# CRISP-DM and SEMMA Chart
# If you examine the differences between SEMMA and CRISP_DM in the chart below you will notice that Steps #2-5 are similar in approach. 
# Note that SEMMA adds Sampling as an initial phase and CRISP-DM begins with Business Understanding, and ends with Model deployment.  
# 
# 
# Step #
# CRISP-DM
# SEMMA
# 1
# Business Understanding
# 
# Sample
# 2
# Data Understanding	
# 
# Explore
# 3
# Data Preparation
# 
# Modify
# 4
# Modeling
# 
# Model
# 5
# Evaluation
# 
# Assess
# 6
# Deployment
# 
# 
# 
# Critical to both processes is the concept of visualizing and communicating results to stakeholders. Note that visualization is not considered a separate step. Always try to include a Presentation Layer (plot, charts, visualizations) within each of the steps, so that communications between all of the predictive analytics stakeholders are facilitated.  
# Agile Processes
# Since developing a predictive model is iterative, agile approaches like Scrum, and Kanban work well within a structured framework, especially when it is tied to product delivery.  However Knowledge Discovery, Proof of Concept, and model incremental change improvements benefit from an agile approach. When used as part of the Business Understanding process, these techniques can also be useful in grouping lists of questions into an Agile Backlog which can then be incorporated in sprints. 
# Six Sigma and Root cause 
# Six Sigma has been around for a long time and associated with process improvement. As a result, it has developed its own set of methodologies and techniques which deal with examining business problems and their solutions. A knowledge of basic statistical techniques is useful. Often root cause analysis is a good course to follow with respect to Data Quality Issues.  For example, data can be passed along through multiple internal and external systems and be subject to many manual updates and system glitches and failures. In complex systems, it is often unclear where the errors occur. Six Sigma can also be used to examine some causal relationships using some very simple techniques such as the “5 Why’s”  (Determine the Root Cause: 5 Whys, n.d.)
# To Sample or not to Sample?[GG[10]
# Sampling is specified as step 1 of the SEMMA process (but not specific to CRISP_DM), so I will cover this separately.
# Traditionally, Predictive Analytics have started with sampling[GG[11].  Sampling is particularly important in certain industries (such as Pharmaceutical and Healthcare), which begin with experimental studies. Sampling is also important in studies which you follow groups of people over a long period of time (“cohorts”).  However other kinds of data projects are not research type projects, and they are more machine learning oriented. Given that, I hold the belief that many algorithms are easier to work with (and are more powerful) if the data follows certain statistical properties, such as data which follow normal distributions, or have equal number of observations for various groups of interest.  Sampling can be critical in preparing the data for these algorithms, so that data is more representative of the larger dataset.
# Here are some other advantages to sampling:
# * With a smaller sample, you will have the ability to ‘intimately’ know all of your data, something that would not be possible with very large datasets. This also allows you to ask more questions.
# * Sampling allows you to contemplate potential interesting subsets of the population. You can first random sample a smaller subset of something that looks “interesting”, and then test to see if that group behaves heterogeneously
# * Sampling also speeds up algorithmic development. Spending a lot of running algorithms on very large datasets is often not productive, since you can spend a lot of processing time running memory consuming algorithms.  If you anticipate a lot of future tweaking for the algorithm (and you will be performing tweaking!), I suggest first testing your algorithms first on a smaller representative sample, and the following up with it on the much larger dataset.  
# * With sampling, you are more in control of the ultimate data quality of your samples.  I say this since you will have already done your legwork by looking at the characteristics of your population first, and then designing an appropriate sampling strategy which minimizes biases.
# * Performing Bootstrap (repeated) sampling can help illustrate any biases in large data samples.  If you see some strange stuff appear via sampling, there is a good chance there is a much larger problem in the larger data.
# Using ALL of the data
# 
# However, many Data Scientists will choose to use the entire population as the basis of analysis, instead of a sample. I suspect one reason is that often it is difficult to obtain a reliable sample, especially when the data has many different sources, and some are of unknown data quality. Good reliable data costs money to collect.  Another reason, is that the Data Scientists may not be familiar with sampling techniques, or believe that ‘more is always better'.  Therefore, it is important to understand some important points about using “all of the data”.
# * You can use all of the data if it accurately represents the underlying population. If ‘all the data’ IS the underlying population, you can’t do better than that, but proceed with caution.  What you think is a population may just be a very large sample of things that have yet to be seen. [GG[12]However, for very large data sets, we can never be quite sure if what we are looking at IS representative, since the amount of data can simply be overwhelming, and the data collection methods may be unknown.  Data can be representative for one month and for another, since a data collection method may have changed.
# * When you use an incredibly large amount of data, what you are measuring is not necessarily representative of the factors which motivate the response. For example, clickstream data and online survey data is not always representative of the ‘why?’. Deeper inspection (through smaller samples) is always advisable to examine motivation.
# * As mentioned earlier, processing data consumes a lot of computational resources.
# * With large datasets you will just about always find correlations somewhere.  Related to this is the concept of significant correlation vs. effect size. This means that even if you find a statistically significant correlation, the differences can be so slight, so as to render any association meaningless or non-actionable.
# 
# So the first line of attack for this is to try to understand how the data was collected.  It may be biased towards certain age groups, genders, technology users etc. There may be ways to fix this using a technique known as ‘oversampling’ in which you weigh certain underrepresented groups in a way which more realistically represents their frequency.
# Comparing a sample to the population
# To illustrate some of the benefits of sampling, and to see how you can often get close to the same results with a sample as with a larger population, copy the code below and run it within an R Script. This script will generate a 15,000,000 row population and then extract a 100 row random sample. Then we will compare the results.
large.df <- data.frame(
gender = c(rep(c("Male", "Female", "Female"), each = 5000000)),
purchases = c(0:9, 0:5, 0:7)
)
#take a small sample
y <- large.df[sample(nrow(large.df), 100), ]
mean(large.df$purchases)
mean(y$purchases)
#Render 2 plots side-by-side by setting the plot frame to 1 by 2
par(mfrow=c(1,2))
barplot(table(y$gender)/sum(table(y$gender))) 
# 
# barplot(table(large.df$gender)/sum(table(large.df$gender)))
# #Return the plot window to a 1 by 1 plot frame
# par(mfrow = c(1, 1))
# 
# Switch[GG[16] over to the console and note that the sample mean is close to the population mean. 
mean(large.df$purchases)
# [1] 3.666667
mean(y$purchases)
# [1] 3.64
#install.packages("sqldf")
library(sqldf)
set.seed(10)
rows=100
y <- rbind(
data.frame(indv=factor(paste("TransId-", 1:100, sep = "")),
                Sales=rnorm(rows, mean=1500000,sd=100000),
                Units=round(rnorm(rows,mean=10, sd=3)),
                Region=sample(c("North","East","South"),rows, replace=TRUE)),
data.frame(indv=factor(paste("TransId-", 101:200, sep = "")),
                Sales=rnorm(rows, mean=2000000,sd=100000),
                Units=round(rnorm(rows,mean=10, sd=3)),
                Region=sample(c("West"),rows, replace=TRUE))
)
query <- "select Region,avg(Sales),avg(Units) from y group by Region"
results <- sqldf(query,stringsAsFactors = FALSE)
results

# The results will appear in the console window
# 
# This is randomly generated data.  The functions rnorm(), and sample() in the written code are giveaways. Generating random data is a great way to begin to test code and algorithms since you will always have a better idea of what kind of results to expect. 
# Charts and Plots
# At the business understanding phase, it is not necessary to get too complex with visualizations. The reason I say this, is that in some instances complex visualization can influence interpretation, rather than providing objective data.  Basic charts and plots which indicate the relationships between the variables are more than adequate for communicating ideas.  
# When passing charts and plots back and forth during this phase, it is a good idea to include basic statistical measures of distribution and association – This will give management a rough idea of how significant the relationships are, rather than having them rely purely on the visual representation.
# Spreadsheets
# Sending the data to spreadsheets and creating pivot tables is another way to get management involved in the process. Spreadsheets have definite disadvantages, but they are heavily used in industry and knowing how to manipulate spreadsheets will be another way that you can communicate with managers.
# Simulation	
# Simulation is a tool which can demonstrate ‘what-ifs’.  This technique is very useful if there is not a lot of historical data to go by, and you need to make assumptions about the behaviour of some of your variables.  Typically, you do not have a lot of data at this point, so you are really constructing your own data, based upon how you think it will behave.
# In later sections of the book, I will use Simulation techniques heavily to illustrate this.
# Example – Simulating if a customer contact will yield a sale.
# Here is an example that is based upon a business estimate that 1 of 3 customer contacts will result in a sale.  Another assumption is that if a sale is made, it will result in an average of $100 each with a standard deviation of $5
# Expected Payoff either produces 0 revenue, or a figure that hovers around $100, as specified in line 3 of the code above

library(ggplot2)
set.seed(123)
CustomerAcquired.Flag <- sample(c(0,0,1), 100, replace = TRUE)
Revenue <- sample(rnorm(100,100,5))
ExpectedPayoff <- CustomerAcquired.Flag*Revenue
head(ExpectedPayoff)
PayoffCompare = ggplot(data.frame(ExpectedPayoff), aes(x=ExpectedPayoff)) + stat_bin(binwidth=5, position="identity")
PayoffCompare



# We can view this conditional customer acquisition problem as two separate charts contained within 1 visualization below.   The left side of the visualization is the count of  customer contacts which result in no revenue, and the right side shows the histogram of binned sales WHEN they occur. 
# 
# 
# 
# Insert Image B05033_02_02.png
# Example -Simulating Customer Service Calls
# In this example, we can simulate calls to customer service which might occur at the beginning and at the end of the week.  Management projects that weekend volume will be heavy, with an average of 1,500,000 calls and an average turnaround time of 4 minutes. Customer service call volume for M-Thurs is estimated as handling 1,000,000 calls with an average turnaround time of 1 minute. We could use this simulation to build upon a model to include  “Weekends’, vs. “Non-Weekends” as new variables in a predictive model.
library(ggplot2)
library(grid)
library(gridExtra)
set.seed(123)
MonTuesWedThurs=rnorm(1000000,1,1)
FriSatSun=rnorm(1500000,4,1)
weekly = c(MonTuesWedThurs,FriSatSun)


# If we were interested in looking at the difference in call volumes, we could look at them individual (as shown in the top row of the plot below),  or as a “combined” distribution for weekends and non-weekends.  The combined plot is one way of illustrating the difference between weekends and non-weekends, and show that they have similar shapes.
p1 = ggplot(data.frame(FriSatSun), aes(x=FriSatSun)) + stat_bin(binwidth=0.25, position="identity")
p2 = ggplot(data.frame(MonTuesWedThurs), aes(x=MonTuesWedThurs)) + stat_bin(binwidth=0.25, position="identity")

p3 = ggplot(data.frame(weekly), aes(x=weekly)) + stat_bin(binwidth=0.25, position="identity")

grid.arrange(p1, p2, p3, ncol = 2)


# Insert Image B05033_02_03.png
# Step 2 Data Understanding
# Once an objective is established, and data sources have been identified, you can begin looking at the data in order to understand how each data element behaves individually, as well as how it interacts in combination with other variables. But even before you start looking at the values of variables, it is important to understand the different types of data levels of measurement, and the kind of analyses you can perform with them.
# Levels of Measurement
# Levels of Measurement pertain to the type of data you are examining (character or number), as well as the scale in which they are measured (or absence of scale).
# Nominal Data
# Nominal data, also known as categorical data, simply defines a class or group without any natural order.  Nominal variables are usually character data, but not always[GG[23]. Your gender, the cell phone brand you prefer, and the type of book you are reading now, are all examples of nominal variables. Sometimes it can be tricky, since the number “1” and “2’ written on a sign, are also nominal variables when they are used to designated two possible waiting lines you may need to visit at the Motor Vehicle Bureau.  Nominal Data only designates classes, and you cannot perform any mathematical operations on them[GG[24], such as addition or subtraction.  A slight exception to the “order” requirement is when you are considering categories such as “best” or “better”, which does have a labelled order, but may not a natural one.
# When characterizing nominal data, the only measure of central tendency is the “mode”, which is the most frequently occurring value.  Computing means or medians cannot be performed. 
# In the R language we can convert character data to “Factors” so that we can analyse them as Nominal Data.  That will be an important part of the cleaning process which we will learn about later on. When analysing nominal data, frequencies of occurrence (counts) are a good starting point.  Or, you can begin by grouping calculations with other nominal variables, in order to determine counts, or averages of other numeric variables.  
# Ordinal Data
# Ordinal Data only has rank order. Statements can be made such as “A>B” and “B < C”, but you cannot compute [GG[25]the numeric differences between any of the groups.  A Top Ten list is an example of the presentation of ordinal data. One problem with ordinal data is we never know what the exact difference between each of the ranked data points.
# Interval Data
# This is numeric data in which you can measure distances, but cannot take ratios[GG[26].   Temperature data and calendar data are two examples of interval data.  All of the arithmetic differences between two consecutive data points on the numeric scale are measured exactly the same, so you can take meaningful differences.  
# Often, interval data is treated as ratio data. This is  often seen when performing calculations such as averages on Likert scales (even though this is not technically correct).  With ordinal data you can compute frequencies, calculate the median, compute percentiles but you cannot do any arithmetic or calculate a mean.
# Ratio Data
# The highest level of numeric data is ratio scale. With ratio data, you can make meaningful comparisons using division and subtraction[GG[27]. It is meaningful to say that you have acquired twice as many customers, when you went from 50 to 100 customers in one month.  Ratio data also adds 0 to [GG[28]the domain of numbers (which interval data does not contain), so it is meaningful to say that you have 0 customers (although not desireable). Weight and income are other examples of ratio data[GG[29].
# To learn more about the theory of scales and measurement, please refer to “On the Theory of Scales and of Measurement”  (Stevens, 1946)  
# Converting from the different levels of Measurement
# As a general rule, you can always transform a higher level of measurement to a lower level of measurement, but not the reverse. Often this is done via a technique known as “binning” in which you place all values with a certain range into a bin. You may want to take various ranges of height, and bin them into “Tall”, “Short”, or “Medium” based upon predefined ranges.  However, you would generally not take a categorical variable and map it to a numeric variable, unless you knew a lot about how that category was measured and you were willing to make a lot of assumptions. 
# Dependent and Independent Variables
# The dependent variable is the variable that you are predicting. It can also be referred to as a target variable, response variable, or outcome variable. One goal of predictive modelling is to derive a prediction for the dependent variable based upon some function of the independent variables. A dependent variable is typically fixed and you cannot manipulate it.  Independent variables are variables that you choose, in the belief that they are important in determining the outcome of the dependent variable, also based upon some function.  This function is typically applied using an algorithm. 
# Transformed Variables
# Transformed variables are variables that you create, which did not exist in the raw data.  Here are some examples of how you can create transformed variables.
# * You can “bin” a numeric variable into several distinct categories such as High (all numeric values greater than 10) or Low (anyas value less than 10. Notice that binning results in lost information, but allows you to some flexibility by being able to give things names.  
# * Transforming count data into percentages by dividing a cell count by the total population.
# * Standardizing the data - In the modelling phase, it is often useful to work with standardized variables, as opposed to using the raw data itself. A standardized variable is a transformation which ‘forces’ a mean of 0, and a standard deviation of 1. This transformation preserves the distribution and structure of the original values, but makes it easier to compare one set of variables with another variable with a different scale.
# * In regression modelling it is common to replace or add another variable with a transformation such as log(), or exp() so that the resultant model has a better linear fit.  
# Single Variable Analysis
# After taking inventory of all your potential candidate variables, it makes sense to[GG[30] start with single variable analysis. Why complicate things by looking at multiple variables at once when you can start looking at them one at a time? Often the results of modelling will suggest immediate elimination of a variable for inclusion in a model, such as one with a high percentage of missing values, or one with data quality issues.  Eliminating variables early is often the best course, rather than carrying them through an analysis, only to discard them later on. This is especially true if you find two variables which measure the same thing. 
# Summary Statistics
# Analysis with summary statistics is one of the first descriptive which should be performed on every candidate variable.  Means, Standard Deviations, Frequencies, and Skewness allow quick generalization about how you expect a variable to behave. Special consideration should also be given when examining any variable deemed to be a target variable.
# To display basic summary statisticsbout a single variable, use the R summary function. This can be issued as part of an R Scripts or directly from the command line.  The general form of the summary function is:
# #for a single variable
# Summary(dataframe$variable) 
# #for all of the variables
# Summary(dataframe) 
# 
# Two other typical single variable analysis summary techniques to use are:
# * Distributions – A distribution plot (Histogram, probability density plot etc.) will give you an idea of how a variable looks vs. a theoretical statistical distribution. Some modelling techniques will require some assumptions regarding distributions, and others will not.  If you find that a variable follows a particular distribution you will be lucky.  That will make modelling easier later on. In R, you can use the hist() function.
# * Boxplots – A boxplot is a simple graphic representation of a distribution which always includes 5 key elements of a distribution minimum[GG[31][rw32][rw33], first quartile, median, third quartile, and maximum. (See  “Comparing Treatments” in the next section for an example the R function boxplot() which produces these 5 key elements).
# o The “box” which has the upper and lower lines of the box representing the third and 1st quartile, with the median line in between.
# o The “whiskers” which has the top line representing the max, and the bottom line representing the minimum.
# Bivariate Analysis
# Bivariate Analysis is typically the next step you would take after single variable analysis. Bivariate analysis is used to show the relationship between any 2 variables. You are performing Bivariate analysis for two reasons
# * In a modelling framework, one key outcome we are looking for would be any association between the target variable and any one of the independent variables.
# * Another, equally important outcome we are looking for are any possible associations between any two of the independent variables.  That will help us understand which of the independent variables are correlated with each other, or help us understand how one variable changes the behaviour of another.
# Types of questions that bivariate [GG[34]analysis can answer
# As you examine the relationship between any two variables, here are some key points to keep in mind.
# * Does one variable always go up when the other goes up?  Or is there one critical value in either of the variable that alter the relationship? 
# * Are the changes in the values dramatic, or are they slow and steady?
# * Is there strength in the relationship, and is the relationship linear, or is there curvature?
# * Are there specific subsets of data that have correlations that are more interesting than others? 
# The kinds of plots and charts one uses display these relationships and are dependent upon the variable data types[GG[35].  For interval and ratio scale data, we will group them together into one category and refer to them as “Quantitative’ data.
# Therefore when we look at bivariate relations between quantitative and nominal data we can have 3 basic combinations:
# 1. Quantitative with Quantitative
# 2. Nominal with Nominal
# 3. Nominal with Quantitative
# 
# Quantitative with Quantitative variables 
# 
# Scatterplots are often used to show relationships between two quantitative variables.  In the following code, we will use the R pairs() function to plot some associations. As you can see,  Petal.Width has a strong relationship with Petal.Length (row 3, column 4), while the relationship between Sepal.Width and Sepal.Length (row 1, column 2) is not as strong.
# Code Example 
pairs(iris[1:4], bg=c("green","blue","brown","yellow","black","orange"), pch=21)


# Insert Image B05033_02_04.png
# Nominal [GG[36]with Nominal Variables
# We will look at nominal vs. nominal in 2 different ways.  One using table style, and the other using graphic methods. 
# Cross-Tabulations
# Cross tabulations are a good starting point for examining the relationships between Nominal variables.  There are many ways to do this in R.  I like to start of by using the CrossTable() function from the gmodels package, since it will give not only the cell counts, but will also give the frequencies for the rows and columns totals, and supply a chi-square statistic to measure the statistical significance. It may not be pretty, but it does the job well.
# Code Example[GG[37]
# 
#install.packages("gmodels")
library(gmodels)
CrossTable(mtcars$cyl, mtcars$gear, prop.t=TRUE, prop.r=TRUE, prop.c=TRUE)


# > CrossTable(mtcars$cyl, mtcars$gear, prop.t=TRUE, prop.r=TRUE, prop.c=TRUE)
# 
#  
#    Cell Contents
# |-------------------------|
# |                       N |
# | Chi-square contribution |
# |           N / Row Total |
# |           N / Col Total |
# |         N / Table Total |
# |-------------------------|
# 
#  
# Total Observations in Table:  32 
# 
#  
#              | mtcars$gear 
#   mtcars$cyl |         3 |         4 |         5 | Row Total | 
# -------------|-----------|-----------|-----------|-----------|
#            4 |         1 |         8 |         2 |        11 | 
#              |     3.350 |     3.640 |     0.046 |           | 
#              |     0.091 |     0.727 |     0.182 |     0.344 | 
#              |     0.067 |     0.667 |     0.400 |           | 
#              |     0.031 |     0.250 |     0.062 |           | 
# -------------|-----------|-----------|-----------|-----------|
#            6 |         2 |         4 |         1 |         7 | 
#              |     0.500 |     0.720 |     0.008 |           | 
#              |     0.286 |     0.571 |     0.143 |     0.219 | 
#              |     0.133 |     0.333 |     0.200 |           | 
#              |     0.062 |     0.125 |     0.031 |           | 
# -------------|-----------|-----------|-----------|-----------|
#            8 |        12 |         0 |         2 |        14 | 
#              |     4.505 |     5.250 |     0.016 |           | 
#              |     0.857 |     0.000 |     0.143 |     0.438 | 
#              |     0.800 |     0.000 |     0.400 |           | 
#              |     0.375 |     0.000 |     0.062 |           | 
# -------------|-----------|-----------|-----------|-----------|
# Column Total |        15 |        12 |         5 |        32 | 
#              |     0.469 |     0.375 |     0.156 |           | 
# -------------|-----------|-----------|-----------|-----------|
# 
# 
# Insert Image B05033_02_05.png
# Mosaic Plots
# Mosaic Plots will also display crosstabulations graphically.  You can see visually that 8 cylinders and 3 gears represent the largest car cylinder/gear offering (37.5% of cars shaded in the contingency table above), while the 8 cylinder and 4 gear combinations seems to not exist .  This is also shown in the boxed value of the contingency table above, along with the dotted line in the mosaic plot below.
# 
# Nominal with Quantitative variables 
# These comparisons are often examined using basic bar charts, or in the example below, using side by side box-plots. These boxplots give very clear comparisons. 
# Code Example
set.seed(123) 
rows=100
a <- data.frame(Sales=rnorm(rows,mean=75,sd=5),
                Treatment=factor(c("Campaign A")))
b <- data.frame(Sales=rnorm(rows,mean=80,sd=5),
                Treatment=factor(c("Campaign B")))
combined=rbind(a,b)
#Boxplots which compare treatments [GG[38]
boxplot(Sales~Treatment,data=combined, main="Comparing Treatments", 
        xlab="Treatment", ylab="Sales")

# Insert Image B05033_02_06.png
# Point Biserial Correlation
# Another basic technique that you could use if one of the categories is a nominal variable with only 2 classes and the other variable is quantitative would be point Biserial Correlation[GG[39].  However, since this technique uses Pearsons’ correlation coefficient, you need to make certain assumptions about the distributions of the data.  E.g the data needs to be normally distributed and have equal variance.
# 
# To show Point Biserial Correlation, we can use our sales treatment above. First first map each of the Sales treatment to numeric variables:
# 
Treatment_num <- as.integer(combined$Treatment)

# Next, we can use the R table function simply to see how the two marketing campaigns have been mapped to numeric.  Campaign A maps to the number 1, and Campaign B maps to the number 2.

table(combined$Treatment,Treatment_num)



# Now run a biserial plot. You can restrict the x-axis to the values 1 or 2, since you  know in advance that there are only 2 values.

ggplot(combined,aes(x=as.integer(Treatment_num), y=Sales)) + geom_point(size=1.5,shape=1) +
scale_x_continuous(breaks=c(1,2)) +
  ggtitle("Point BiSerial Correlation of Campaign with Sales") +
  labs(x="Campaign Number",y="Sales")




#Having numeric data has its advantages. Since the data is now in numeric form we can also run a correlation test. The output sholws correlation between sales for the 2 campaigns is .39
cor.test(Treatment_num,combined$Sales)

# > cor.test(Treatment_num,combined$Sales)
# 
# 	Pearson's product-moment correlation
# 
# data:  Treatment_num and combined$Sales
# t = 6.0315, df = 198, p-value = 7.843e-09
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#  0.2699868 0.5051026
# sample estimates:
#       cor 
# 0.3939704
# 
# Step 3 Data Preparation
# As was mentioned in Chapter 1, Getting Started with Predictive Analysis one purpose of data preparation is preparing an input data modeling file which can go directly into an algorithm.  In theory, the input file will encompass all of the knowledge gained in steps 1 and 2.  Ideally, this file will consist of a target variable, all meaningful predictor variables, other identification variables to aid in the modelling process, and any additional variables which will have been created based on the raw data sources. Data preparation, like the previous steps outlined is an iterative process.  Here are some typical steps you might follow when preparing the data:
# * Identifying the data sources – These are the critical data inputs that you will need to read in and manipulate. They can be sourced from various data formats such as CSV files, Databases, or XML or JSON files.  They can be in structured format, or unstructured format.
# * Identify the expected input - Read in some test samples and closely examine the input to see if it is what you expect. More often than not, there will  be some formatting problems that can be easily fixed, and you will probably want to rename variables, and change some data types from character to numeric and vice-versa.
# * Perform further data quality and reasonability checks.  After you have performed your own internal checks, cross reference the data you observe with existing metadata information (such as data dictionaries if available), domain experts, and other data artifacts which already exist, to see if what you are reading is what you expected.  Sometimes you will need to join the data with other lookup or reference tables in order to obtain what you are really looking for.
# * Expanding the number of input records. – After reading in, and vetting a test sample, you will probably want to read in a much larger sample of records and variables, beyond what you read in the initial stage. Determining how much data to read in at this stage is a decision you will need to make. If you read in all of the variables, you may encounter memory problems later on, and if you read in just what you need, that may force you to go back later on and incorporate additional data or variables.  Try to get a good representative sample of data at the beginning.  Later on, it may make sense to rewrite your code to read in only a subset of the variables that you really need.
# * Perform some basic data cleaning. Although cleaning the data is an important part of the modeling process, it is important not to ‘over clean’. An example of over cleaning would be attempting to fix every missing value via imputation. Models can co-exist with a reasonable amount of bad data, and will perform better in the long run if some variation is included.
# * Try some aggregation - Aggregate some of the data by some basic categories and observe the results.  Consider whether using aggregated data instead of individual data makes better sense in any model you develop.
# * Create new variables or transformations –  This is where binning, and standardizing variables come into play.
# * Identify key variables - Even more modelling has begun, you should be able to preliminary identify which variables are important using a combination of bivariate analysis, SQL, and other exploratory tools.  It is not critical to identify the most important variables, but only the ones that may have some predictive power, or are already known to be relevant.
# * Join any of the input files you have examined into one single analytics file.  Now you are ready for the modelling phase.
# Step 4 Modelling 
# In the modelling stage, you will pick an appropriate predictive modelling technique that fits your problem, and apply it to your data. There are several factors which influence the selection of a model.
# 1. Who will use the model?
# 2. How will the model be used?
# 3. What are the assumptions of the model?
# 4. How much data do I have?
# 5. How many variables do I need to use?
# 6. What is the accuracy level needed by the model?
# 7. Am I willing to trade some accuracy for interpretability?
# Particularly related to the last point is the concept of Bias and Variance:
# Bias is related to the ability of a model to approximate the data.  Low bias is desirable, since that means the model is fitting the data with little error.  High Bias implies that an algorithm is a poor choice for a certain type of problem.  A linear regression, for example, which tries to fit data which forms a U-Shaped distribution, would not be an appropriate algorithmic choice for that problem, regardless of the number of parameters selected, or how the coefficients were adjusted.  For example, 5-Star Ranking reviews are often skewed toward very high or very low ratings, and linear regression would not be an appropriate choice.
# 
# It would be a much better fit for a regression problem involved sales prediction from inventory.  Low Bias models tend to result in Over fitting, and Hi Bias models have lower accuracy but are simpler to explain.
# Variance is related to how a model would change when supplied with different data.  Low variance is also desirable.
# Decision Trees are an example of an algorithm which tends to have low bias (over fits), but can come up with completely different results when given a new training sample (High Variance).   Even adding 1 additional observation to an existing Decision Tree model can result in a totally different tree.
# To develop a good predictive model, you acknowledge that there ultimately will be a compromise or tradeoff between bias and variance. To learn more about the bias-variance tradeoff please check out some of the external references in Wikipedia.  (Wikipedia, n.d.)
# Description of Specific Models
# Here are some short descriptions of some of the models that we will be covering, with some short code examples.
# Poisson (counts)[DT40]
# A Poisson model is used to model counts of things.  That could be the number of insurance claims filed in a given month, the number of calls which are received in a call center in a given minute, or the number of orders which are sold for a particular item. The Poisson distribution is the appropriate way for modelling count data since all data is positive and the range of the distribution is bound by 0 and infinity.  The classic way of modelling a Poisson model is thru the R glm() function,  using a Poisson link function:
#model.poisson <- glm(count ~ v1+v2+v3, data=inputdata, family=poisson())
# 
# Note that the model specified above merely shows the model in a generalized form. Do not try to run it since are no variables existing variables v1,v2,v3 or count. However what the model specification says is that you will run a Poisson model via the following general steps:
# * The model will be run via the glm function with some dependent variable to the left of the “~”
# * Independent variable will be supplied to the right of the “~”.
# * supply some existing variables as independent variables to the right of the tilde (~)
# * The “Data=” parameter will supply an input data set
# * The “family=” parameter will specify the type of general linear model that you will be running.   In this case, it will be a poisson model.
# To try a Poisson model on “real” data we can use the “warpsbreaks” data which is included with R.
# * First at the console, Enter help (warpbreaks) to get a description of the data set.
# [,1]
# breaks
# numeric
# The number of breaks
# [,2]
# wool
# factor
# The type of wool (A or B)
# [,3]
# tension
# factor
# The level of tension (L, M, H)
# 
# Then set up, and execute the model using the glm function. We are predicting the number of breaks, using the type of wool, and level of tension.  Note they we need to add a summary function after the glm function (not displayed) in order to see the output, since running the glm just assigns the output to an object named model.poissonmodel
model.poisson <-glm(breaks~wool+tension, data=warpbreaks, family=poisson)
summary(model.poisson)

# Logistic Regression
# Logistic Regression is one of the oldest and stable techniques that one can use for classification.  Logistic Regression, Linear Regression and Poisson regression are all considered General Linear Models. However, in the case of Logistic Regression, the predicted value can only be ‘0’, or ‘1’.  Fortunately, this corresponds with many use cases, such as whether or not a customer will leave, or whether or not a hurricane will appear. If you are already familiar with multiple linear regression, logistic regression should be easier to understand, since you should already be familiar concepts such as specifying multiple independent variables, and the use of mathematical functions, such as log, exp which can “smooth” the variables in the model[DT44][rw45][rw46] and force it to be more ‘linear’. 
# Logistic Regression is also useful in that it produces an odd ratio. An odds ratio [GG[47][rw48][rw49]is the probability that an event will occur divided by the probability that the event will NOT occur.
# A standard Logistic Regression is called in R via the GLM (General Linear Model) function. 
# The call to glm() contains a specification for a ‘link’ function.  The link function specifies which kind of model, or distribution will be used for the linear model.  For logistic regression, use family=binomial() to specify logistic regression.
#Model.logistic <- glm(Target~v1+v2+v3,data=sourcedata,family=binomial())
# Support Vector Machines (SVM)
# Support Vector Machines can also be used to predict a binary class. SVM projects the data into a higher dimensional space so that ‘hyperplanes’ can be used to separate the classifiers, SVM’s can be very accurate but difficult to interpret and computationally expensive.
# Here is a simple example of using a Support Vector Machine to predict if a person is “satisfied”, based upon the day of the week, and whether or not it is a payday (The vector element marked as “1” in the payday vector, which can be interpreted as Friday, if you start counting from Sunday). 	
library(e1071)
satisfied = factor(c(F,F,F,F,F,T,F))
day = c(1,2,3,4,5,6,7)
payday = c(0,0,0,0,0,1,0)
satisfaction.df = data.frame(day=day, payday=payday, satisfied=satisfied)
model.svm = svm(satisfied ~ day + payday, data = satisfaction.df)
plot(model.svm,satisfaction.df,main="",col=c('grey','black'))

# [GG[52]As you can see from the plot below , the ‘Decision Line’ is a curve near the upper right part of the quadrant, and area where payday is close to 1 (“YES”), and day of week is close to 4,5,6,7 (“Later part of Week”).  So we can interpret [GG[53]that as saying people are satisfied on payday and at the end of the week.  However, this is a very low dimension example (rendered in 2 axes) that we used to illustrate the concept.  Higher dimensional examples are not that easy to interpret!
# [rw54][rw55] 
# Insert Image B05033_02_07.png
# Decision Trees 
# Decision Trees are popular since they can roughly be equated with “If/Then/Else” rules used in some business contexts, and are relatively easy to explain to managers. Decision Trees are not only used for classification.  When they are used to predict numeric outcomes they are referred to as Regression Trees. The basic concept that decision tree uses is that each note [GG[56]of the tree is split into 2 parts based upon an optimal split point. The tree continues to grow by adding more ‘leafs’ until it is not able to make any additional splits which improve the ability to distinguish between any of the decisions.
# Random Forests
# The Random Forest aloNote that Random Forests(tm) is a trademark of Leo Breiman and Adele Cutler and is licensed exclusively to Salford Systems for the commercial release of the software.
# 
# One problem with Decision Trees is that they are highly dependent on the specific variables that are initially chosen.  One could generate a slight different set of initial variables and end up with an equally valid solution, although different.
# Random Forest algorithms  (which can be known by several different names, see note at end of chapter)  are an attempt to improve Decision Trees, in that Random Forests “randomize” the selection of variables, and subsamples, to order to generate multiple (even thousands!) of separate Decision Trees. After all the decision trees are generated, a “consensus” prediction is determined, which average the effects over all of the different trees that have been generated .
# In order to determine ‘consensus’ you can specify that the algorithm implement a simple majority vote scheme. We will see how this works by running two simple decision trees on the ‘titanic’ data set first, and then comparing the results to that which is obtain using a random forest. 
# Example: Comparing Single Decision trees, to a Random Forest
# First install the “titanic” package, and assign the training dataset to a dataframe
#install.packages("titanic")
library(titanic)
titanic <- titanic_train[complete.cases(titanic_train), ]
	
# An Age Decision Tree
# Grow a simple decision tree to predict whether a passenger survived using Age as an independent variable,, and then plot the tree
library(rpart)
library(rpart.plot)
set.seed(123)
fit <- rpart(as.factor(Survived) ~ Age,  data=titanic,   method="class")
rpart.plot(fit,extra=102)

(410+33) / nrow(titanic)
#[1] 0.6204482

# An alternative Decision Tree
# Let’s say we arbitrarily selected another simple decision tree model, This time we will predict whether or not a passenger survived based upon the Passenger Class variable.
# 
# 
# 
# This is a slightly more complex tree, since it has 4 branches and 3 terminal nodes. Now let’s calculate the correct classification rate for the model by adding up the correct classification numbers for the three nodes and dividing this by the total number of rows, as we did before.
(270+90+122) / nrow(titanic)
# [1] 0.67507
# >
# This simple model is even better, with a 67% correct classification.
# The Random Forest Model
# Now, let’s run a random forest model. We will grow 2000 trees, and just for illustratin include Age, Pclass (Passenger Class), and Fare as the independent variables.   Random Forest randomizes both the observations selected as well as a sample number of observations selected, so you are never certain which specific trees you will get. You might even get one of the trees just generated in the previous example!  
library(randomForest)
set.seed(123)
fit <- randomForest(as.factor(Survived) ~ Age + Pclass + Fare,
                    data=titanic, 
                    importance=TRUE, 
                    ntree=2000)

# Random forest also has a predict function, with a similar syntax to the predict function we used in Chapter 1. We will use this function to generate the predictions.

prediction.rf <- predict(fit, titanic)

# Once the predictions are generated, we can construct a dataframe consisting of the predictions along with the actual survival outcomes obtained from the raw data. 

x<-data.frame(predict.rf=as.factor(prediction.rf),survived=titanic$Survived)

# Now we can run a simple table() function which will count the number of outcomes classified by their predicted values.

table(x$predict.rf,x$survived)

# > table(x$predict.rf,x$survived)
#    
#       0   1
#   0 384 118
#   1  40 172
# 
# 
# The numbers in the table reflect the following predictions:
# (Row 1,Column 1) Passenger predicted NOT to survive & DID NOT survive
# (Row 1,Column 2) Passenger predicted NOT to survive DID survive
# (Row 2,Column 1) Passenger predicted to survive and DID NOT survive
# (Row 2,Column 2) Passenger predicted to survive and DID survive
# 
# Based on that, we can see that we have made correct predictions for the counts contained in (Row 1,Column 1), and (Row 2,Column 2) , since our predictions agree with the outcomes.
# To get the total number of predictions, we will add up the total number of correct counts, and then divide by the number of rows. We can do the math at the console:

(384+172) / nrow(titanic)

# > (384+172) / nrow(titanic)
# [1] 0.7787115
# 
# Using a Random Forest, the correct predictions rate has been raised to 77%, 
# Random Forest vs. Decision Trees
# Even though Random Forests can be better predictors than singly partitioned trees, the issue of interpretability comes into play. Random Forest do not generate visual decision trees, and computationally Random Forests can take quite a long time to run as it works to grow and optimize multiple trees from many variables. Some feel that it acts as a ‘black box” since there are so many ways to optimize, and the underlying methods are not readily transparent.  However, it IS an optimization method and can be very accurate, if extreme accuracy is your goal.  
# Variable Importance Plots
# Aside from the prediction accuracy, another popular use for Random Forests is it can be used for variable selection, using the varimp() function.  A variable importance plot can be useful in situations in which there are MANY input variables, but I have found it to be of limited value for a manageable number of variables.
# Just to illustrate on our example data, here is the varimp() function  showing Fare, Age, and Passenger Class in order of importance.  There are a couple of ways it can do this, but I will be showing it as determined via statistic referred to as “MeanDecreaseGini”.  It is not critical to understand how this statistic is computed, but it is sufficient to say at this point that importance is related to how many different trees the variable appears in, and the part it played in deciding how “well” it was able to discern one outcome of a tree branch from another.  We will discuss decision trees, and “Gini” in later chapters.
varImpPlot(fit,type=2)

# Dimension Reduction Techniques
# You will often be examining hundreds or even thousands of variables, and dimension reduction is a technique that you can use to drastically reduce the number of rows or variables that you need to examine.  The premise behind dimension reduction is duplication.  Many variables which are measuring the same thing. For example, reading, writing, math, and musical aptitude scores are all important in predicting a college GPA, but it is possible that if you only used a musical aptitude score in combination with a writing score you could achieve the same prediction accuracy as compared to using all 4 measures. It might also be easier to explain as well.  That is one example of why you would use a dimension reduction technique.
# When you are looking at reducing the actual number of variables consider Principal Components.  You will end up with the same number of observations, but will limit the number of variables you look at (The Principal Components).
# When you are considering reducing the dimensionality of rows, use clustering methods.[GG[57]
# Principal Components
# Principal Component Analysis (PCA) is useful in cases in which you have too many variables, and you wish to capture the all of variation of the data into 1 or two variables. Principal components does this by using matrix algebra to [GG[58]create linear combinations of all of the variables.  
# PCA is also used to see which variables have the most influence within each of the principal components, so often it is a way to discard certain variables when a PCA analysis indicates certain variables have little effect on the outcome. 
# An example using the variables of height and weight is a good example.  Since height and weight are positively correlated, choosing to use only height or only weight as an independent variable to predict body mass might not make much of a difference.  So, can we create a new variable which is a linear combination of height and weight and use that as a variable instead.  
# 
# Clustering 
# Clustering is a method which groups data into different classes, so that each class is ‘similar’ to each other.  There are various methods which can be used to define similarity.  K-Means clustering is probably the most popular method of clustering. This method uses distances measures to assign data observations to the closest “Class”.  Clustering is often used in Marketing in order to develop different customer segments.
# Clustering is an unsupervised algorithm and is subjective.  You can specify beforehand how many groups you wish to cluster into.  This number of somewhat arbitrary, and if the goal is interpretability, it can yield to different interpretations.
# Scatterplots are often used to show how data clusters using only 2 variables (One is on the x-axis, and the other on the y-axis). 
# Here is an example of  some scatterplots which can be used to pick out clusters, by seeing which data points ‘congregate’ together[GG[59].
# 
# Insert Image B05033_02_08.png
# The plot on the right shows 5 distinct clusters.  You can see that very low values of variable x tend to go with very low values of variable y.  However, it is a bit unclear what the clusters should be for the plot on the left.  Sometime low values of x go with low values of y, but sometimes they are associated with high values of y.  There is no apparent distinct grouping.  What do you see?  Do you see two clusters, three or more, or no clustering?  It is really impossible to tell, and that is where subjectivity creeps in.
# Time Series Models
# Problems containing data observations which are not independent of one another -- such as time-based data, deserve[GG[60] special treatment, since events which occur in time exhibit a property known as autocorrelation.  What that means is that the independent variables are all dependent upon the previous values of that variable.  Many data techniques assume data all values occur independently of each other, so special techniques were developed to deal with time based data
# Exponential Smoothing is based upon the simple concept that the most recent data is the best predictor of the future. Exponential smoothing techniques allow you to tweak the parameters so that you can decide how much weight is given to the recent data vs. the older data. It is suitable for many time series problems.
# Time Series Models can also be based upon cyclical, trend, seasonal, one time occurrence, or,causal factors.  One of the more advanced time series methods is known as ARIMA or Box-Jenkins models which incorporate elements of time series and regression models. 
# Naïve Bayes Classifier
# Naïve Bayes originally became popular as a method for spam detection. It is quick and fast.  Naïve Bayes assumes that the variables are all independent and not related to each other,  (a bad assumption, but that is what makes it Naïve!).  It also has the advantage that it does not need to be retrained when adding new data. Naïve Bayes has its roots in Bayes Theorem 
# This simple example shows Naïve Bayes in action.  Using the Iris Dataset, Naïve Bayes will make a prediction for the 5th column, using the first 4 columns as independent variables. 
# #use 1st 4 columns to predict the fifth
library(e1071)
iris.nb<-naiveBayes(iris[,1:4], iris[,5]) 
table(predict(iris.nb, iris[,1:4]), iris[,5])

# The results of the table() function will go to the console. This output is the “Confusion Matrix”. 
#             
#              setosa versicolor virginica
#   setosa         50          0         0
#   versicolor      0         47         3
#   virginica       0          3        47
# 
# The correct classification rate for the problem is [GG[61]96%. This can easily verified at the console by summing up the values corresponding with the correct classification counts (i.e row1/column1, row2/column2, row3/column3), and then dividing by the total number of rows.
# 
# Here is how you would do it in the console using the R calculator:
# 
# 
# 
# The confusion matrix also tells you which classifications did NOT perform well. For example, if you sum the values of column 2, you can see that there is a total of 50 versicolor species.  However, there were a total of 3 misclassifications for the versicolor/virginia combination (Bold Underlined below)
#             setosa versicolor virginica
#   setosa         50          0         0
#   versicolor      0         47         3
#   virginica       0          3        47
# 
# To identify which combinations were misclassified, we can write a little bit of code and examine the incorrect classification rows using a “DataTable”.  Using a DataTable object allows you to sort, search , and filter the data.
# Merge the predictions with the original data. Then assign a “Correct” or “Wrong” flag to the dataframe to designate if the prediction was correct or not
mrg <- cbind(pred,iris)
mrg$correct <- ifelse(mrg$pred==mrg$Species,"Correct","Wrong")
# Load the DT library and specify that you want an interactive datatable on the merged data.  You will also want some interactive filtering capabilities, so specify “filter=top” as a parameter.
library(DT)
datatable(mrg,filter='top')
# The interactive data table will open in the RStudio Viewer.
# To find the misclassified species, Type “Wrong”, in the search box, above the “Correct” column. The display will automatically update to show the incorrect predictions.
# 
#   
# Text Mining Techniques
# Predictive Analytics originally would only be able to model structured data. However, that has changed with the advent of Text Mining techniques, which is able to process, and visualize unstructured data.  Some of the more popular tools are:
# * Word clouds – Word Clouds are graphical representation of woord frequencies or concepts, and is a simple tool for presented important words in a corpus (collection of text documents), to management.
# Here is an example of a word cloud produced from Lincoln’s Gettysburg Address (Bliss Copy).  (Gettysburg Address, 1863).  To limit the number of words displayed, set min.freq=2, so that only words which appear at least two time will be displayed. Notice that the output is also eliminating some common words (stopwords),  which to not usually add to the interpretation (a, and, it, etc.)

#install.packages("wordcloud")
#install.packages("RColorBrewer")
library("wordcloud")
lincoln <- "Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal. Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this. But, in a larger sense, we can not dedicate -- we can not consecrate -- we can not hallow -- this ground. The brave men, living and dead, who struggled here, have consecrated it, far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced. It is rather for us to be here dedicated to the great task remaining before us -- that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion -- that we here highly resolve that these dead shall not have died in vain -- that this nation, under God, shall have a new birth of freedom -- and that government of the people, by the people, for the people, shall not perish from the earth."
set.seed(123)
wordcloud(lincoln, min.freq=2,scale=c(3,.5),random.order = FALSE)


# The output of the word cloud uses the size of the word to represent its frequency in the text. 
# * Bigram analysis – Word Clouds usually show the frequencies of single words in a paragraph or document. They do not usually analyze the surrounding words. Bigrams, on the other hand, looks at the frequency of two consecutive words . Often, additional insight can be derived by seeing how many times these consecutive words appear together in the various parts of the document being analysed. This bigram concept can also be extended to 3 words at a time, 4 words at a time, etc. In this case, they are called n-grams, meaning analysis of any number of consecutive words which appear together.
# For example; the follow table shows 4 bigrams which appear twice in the paragraph above, and 1 that appears 3 times (“consecutive words”).  Note that this includes punctuation which is usually removed before frequency counts are determined. Punctuation, numbers, and small parts of speech such as “the”, “them”, “a’, or “an” are usually performed prior to performing text analysis.  These are collectively known as “stopwords”.
# 
# 
# * Run frequencies for the occurence of pair of words (n=2) for the Gettysburg address.  

#install.packages("ngram")
library(ngram)  
df <-get.phrasetable ( ngram(lincoln, n=2) )
View(df)

# From the output of the View command we can see that “the people” occurs 3 times.
# 
# 
# 
# * Topic Definitions[GG[62] – With topic definition[RW(63] your goal is to classify documents into a set of categories, just as we would with a non-textual problem.  For example, if a customer calls and then starts complaining about the reliability of a product, we might want to direct the customer to a different call center area separate than if he was calling simply to get information about a product. A key component of text mining is the ability to be able to parse unstructured data, and learning how to mine this data for the important words.
# * Clustering - Other traditional techniques, such as clustering, can also be used with free form text.  However, in many case the text data will need to be ‘retrofitted’ and will be need to be transformed to a structured format first, before traditional predictive analytics techniques such as clustering are applied.  You will learn how to convert unstructured text into a structured called a term frequency matrix, which will allow you to perform traditional predictive analytics techniques.
# * Sentiment analysis, which is the ability to gauge person or groups opinion (whether positive or negate) about a product, service, or policy.
# 
# Here is an example which will produce a sentiment analysis prediction for various short comments made to a call center.  A naiveBayes model is used to predict the last 5 comments, based upon the first 10 comments which have been manually preclassified as positive, or negative.
#install.packages("RTextTools")
library(RTextTools)
library(e1071)

verbatim = 
  rbind(
    c('Agent was very helpful', 'positive'),
    c('Would buy the product again', 'positive'),
    c('Satisfied with response', 'positive'),
    c('Helped me to choose between the two offers', 'positive'),
    c('Defintely would recommend to a friend', 'positive'),
      c('Terrible customer service', 'negative'),
      c('not recommended', 'negative'),
      c('Agent took too much time', 'negative'),
      c('Waiting a long time for customer service', 'negative'),
      c('Not satisfied with response', 'negative'),
    c('Not satisfied at all', 'negative'),
    c('Would not recommend', 'negative'),
    c('Helpful customer support', 'positive'),
    c('Great product support', 'positive'),
    c('excellent product', 'positive')
    
    )
# build Term document matrix
TDM.mat= as.matrix(create_matrix(verbatim[,1],language="english",removeStopwords=TRUE, removeNumbers=TRUE,stemWords=FALSE)) 
classifier = naiveBayes(TDM.mat[1:10,], as.factor(verbatim[1:10,2]) )
# test the model
predicted = predict(classifier, TDM.mat[11:15,]); 

# the table function will tell you how the predictions did for the last 5 customer comments. 3 of the 5 comments were classified correctly (60%).  Is 60% considered good?  That depends upon what you will be doing with your model.  If you are able to identify negative comments, you might want to reach out to the customer via various channels and try to win the customer back.  On the other hand, positive comments imply that you are doing right by the customer, and maybe you should think about offering good customer discounts.

table(verbatim[11:15, 2], predicted)

# Step 5 Evaluation
# Model Evaluation deals with how accurate or useful the model you have just developed is, or will be in the future. Model Evaluation can take different forms.  Some are more subjective and are domain oriented, such as placing it under the scrutiny of experts in your field, and some are more technically oriented. There are many metrics and procedures available to assess a model. At the basic level, you have many statistics (some of them with acronyms known as AIC, BIC, AUC) [GG[67] which proport to convey the goodness of a model in a single metric.  However, these metrics by themselves are unable to convey the purpose and application of a predictive model to a larger audience, and often these metrics are in conflict. Some context is needed.   Some would argue that one could also develop a perfectly good predictive model and then be unable to convey its purpose and application to a larger audience. In my opinion, that is a bad model, regardless to how well an evaluation metric fits. And then there is the performance factor.  A model may work well on sample data, but be too slow to become actionable in the real world.  In short, there is no single metric that you should use for model evaluation.  The best course it to look at it from all angles, and then present the objective results.
# Model validation
# The basic premise of predictive analytics model validation is that you develop your model on one subset of the data (called the “Training” data set), and then “prove” that your model works by applying the same results to your “Test” data set.  The Test data set is also known as a holdout sample. The Training and Test data sets are randomly determined before any model building begins, and the data is never changed.  The “Validation” data is a 3rd dataset that is sometimes used to further test the validity of the data.  It typically contains data the modeller has never seen before, and is introduced after a model has been developed, and determined to be the ‘champion’ model. 
# The code below will create a simple Naïve Bayes model, and create a “Confusion Matrix” (or Classification error table) which shows how many predictions were classified correctly.  For the “Iris” data set, 92% of the predictions were correct.  Note that for this example we are using the confusionMatrix, which is part of the caret package, rather than computing the accuracy manually, as we did in previous examples.

require(caret)
require(e1071)
data(iris)
set.seed(123)
partition.index <- createDataPartition(iris$Species, p=.5, list=FALSE)
Training <- iris[ partition.index,]
test <- iris[-partition.index,]
model <- naiveBayes(Species~.,data = Training)
predictions <- predict(model, test[,1:4])
# summarize results
confusionMatrix(predictions, test[,5])


       
# Area Under the Curve (AUC) 
# Area Under the Curve is another popular measure to assess the goodness of your model. Historically, this measurement was developed during World War II. The original terminology was Receiver Operating Characteristic (ROC) and its original purpose was to determine whether or not a blip on the radar screen was an enemy ship, or just random noise.
# One of the things that the AUC tells us is the ratio of the True Positives to the False positives.  The AUC is determined via a mathematic formula will be a number between 0 and 1.  An AUC of  .5 is considered a random classification. Look for points that hover near the upper left quadrant.  This would be the area where advantageous conditions converge: high True Positives with low False Positives[GG[69].
# AUC is a good measure of the tradeoffs involved in classification errors. However, it should not be considered as absolute. Costs of misclassification should be taken into account when using the AUC.
# Computing an ROC curve using the titanic dataset
# Here is an example of plotting and ROC curve on the “titanic” dataset, using a simple logistic regression model to predict suvival.
#install.packages("titanic")
#install.packages("ROCR")

library(titanic)
library(ROCR)

titanic <- titanic_train[complete.cases(titanic_train), ]

model <- glm(as.factor(Survived) ~ Sex+Age+Pclass, data=titanic, family="binomial")
pred <- prediction(predict(model), titanic$Survived)
perf <- performance(pred,"tpr","fpr")
plot(perf)
abline(a=0,b=1)

# The AUC curve is plotted, along with the various cutoff values for the probability of the predicted outcome. The diagonal reference line represents a random model. The area under the logistic model curve looks to be about 75% of the total area.
# 
# 
# Insert Image B05033_02_09.png
# As mentioned earlier, the AUC is used for comparing models.  Here is the AUC for the logistic model, using only Age as a factor.
model2 <- glm(as.factor(Survived) ~ Age, data=titanic, family="binomial")
pred <- prediction(predict(model2), titanic$Survived)
perf <- performance(pred,"tpr","fpr")
plot(perf,main="AUC for Logistic Regression Titanic Model - Age Only")
abline(a=0,b=1)

# We can see immediately that this single variable model has little predictive power.  The AUC “curve” is similar the the random diagonal reference line above, which indicates no predictive power.
# 
# 
# 
# 
# In Sample / Out of sample tests, walk forward tests
# 
# After a model has been developed, it is considered best practice to validate the results against other data
# Training/Test/Validation Datasets
# Training data is data that is used to build the predictive data.  Test data, also known as a hold-out sample, is data which was not used in the training process. Test data is used to see if a trained model is able to generalize its results to another data set which was not part of the model training.
# However, even though the test dataset is not used in the training of the model, the contents are usually viewable by the modeler during model development.
# A validation set is a 3rd dataset which is sometime used to further benchmark the model results.  Validation data is also data that has never been seen before, which is incorporated AFTER the model has passed validation against the test dataset, and prior to deployment.  Validation datasets are often brought from a completely different source from the original training/test data source, the goal being to provide a 2nd corroboration, or refuting of the model results.
# Along with Training, Test, and Validation data, you will also hear some other terms which are related:
# * In-sample data refers to the data which was used to fit (model) the data, and it used on the training data set.  
# * Out-of-sample data refers to data not used to fit the data.
# That means that out-of-sample data is typically used only on the Test and Validation data sets.  Another technique to validate the data is known as k-fold cross-validation. This technique will use multiple “folds” to define different subsets of in-sample and out-of-sample datasets, in order to perform multiple iterations of model testing in order to randomize the selections. 
# Time Series Validation
# Of course time series models also use this concept, however time periods alone can be used to partition test and training data : e.g a model might be built on the previous 5 years of historical data (training), and then “forecast” on the current 6th year of data (testing or validation data).
# Variations of this are common. A “walk forward” testing modeller will develop a time series model on years 1-5, test the results on year 6, and then develop a similar model on years 2-6, and then test the results on year 7. This procedure would be repeated until there is no more data to test. In all this cases the model is built on “in-sample” data, and tested on “out-of-sample” data. similar to k-fold validation. 
# 
# Benchmark against best “Champion” model 
# In Champion/Challenger model development, you currently have a deployed stable “Champion” model in which you can benchmark any future results. This allows you to discard any model results which fall far below this benchmark.  If you do not have a current “Champion”, you can develop a theoretical “Best” model, using an algorithm such as Random Forests or SVM, and use that as a benchmark for what is achievable, but (assume) is not actionable. Look at the results of the model you have just developed and see if it is close to those kinds of results.  If so, the results are probably not attainable, and you might want to look elsewhere.
# Expert Opinions: Man vs. Machine 
# This is often done with classification problems, and it essentially pits man vs. machine.  If an expert agrees with a lot of what your model spits out, that is another reason to deem it valid.
# Meta-Analysis
# Much has been written about junk science and how there is always another study which produces the opposite results from a previous one.  “p-value hacking” is one way to do this. We have already mentioned “Metadata” which is “Data about data”.
# Meta-Analysis is the “study of studies”, in which a research will look at all of the previous analyses, and report what they all have to say about outcomes in totality. If your analysis agrees with other similar analyses that have been performed in the past, that would be more evidence to support your model[GG[70]
# Dart Board Method
# In some instances, you need not have only 1 model to predict the outcome.  If you accept the view that “All models are useful”, why not use some of them at the same time?  This is used extensively in marketing campaign management, and financial portfolio management.  Sometimes, it pays not to put all of your eggs on one basket. One model can fail to work during 1 month, but is offset with positive results from another model. Ensemble modelling, which is similar, can also incorporate several diverse models at the same time, but usually there is a single outcome, and may be subject to overfitting.
# Step 6 Deployment 
# Deployment of a model is the process by which you put your models into a real world production setting. This can depend on many factors, such as the environment in which it was developed, the algorithm that was chosen, assumptions concerning the data that was made when the model was developed, and of course, the level of the developer.  Often a model is unable to ‘scale’ up to the demands of a production environment, and knowing your possible production environment in advance will dictate what problems or techniques are feasible.
# Model Scoring
# Model Scoring makes the model actionable.  If you develop a model, and you are unable to apply the results to new data, then you will be unable to do any prediction on an ongoing basis.   New model scoring often involves output the development model outputs to a real time scoring engine.  That engine is often Java, or C++.   How that is performed varies vastly depending upon the modelling technique.  Sometimes the scoring is performed separately, so it can be optimized for efficiency.
# Regression type models are relatively easy to score, since all that is need are the models coefficients and intercepts.  Other types of models need a little more work.  For example, Decision Tree software should be able to output a set of decision rules which would enable to production language to recode it using a series of “If/Then/Else” rules. Software package often output the decision Rules which were determined for each node.
# Certain production packages will accept PMML input. PMML is a common language is a language which is used to facilitate translate one languages model specification into a common format.
#  For more complicated models it may be necessary to have production versions of the model on a separate production machine, and run the model using similar code to what was used for development.
# Summary
# In this chapter, we learned about the various structured approaches to predictive analytics and how implementing an analytics project in a methodical way can enhance the success of an analytics project through collaboration and communication.  We went through the various steps of the CRISP-DM methodology and demonstrated tools that you could use to help you progress along these steps.
# We discussed the benefits of sampling and how it could speed up your project.  SQL was demonstrated to illustrate basic charts and plots, so that you can begin to develop insight even before you created a first model.    We showed that data simulation could also be used at the data understanding phase, as a preliminary modeling tool to do ‘what ifing’,  even before actual company data is obtained.
# We learned about the various types of data that you will encounter, and showed some examples of  independent and dependent variable are, and the importance of doing preliminary 1 way and 2 way variable analysis as a precursor to modeling.
# Finally, we learned about some of the basic predictive models that we will be using later on, and discussed the importance of the bias/variance tradeoff when starting to examine which types of predictive models you might want to employ.
# We ended with discussing some best practices for evaluating a model, and discussed the importance of planning for the eventual deployment of models into production, and how that could alter your development process.
# 
# In the next chapter, we will focus more upon getting the data into a form suitable for actual predictive modeling, with the focus on data cleaning, outliers, missing values, and some data reduction and transformation techniques.
# 
# References
# Determine the Root Cause: 5 Whys. (n.d.). Retrieved from https://www.isixsigma.com/tools-templates/cause-effect/determine-root-cause-5-whys/
# Gettysburg Address. (1863, November 19). Retrieved from Abraham Lincoln Online: http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm
# Stevens, S. (1946). On the Theory of Scales of Measurement. Science.
# Wikipedia. (n.d.). Bias Variance Tradeoff. Retrieved from Wikipedia: https://en.wikipedia.org/wiki/Bias%E2%80%93variance_tradeoff
# Notes
# Random Forests(tm) is a trademark of Leo Breiman and Adele Cutler and is licensed exclusively to Salford Systems for the commercial release of the software.

 
