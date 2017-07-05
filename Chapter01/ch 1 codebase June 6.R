setwd("C:/PracticalPredictiveAnalytics/R")
getwd()
#[1] "C:/PracticalPredictiveAnalytics/R"
# 
# 
# I suggest using getwd and setwd liberally, especially if you are working on multiple projects, and want to avoid reading or writing the wrong files.
# The Source Window
# The Source window is where all of your R Code appears.  It is also where you will be probably spending most of your time. You can have several script windows open, all at once.
# Creating a new Script
# To create a new script select "File/New File/R Script" from the top navigation bar.   A new blank script window will appear with the name "Untitled1".
# Once it appears you can start entering code!
#   
#   B05033_01_05.png
# Our First Predictive Model
# Now that all of the preliminaries are out of the way, it is time to jump into starting to code our first simple predictive model. There will be 2 scripts written to accomplish this. 
# Our first R script is not a predictive model (yet), but it is a preliminary program which will view and plot some data.  The data set we will use is already built into the R package system, and is not necessary to load externally.   For quickly illustrating techniques, I will sometimes use sample data contained within specific R packages themselves in order to demonstrate ideas, rather than pulling data in from an external file. In this case our data will be pulled from the "datasets" package, which is loaded by default at startup.
# .	Paste the following code into the "Untitled1" scripts that was just created. Don't worry about what each line means yet.  I will cover the specific lines after the code is executed.
require(graphics)
data(women)
head(women)
View(women)
plot(women$height,women$weight)
# 
# .	Within the code pane, you will see a menu bar right beneath the "Untitled1" tab. It should look something like this:
#   
#   
#   
#   .	To execute the code, Click the "Source" Icon.  The display should then change to the diagram below:
#   
#   
#   B05033_01_06.png
# Notice from the picture below that three things have changed:
#   1.	Output has been written to the console pane
# 2.	The View pane has popped up which contains a two column table.
# 3.	Additionally, a plot will appear in the Plot pane 
# Code Description
# 
# Here are some more details on what the code has accomplished.
# 
# Line 1 of the code contains the function "require", which is just a way of saying that R needs a specific package to run.  In this case require(graphics) specifies that the graphics package is needed for the analysis, and it will load it into memory.  If it is not available, you will get an error message.  However, "graphics" is a base package and should be available
# 
# Line 2 of the code loads the "Women" data object into memory using the data(women) function. 
# Lines 3-5 of the code display the raw data in three different ways:
#   
#   1.	View(women) - This will visually display the dataframe. Although this is part of the actual R script, viewing a dataframe is a very common task, and is often issued directly as a command via the R Console. As you can see in the figure above, the "Women" data frame has 15 rows, and 2 columns named height and weight.  
# 
# 2.	plot(women$height, women$weight) - This uses the native R plot function which plots the values of the two variables against each other.  It is usually the first step one does to begin to understand the relationship between 2 variables. As you can see the relationship is very linear.
# 
# 3.	head(women) - This displays the first N rows of the women  data frame to the console. If you want no more than a certain number of rows, add that as a 2nd argument of the function.  E.g.  Head(women,99) will display UP TO 99 rows in the console. The tail() function works similarly, but displays the last rows of data.
# 
# Saving the script
# To save this script, navigate to the top navigation menu bar and select "File/Save". When the file selector appears navigate to the PracticalPredictiveAnalytics/R folder that was created, and name the file "Chapter1_DataSource".  Then select "Save".
# 
# Your 2nd script
# Our 2nd R script is a simple two variable regression model which predicts women's height based upon weight. 
# Begin by creating another Rscript by selecting "File/New File/R Script" from the top navigation bar.  
# If you create new scripts via "File/New File/R Script"  often enough you might get "Click Fatigue" (uses 3 clicks), so you can also save a click by selecting the icon in the top left with the + sign.
# 
# 
# 
# Whichever way you choose , a new blank script window will appear with the name "Untitled2"
# Now Paste the following code into the new script window
require(graphics)
data(women)
lm_output <- lm(women$height ~ women$weight)
summary(lm_output)
prediction <- predict(lm_output)
error <- women$height-prediction
plot(women$height,error) 

# Press the "Source" icon to run the entire code.  The display will change to something similar to what is displayed below:
#   
#   
#   B05033_01_07.png
# 
# Code Description
# Here are the notes and explanations for the script code that you have just ran:
#   Line 3 - lm() function: This function runs a simple linear regression using the  lm() function. This function will run a linear regression which predicts woman's height based upon the value of their weight.  In statistical parlance, you will be 'regressing' height on weight. The line of code which accomplishes this is:
#   
#   lm_output <- lm(women$height ~ women$weight)
# 
# There are two operators, and one function that you will become very familiar with when running Predictive Models in R.
# 
# 1.	The ~ operator (also called the tilde) is an expression that is used when specifying a formula in R. In a predictive context, is a shorthand way for separating what you want to predict, with what you are using to predict.   What you are predicting (the dependent or Target variable) is usually on the left side of the formula, and the predictors (independent variables, features) are on the right side. In the formula, I have specified them explicitly by using the data frame name together with the column name, i.e. women$height (what you are predicting) and women$weight (predictor)
# 
# 2.	The <- operator (also called assignment) says assign whatever function operators are on the right side to whatever object is on the left side.  This will always create or replace a new object that you can further display or manipulate. In this case we will be creating a new object called lm_output, which is created using the function lm(), which creates a Linear model based on the formula contained within the parentheses. 
# 
# 
# Note that the execution of this line does not produce any displayed output.  You can see if the line was executed by checking the console.  If there is any problem with running the line (or any line for that matter) you will see an error message in the console.
# Line 4 - summary(lm_output): The summary function is a generic R function which works on many different types of R objects. In this case, summary() will summarize the results of the linear regression output. 
# The results will appear in the Console window as pictured in the figure above.  Just to keep thing a little bit simpler for now, I will just show the first few lines of the output, and underline what you should be looking at. Do not be discouraged by the amount of output produced.
# First look at the lines marked (Intercept), and women$weight which appear under the Coefficients line in the console.
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  25.723456   1.043746   24.64 2.68e-12 ***
#   women$weight  0.287249   0.007588   37.85 1.09e-14 ***
#   
#   The Estimate Column illustrates the linear regression formula needed to derive height from weight.  We can actually use these numbers along with a calculator to determine the prediction ourselves. For our example the output tells us that we should perform the following steps for ALL of the observations in our dataframe in order to obtain the prediction for height.  We will obviously not want to do all of the observations (R will do that via the predict() function below), but we will illustrate the calculation for 1 data point.
# .	Take the weight value for each observation. Let's take the weight of the first woman which is 115 lbs.
# .	Then,multiply weight by 0.2872 .  That is the number that is listed under Estimate for womens$weight.  Multiplying 115 lbs. by 0.2872 yield 33.028
# .	Then add 25.7235 which is the estimate of the (intercept) row. That will yield a prediction of 58.75 inches.
# If you do not have a calculator handy, the calculation is easily done in 'calculator' mode via the R Console, by typing the following:
#   
#   The Predict function
# To predict the value for all of the values we will use a function called predict(). This function reads each input (independent) variable and then predicts a target (dependent) variable based on the linear regression equation.  In the code we have assigned the output of this function to a new object named "prediction". 
# Switch over to the console area, and type "prediction", then Enter, to see the predicted values for the 15 women. The following should appear in the console.

prediction
length(error)
#[1] 15
# 
# In all of the above cases, the counts all compute as 15, so all is good.
# If we want to see the raw data, predictions, and the prediction errors for all of the data, we can use the cbind() function  (Column bind) to concatenate all three of those values, and display as a simple table.
# At the console enter the follow cbind command.
cbind(height=women$height,PredictedHeight=prediction,ErrorInPrediction=error)
height PredictedHeight ErrorInPrediction
# 1      58        58.75712       -0.75711680
# 2      59        59.33162       -0.33161526
# 3      60        60.19336       -0.19336294
# 4      61        61.05511       -0.05511062
# 5      62        61.91686        0.08314170
# 6      63        62.77861        0.22139402
# 7      64        63.64035        0.35964634
# 8      65        64.50210        0.49789866
# 9      66        65.65110        0.34890175
# 10     67        66.51285        0.48715407
# 11     68        67.66184        0.33815716
# 12     69        68.81084        0.18916026
# 13     70        69.95984        0.04016335
# 14     71        71.39608       -0.39608278
# 15     72        72.83233       -0.83232892
# 
# 
# From the output above, we can see that there are a total 15 predictions. If you compare the ErrorInPrediction with the error plot shown above, you can see that for this very simple model, the prediction errors are much larger for extreme values in height (shaded values).
# Just to verify that we have one for each of our original observations we will use the nrow() function to count the number of rows.
# At the command prompt in the console area, enter the command: 
nrow(women)
# 
# The following should appear:
# 
# >nrow(women)
# [1] 15
# 
# Line 7 - plot(women$height,error) :This plots the predicted height vs. the errors.  It shows how much the prediction was 'off' from the original value.  You can see that the errors show a non-random pattern. 
# 
# After you are done, save the file using "File/File Save", navigate to the PracticalPredictiveAnalytics/R folder that was created, and name it Chapter1_LinearRegression
# R packages
# An R package extends the functionality of basic R.  Base R, by itself, is very capable, and you can do an incredible amount of analytics without adding any additional packages.  However adding a package may be beneficial if it adds a functionality which does not exist in base R, improves or builds upon an existing functionality, or just makes something that you can already do easier.
# For example, there are no built in packages in base R which enable you to perform certain types of machine learning (such as Random Forests).  As a result, you need to search for an add on package which performs this functionality.  Fortunately you are covered.  There are many packages available which implement this algorithm.
# Bear in mind that there are always new packages coming out. I tend to favor packages which have been on CRAN for a long time and have large user base. When installing something new, I will try to reference the results against other packages which do similar things.  Speed is another reason to consider adopting a new package. 
# 
# 
# The Stargazer Package
# 
# For an example of a package which can just make life easier, first let's consider the output produced by running a summary function on the regression results, as we did above.  You can run it again if you wish. 
# 
summary(lm_output)
# 
# The amount of statistical information output by the summary function can be overwhelming to the initiated. This is not only related to the amount of output, but the formatting. That is why I did not show the entire output in the above example.
# One way to make output easier to look at is to first reduce the amount of output that is presented, and then reformat it so it is easier on the eyes. 
# To accomplish this, we can utilize a package called "stargazer", which will reformat the large volume of output produced by summary and simplify the presentations. Stargazer excels at reformatting the output of many regression models, and displaying the results as HTML, PDF, Latex, or as simple formatted text. By default, it will show you the most important statistical output for various models, and you can always specify the types of statistical output that you want to see.
# To obtain more information on the stargazer package you can first go to CRAN, and search for documentation about stargazer, and/or you can use the R help system:
# IF you already have installed stargazer you can use the following command:
# packageDescription("stargazer")
# If you haven't installed the package, information about stargazer, (or other packages) can also be found using R specific internet searches:
RSiteSearch("stargazer")
# If you like searching for documentation within R, you can obtain more information about the R help system at::
# https://www.r-project.org/help.html
# Installing Stargazer
# Now, on to installing stargazer:
# .	First Create a new R script (File/New File/R Script).  
# .	Enter the following lines and then select "Source" from the menu bar in the code pane, which will submit  the entire script.  
# 
install.packages("stargazer")
library(stargazer)
stargazer(lm_output, title="Lm Regression on Height", type="text")
# 
# After the script has been run, the following should appear in the Console:
# 
# B05033_01_08.png
# Code Description
# Line 1: install.packages("stargazer")
# The line above will install the package to the default package directory on your machine. If you will be rerunning this code again,, you can comment out this line, since the package will have already be installed in your R repository.   
# 
# Line 2: library(stargazer)
# Installing a package does not make the package automatically available.  You need to run a library (or require) function in order to actually load the stargazer package. 
# 
# Line 3: stargazer(lm_output, title="Lm Regression on Height", type="text")
# 
# This part of the code will take the output object lm_output, that was created in the first script, condense the output, and write it out to the console in a simpler, more readable format.  There are many other options in stargazer, which will format the output as HTML, or Latex.   Please refer to the Reference manual at  https://cran.r-project.org/web/packages/stargazer/index.html
# 
# 
# The reformatted results will appear in the R Console. As you can see, the output written to the console is much cleaner and easier to read
# Saving your work
# After you are done, select "File/File Save" from the menu bar
# Then navigate to the PracticalPredictiveAnalytics/Outputs folder that was created, and name it Chapter1_LinearRegressionOutput.  Press Save. 
# 
# Summary
# In this chapter, we have learned a little about what predictive analytics is and how they can be used in various industries. We learned some things about data, and how they can be organized in projects.  Finally, we installed RStudio, and ran a simple linear regression, and installed and ran our first package. We learned that it is always good practice to examine data after it has been loaded into memory, and a lot can be learned from simply displaying and plotting the data. 
# In the next chapter, we will discuss the overall predictive modeling process itself, introduce some key model packages using R, and provide some guidance on avoiding some predictive modeling pitfalls.
# References
# Computing and the Manhattan Project. (n.d.). Retrieved from http://www.atomicheritage.org/history/computing-and-manhattan-project
# Gladwell, M. (2005). Blink :the power of thinking without thinking. New York: Little, Brown and Co.,.
# Linda Miner et al. (2014). Practical Predictive Analytics and Decisioning Systems for Medicine. Elsevier.
# Watson (Computer). (n.d.). Retrieved from Wikipedia: https://en.wikipedia.org/wiki/Watson_(computer)
# Weather Forecasting through the Ages. (n.d.). Retrieved from http://earthobservatory.nasa.gov/Features/WxForecasting/wx2.php
