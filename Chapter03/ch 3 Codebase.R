# 3
# Inputting and Exploring Data
# On two occasions I have been asked, "Pray, Mr. Babbage, if you put into the machine wrong figures, will the right answers come out?" ... I am not able rightly to apprehend the kind of confusion of ideas that could provoke such a question.
# ---Charles Babbage
# In this chapter we will cover Inputting and Exploring Data. In the first two chapters we covered processing some data sets which already reside within R packages. We purposefully avoiding reading any external data sources.  However, now we will. The Inputting Data section will cover various mechanisms for reading your own data into R.
# The  Exploring Data section covers some techniques you can use to implement successful completion of the 2nd and 3rd of the “Data Understanding” and “Data Preparation” steps of the CRISP_DM Process we covered in the last chapter.
# Some of the topics we will cover include:
# •	Getting data into R
# •	Generating your own data
# •	Munging, Joining data 
# •	Data cleaning Techniques
# •	Data Transformations 
# •	Analyzing missing values and outliers
# •	Variable Reduction Techniques
# 
# Data input
# Data by itself is just a pure stream of a numerical “something”. It is the analytics process, which turns this something into knowledge, but before we start understanding it, we have to be able to obtain it. The number of ways in which we can now generate data has grown exponentially. Progressing from fixed length format, through HTML, and then to free form unstructured input, and then to today’s “schema on read” technologies.  There are so many different data formats today that there is a very good chance that you haven’t, and will never work with a few of them.  Reading data in, understanding the variables and what the data represents can also be incredibly frustrating. Integrating the data with other sources both internal and external can seem like a jigsaw puzzle at times.  At time, the data will not seem to fit as nicely as you would hope it to be.
# However, with regard to raw input, most people will work with a couple of common formats in the course of their work, and it will be useful to know about how to utilize them.
# Text file Input
# The most convenient way to read data into a predictive analytics project is via an inputtext file. Text files are convenient and work well for small and medium projects. You can examine text files using many different kinds of programs in human readable form.However, as the data gets larger, it may be that storing data in text files become to be a bit unmanageable, and you might have to turn to retrievingdirectly from data warehouses, both from the SQL and NoSQLvariety, and possibly incorporate ecosystems such as Spark and Hadoop which you will begin to use parallel processing and memory managementtechniques.
# The read.table function
# The basic function for reading text files is read.table. The most important information to supply to this function is a file name, a separator, and whether or not a row header is included.  There are also some other important options to consider when reading in a file using read.table:
# •	Header – Set to header=TRUE if the first line of the input data contains column header information.
# •	col.names– If you will be supplying your own column names, use this option to specify the columns names in a vector
# •	na.string – The default for this is NA; however, input data contains a variety of codes that can represent NA, or can even have multiple NA values.  Sometimes, the values 0,9, or other characters such as ‘.’ can be used to represent a missing value.
# •	ColClasses– Use this option if you want to specifically read an input data item as a specific data type, e.g. string, int, factor etc.  Supply ColClasses as a vector of character types. This option is often supplied after an initial read of the data, when you discover the default data type is not what you want it to be, and you will be forcing a reading of the particular variable with the specific data type specified.
# •	stringsAsFactors - If this option is specified as TRUE, it will coerce the character input into a factor.  Factors are a special representation of character categorical variables, which are represented internally as integers.  Setting a character variable as a factor makes it more efficient to analyze as categorical variables, but makes it is a little more difficult to perform strict text processing, for example string manipulation.  However, there are ways around these by using functions, which “cast” data types into alternative data types.
# Generally, it is a good idea to set stringsasFactors to FALSE, if you will be doing a lot of string manipulations. However, factors are much more useful for analytic packages, and most of the time variables aa required to be in factor format. But, there are ways to convert the variables from characterto factor, or vice versa, and only becomes important when your code reaches production, or when you want to conserve memory
# 
# •	sep- This separator value enables the function to separate one field from another.  It is typically a comma, or a tab.
# 
# Along with the read.table function, there are also other specific functions which were developed for specialized purposes which derive from read.table:
# •	read.csv– read.csv is used for files which are comma delimited and which use a period in numeric values.  CSV data is the most common text file format. Virtually all data applications have the ability to read or write to this format, so this is an inherent advantage to be well versed in using this format.   However, CSV input can be slow, and usually works “out of the box” for well-behaved data. There are functions which you might want to use down the line which have better input performance (such as the functions fread or scan), but read.csv is a good place to start for reading csv files if you just want to get going quickly.
# •	read.csv2– It is similar to read.csv but uses a semicolon to separate values and uses a comma as a decimal point placeholder. For example, this is useful when reading in Euro’s which uses a comma to separate the whole number from the decimal portion as the following code illustrates.

#Read in a single pencil costing $1.20

#RW
setwd("C:/PracticalPredictiveAnalytics/Outputs")
cat("Product,Cost",file="outfile.txt",sep="\n")
cat("Pencil,1.20",file="outfile.txt",sep="\n",append=TRUE)
read.csv("outfile.txt")

#Read in a single pencil costing €1,2
cat("Product,Cost",file="outfile.txt",sep="\n")
cat("Pencil;1,20",file="outfile.txt",sep="\n",append=TRUE)
read.csv2("outfile.txt", sep=";")
# •	read.delim - Use this for Tab delimited files with period as decimal placeholder. 
# •	read.delim2–This is the same as read.delim, but uses a comma as the decimal placeholder
# •	read.fwf- this will process data with a predetermined number of bytes per column. It is somewhat of an older and inefficient way of storing data, yet some legacy data will still be available in this format, so knowing how to use this function is still useful if you will be working with this kind of data
# Database tables
# Database tables reside within Enterprise Data warehouses such as MySQL, SQL Server, or Oracle, or can be housed on local PC’s.  This data can be accessed using R provided correct authentication credentials are supplied. Enterprise data contains some of the best data that you can get your hands on. It is usually considered an “Official” data source which is used across a company. Additionally, in a capable enterprise data warehouse system, data is already vetted, so that saves you the work of checking for data quality. However, data extracted from a Data warehouse can also be complex, and often needs a good data dictionary and metadata to accompany it.
# Data warehouse tables are often optimized for speed.  However, it is necessary to understand the logical and physical data structure of the warehouse, along with the column index structure.  Knowing this will improve your query performance.
# In an Enterprise data warehouse, data is often organized along subject lines, with separate specialized tables for each purpose. Sometimes this leads to redundancy, but the advantage is that all the data you need may be located in just a few tables.
# Reading data directly from database tables circumvent the R memory limitation, to some extent, since some of the processing is done externally to your local PC.  In some instances, parallel processing can be used which will allow you to access very large data sets.
# The usual way of accessing data stored in relational databases is through SQL, ODBC or JDBC connection. Some systems will accept a direct connection. Some specific packages used to connect to databases are listed below:
# •	The RODBC package provides an interface to SQLServer
# •	RMySQL is used to connect to MySQL Databases
# •	ROracle, RJDBC, and RODBC can be used to connect to Oracle databases
# The universal connector for Enterprise databases is ODBC connector.  Since it is a universal, and is single threaded, ODBC tends to be slow. RJDBC provides accesses via a JDBC interface. JDBC is faster than ODBC but will require more tweaking.  Since connecting to a database is a little more involved that just reading a text file, it will take a little more time and work to get thru login ID’s, passwords, and optimizing queries. But once you are familiar with your environment, it will be worth the time spent to optimize access, and avoid calls from the DBA letting you know that your queries are taking too long.
# Spreadsheet Files
# R provides direct interfaces to Excel tables via the XLConnect or xlsx packages. Excel is very prevalent in the corporate world and can contain a lot of useful data, and metadata.  So it pays to learn all about the tools which can access spreadsheets.  It is also worth to learn how to do analytics using spreadsheets, since that will give you valuable insight into the thought process that was used to create the data in the first place.
# However, since Excel is a proprietary product, and has many versions on the market, it still can be tricky to use some of these packages. The most convenient way of importing Excel data is to first access it within Excel itself, and then save it as a delimited file using Excel commands, and then reading it back into R using read.table, or read.csv. If you can’t do it yourself, you can also ask the maintainer of the spreadsheet to write a csv file for you. 
# XML and JSON data
# XML data is used for data interchange in the financial and insurance industry so if you work in those industries, there is a good chance you will come across this format at this point.  No predefined schemas are used in XML, but that also means that there is a fair amount of data parsing which needs to be performed after the data is read, to be able to extract the data itself. The XML() package is used to read XML data into R.
# JSON is another standard derived from Web technologies that was originally used to transmit sets of key pairs between different application systems.  The package JSONLite can be used to parse JSON files.
# Tip:  Still confused about all the different file formats? Try using the “Rio” package with input files.  Rio is a specialized “wrapper” package which is able to identify the type of file in which you wish to read and then call the appropriate package.
# Generating your own data
# Not sure of which data source to use when testing a predictive model?  No problem.  Generate your own data with the built in sample() function, as well as generating random observations based upon distributions such as runif (uniform), rnorm (normal), mvrnorm (multivariate normal), or rpois( poisson counts).  We will also be using a specialized package called “wakefield” which generates typical random values that you would find in many data sources, such as age, gender, education, or customer satisfaction scores, without having to worry about the underlying distributions.
# Tips for dealing with large files
# Some input files can get quite large an inefficient to read. Here are some tips to speed up the process.
# •	Use external Unix Tools for splitting files so that they can be read in chunks. There is usually always a field that you can use to split out separate files.  Date fields are good ones.
# •	Consider using external tools to replace large character strings with numerical or shorter character strings. This will save valuable memory.
# •	Use parameters on input to control how much data you want to read.  You may want to process your input file by starting to read your input at row 1,000,000.  You don’t always have to read a file from the beginning.
# •	Do not feel obligated to always read all of the columns. Once you have determined which columns are truly needed, read only those columns, this will speed up the processing. For example, if you are using read.table, you can specify NULL in the colClasses option to indicate that a column is to be skipped. 
# •	Use the scan, fread, and readlines functions which will give you a greater degree of control over the input, and can make input faster.
# 
# Data Munging, Wrangling etc.
# A large part of preparing the data for analysis utilizes bringing disparate information together, in order to produce the final analytics data set, which will be passed directly to the algorithm.  This process is known by many different names, such as “data munging”, “data wrangling”, ETL, or simply “data prep”.  We have already discussed some ways in which we can read data from a single source. You will be very fortunate if you are able to work with a single data file that has all of the information that you need.  In fact, if you are able to utilize data that is already consolidated, go for it, since someone else has already done the work, and there is no need to try to figure out how to relate them yourself.   However most of the time, you will need to relate at least two different sources, and somehow relate them based upon some common data elements.
# Joining data
# If you find the need to bring together different data sources, SQL is one method for bringing data together.  As mentioned, SQL syntax is common to a lot of environments, so if you learn SQL syntax in R, you have started to learn how data is processed in other environments.  But do not restrict yourself to just SQL.  Other options exist for joining data such as using the “merge” statement.  Merge is a native function which accomplishes the same objective. And some other packages handle data integration fairly well.  I will also be using the dplyr package to perform some of the same tasks as could be done in SQL. 
# The package SQLdf is a standard R package which uses standard SQL syntax to merge, or join two tables together. For relational data, this is accomplished by associating a variable on one table (Primary key) with a similar variable on another associated table. Note that I am using the term ‘table’ in the context of a relational database environment. In the R environment,an SQL table is equivalent to an R dataframe. A R table is a specific R object, which refers to a contingency table produced by a crosstab, or similar function.
# Using the SQLdf function
# This example uses the sqldf, and RSQLlite packages to illustrate some SQL joins, and also uses it to demonstrate reading a csv file with filters. This example also uses the ‘wakefield’ package to generate a hypothetical membership file along with a purchase transaction file.
# Housekeeping and loading of necessary packages
# First clear out the workspace (after saving any R object you will need later).
rm(list = ls())

#Then, install the required packages.
#install.packages("dplyr")
#install.packages("wakefield")
#install.packages("sqldf")
#install.packages("RSQLite")

# The convention in this book will be to specify a simple “install.packages(packagename)” instruction to install the necessary packages, followed by a library(packagename) to load them into memory. Once the required packages are installed, you can either comment them out, or replace the line with conditional installation code such as
# try(require(dplyr) || install.packages("dplyr"))
# 
# But this syntax may not work on all R installations and GUI’s, so we will keep it simple, and explicitly specify install.package().
# Now we will load the required packages into memory.
library(dplyr)
library(wakefield)
library(sqldf)
library(RSQLite)
# Generating the data
# Next, generate the membership file, with 1000 members and assign it to the ‘member’ dataframe. The wakefield package uses specialized functions to generate ‘typical’ values for each of the specified variables. 
# •	The gender function will generate “M”, or ‘F” with a 50% chance of any individual row being a Male or Female. 
# •	The set.seed(1010) directive guarantees that the results will be the same no matter how many times you run the code.
# •	The r_sample_replace function will generate a unique member id with a value from 1 to 1000.
# •	The income, children, employment, level, grad, year, state, and zip_code variables are all randomly generated without supplying any specialized parameters.
# 
# Open up a new script window, and run the following code:
# 
#GENERATE MEMBER
set.seed(1010)
member <- r_data_frame(
  n=1000,
  r_sample_replace(x = 1:1000,replace=FALSE,name="memberid"),
  age,
  gender(x = c("M","F"), prob = c(.5,.5),name="Gender"),
  dob	,
  income,	
  children,	
  employment,	
  level	,
  grade,	
  year,
  state,
  zip_code
)                 


# Similarly, generate the purchases file, and assign it to the ‘purchases’ dataframe.  The total amount purchases will come from a normal distribution with a mean purchases amount of 20,000 and a standard deviation of 1,000.  The “Product” variable is a random product name coming from the letters A-Z
# 
# This next code snippet will generate the purchases:
# 
#GENERATE PURCHASES
set.seed(1010)

purchases <- r_data_frame(
  n=1000,
  r_sample_replace(x = 1:1000,replace=TRUE,name="memberid2"),
  purch=rpois(lambda=1),
  normal(mean = 20000, sd = 1000, min = NULL, max = NULL, name = "TotalAmount"),
  upper(x = LETTERS, k=3, prob = NULL, name = "Product")
)           
purchases$purch <- purchases$purch + 1
str(purchases)

# After generating the purchases data frame, we will write it to an external csv file. The reason we are doing this is to demonstrate how we can filter rowsfrom an external file using read.csv.sql

#WRITE PURCHASES TO FILE

write.csv(purchases, "purchases.csv", quote = FALSE, row.names = FALSE)

# Now we will read the “purchases.csv” back into R.  But instead of reading the whole file, we will only read in those records where the TotalAmount is > 20,000

#read it back in

purchases_filtered  <- read.csv.sql("purchases.csv",sql = "select * from file where TotalAmount > 20000 ")

# You may be asking why we did it this way instead of just reading the whole file and then filtering it later.  The answer is efficiency. Let’s assume that in reality, the purchases file would be much larger than the 1,000 records it really is, and would contain lots of small purchases.  We wouldn’t want to take up processing time by reading all of these small transactions, sincewe are only interested in looking at high value members. So you can filter the data while reading the file, and only read in those members who had purchases greater than 20,000. 
# Examining the metadata
# After reading in any file, it is always a good practice to verify the number of rows, and look at the metadata, after a dataframe is created.  We can do that easily with the str() function. The str() function is an incredibly useful function which is packed with a lot of the type of “metadata” information that we discussed in Chapter 2.  It is always a good idea to run a str function every time you read, merge, join, or create a new file.
# 
str(member)
str(purchases)
str(purchases_filtered)


 
# Insert image B05033_03_01.png
# If you switch over to the Console, you can see that both member and purchases have 1000 rows, and purchases_filtered dataframe has 489 rows. Looking across the TotalAmount row in str(purchases_filter) suggests that all of the purchases are all in fact > 20,000.
# Always take a look at the number of missing values (NA’s), and the levels specified for all of the Factors. There are no missing values in the data. Look for any situations in which character variables should be treated as Factors, and v.v.  For example, the Product variable is listed as a character (chr), when it should probably be treated as a factor.  We can always switch the type later.
# If you just want to see the number of rows created, you can use the nrow function, instead of str 
# 
nrow(member) #1000 members
nrow(purchases_filtered) #489
# Merging data using Inner and Outer Joins
# Now let’s merge the membership file with the purchases. In SQL there are two kinds of merges that you can consider when associating two dataframes.  An “Inner Join” will consolidate two records based on the matching of a single or multiple key in which they both have in common.  An outer join will also merge the two tables together by keys, but will also include any rows which are not matched. You can identify an outer join by observing the existence of NA’s in any of the matching keys. Inner joins are usually more efficient, but should only be used if you expect to have matching keys of both of the joined files.
# Join2 is an inner join which will contain only those members which had a purchase record. Sqldf will match all the observations by memberid. 
# 
join2 <- sqldf("select * from 'member' inner join 'purchases_filtered' on 
member.memberid=purchases_filtered.memberid2")

# Immediately after the join, perform a str function on join2.

str(join2)


# The str() function will show that there are 489 observations, indicating that not all members had purchases
# 
#  
# Insert image 5033_03_02.png
# In cases where you do not always expect to always have matches from two files, an outer join is usually better. Join3 will merge members with their purchase records, but will also result in including all members who didn’t have any purchase records. This is accomplished by using the ‘outer join’ clause. After joining the dataframes, issue a str and nrow function to verify the number of rows.  There should be 1,105 rows in the data frame.  This is more than the number of members. This is due to the fact that members had multiple purchases.
join3 <- sqldf("select * from member left outer join purchases_filtered on member.memberid=purchases_filtered.memberid2 order by member.memberid")
str(join3)
nrow(join3) 

#View the output from join 3 for columns 1, and 8-16 corresponding # to the order #given in str()

View(join3[,c(1,8:16)])

# The View function is a convenient way to peruse parts of your results to try to reconcile any anomalies. After issuing the View command for selected columns off dataframe “join3”, we can see that memberid 4 had multiple purchases.  We can also quickly see which members had no purchases (memberid’s 7 and 8).  In the cases in which there were no purchases by a member, the purchase information is included as variables, but NA’s are filled in for the purchase variable fields.

 

# Insert image B05033_03_03.png
# 
# 
# 
# This type of join is known as a “1 to many join”.  For this example, there can only be 1 member records, but there can be many purchase records.
# Identifying members with multiple purchases
# Try this query on your own, in a new script to determine which members had multiple purchases. There should be 89 of them. In SQL query parlance, the “multiple purchases” clause is indicated in the query by “count(*) > 1”

dups <- sqldf("select member.memberid,count(*) from 
          member left outer join 
          purchases_filtered on 
           member.memberid=purchases_filtered.memberid2 
                group by member.memberid having count(*) > 1")
# Eliminating Duplicate records
# In many cases, you will only want to retain 1 record which results from a join. Let’s say we only want to keep 1 record for each memberid, and we want it to be the highest TotalPurchase for each member. To eliminate duplicates, we can first sort the data frame by memberid, and TotalPurchase amount.  Then we will use the rev and duplicated functions to keep only the last purchase record for each memberid.  This will leave us with one record for each of the original 1000 members.

join3 <- join3[order(join3$memberid, join3$TotalAmount),]
View(join3)
dedup <- join3[!rev(duplicated(rev(join3$memberid))),]
nrow(join3)
nrow(dedup)

# > nrow(join3)
# [1] 1105
# > nrow(dedup)
# [1] 1000
# Exploring the Hospital Data Set
# Exploratory Data Analysis is a preliminary step prior to data modelling in which you look at all of the characteristics of data, in order the get a sense of data distributions, correlations, missing values, outliers, and any other factors which might impact future analyses.  It is a very important step, and if performed diligently, will save you a lot of time later on.
# For the following examples we will read the “NYC Hospital Discharges” dataset.  (Hospital Inpatient Discharges (SPARCS De-Identified): 2012, n.d.) This example uses the read.csv function to input the delimited file, and then uses the View function to graphically display the output.  Then the str function is used to display the contents of the “df” dataframe which was just created, and then finally, the summary() function displays all of the relevant statistics on all of the variables.  These are all typical first steps to perform when looking at data for the first time.
# 
df <-read.csv("C:/PracticalPredictiveAnalytics/Data/NYC Hospital Discharged 2012 Medicare Severe.csv",na.strings= c(" ", ""))
str(df)
# Output from the str(df) function
# The str() function is an important function to run after you create a new data object. If you examine the output from the str(df) function in the log, you will see that the default read.csv function you have just run has defined each of the variables in the data as either numeric or factor.  While at this point it is OK to leave it as is, we will eventually want to change the data type for this variables since “Length.of.Stay” is not a factor, it is an integer.  Alternatively, we can perform another read.csv which specifies the exact data type that we want, specifying the ColClasses vector.  I usually like to look at a small data set sample first, and then determine what the data type should be, and then input the data again. 
# Another thing to notice about the read.csv statement is that missing values are specified as blank values via the na.strings option.
# The str() is also important in terms of clueing you in as to what variables can be excluded from the analysis, even before frequency distributions have been run. For example, the variable APR.Severity.of.Illness. Description, and Payment.Typology.1 have only 1 level, so we will exclude that from the analysis, since there will be no variability in the data.
# 
#  
# 
# Insert image B05033_03_04.png
# Output from the View function
# Aside from using the head and tail commands, a quick view of the data using the “View” command can be helpful.  Scroll up and down, and to the left and right, and examine the type of values that are representative, and whether or not they are populated. Viewing the data can also give you some idea on how the data may be sorted or grouped.
#  
# Insert image B05033_03_05.png
# The colnames function
# Running the colnames() function is a convenience way of obtaining the index numbers for each of the variables.  Using index numbers in R functions are a convenient and fast way of referencing variables. However, changes in file formats can change the ordering, so using this method is only recommended for interactive use.
# 
#  
# B05033_04_06.png
# To simplify the example, we will eliminate variables12,13,16,19,20,21 from the analysis 
# 
# 
# The summary function
# The summary function is a convenient way to get a snapshot of the distribution of the variables.  For numeric variables it will give you the 6 important distribution statistics (mean, min, max, 1st, 5th, and 3rd quartiles). The function will return a lot of information quickly. For a large number of variables, the output of the summary function can be overwhelming (and not pretty!). 
# To limit the output, we will use the column numbers obtained above, and run the summary function which exclude columns 12,13,16,19,20,21.
summary(df[,-c(12,13,16,19,20,21)],maxsum=7)
# Or you would rather not use the index numbers and prefer using variable names, you can get the same results with the following code:
exclude_vars <- names(df) %in% c('CCS.Diagnosis.Description','CCS.Procedure.Description','APR.Severity.of.Illness.Description','Payment.Typology.1','Payment.Typology.2','Payment.Typology.3')
# 
summary(df[!exclude_vars],maxsum=7)

# Look at the output from the summary function, and observe the distribution of the variables.  Look for variables which seem to be under of overrepresented.  Does the distribution for Hospital Country reflect the population of the 5 NYC boroughs? The Age Group is skewed toward the older population, but what are the causes of the 5 cases in the 0-17 Age group. A lot of information can be gained from just looking at summary statistics, and these are the type of questions that should be posed at this point.
#  
# Insert image B05033_03_07.png
# 
# Sending the output to an HTML file
# 
# Since the output from summary is not pretty for a large number of variables, you can also format the output as HTML and send it to a file where you can view the results in a browser.  We will illustrate one way to do it via the R2HTML package.
# In the code below, all output from HTMLStart to HTMLStop is send to the file and directory specified.

#Install.packages(“R2HTML”)
library(R2HTML)
#RW changed
HTMLStart(outdir="C:/PracticalPredictiveAnalytics/Outputs",file="MedicareNYCInput",extension="html",HTMLframe="FALSE")
summary(df[,-c(12,13,16,19,20,21)],maxsum=7)
HTMLStop()

# After the HTMLStop() command is written, the log shows that the output has been written to an HTML file.
#  
# 
# Open the file in the browser
# Next. Open up the file in the browse of your choice.  You will see the summary statistics displayed as 1 column per variable, which should correspond with output generated from the previous summary.  You may need to scroll up/down, or left/right to see all of the variables.
#Rw
browseURL("MedicareNYCInput.html") 

# Plotting the distributions
# Creating a matrix plot of the variables is also a good preliminary step to perform, since it will immediately let you see the shape and distributions of the variables, and well as point out any gaps in the data. After remove some of the columns from the dataframe that we know we are not going to use, we can see that out dataset is fairly clean, and that the variables line up pretty much as we expect. For example, Admit Day of week is fairly normally distributed, however we can see that there is a lull in the number of discharged at mid-week. Costs are skewed, with very high values (but with low occurrences) at the extremes.
# 
df <- df[,-c(12,13,16,19,20,21)]

# Visual Plotting of the variables
colors = c("blue","green3","orange")
numcols <- length(names(df))
par(mfrow=c(3,5))
for(i in 1:numcols){
  if(is.factor(df[,i])){
    if( as.integer(nlevels(df[,i]) <= 20) ) plot(df[,i],main=names(df)[i],col=colors)
  }
  else{hist(df[,i],main=names(df)[i],xlim=c(0,300000),breaks=100,xlab=names(df)[i],col=colors)
  }
}

 
# B05033_03_08.png
# Breaking out summaries by groups
# Following an initial inspection of the data, it is a good idea to look at various summary statistics of the target variable broken down by some of the categories (or Factors).  We could do this using SQL, however for this example we will use another useful package called dplyr, which has syntax which is “SQL like”, and it should be easy for anyone familiar with SQL and/or Linux to pick up. 
# The goal is to break down the Total.Costs, by some of the factors to see if we can see any differences in costs among the levels.  Let’s start with something easy, by breaking out these Total.Costs by the day of the week. We will do this by ‘piping’ the df dataframe to the dplyr “group by” command, which will then send it to a summarize function which will compute the counts, means, and sums of Total.Costs.  Finally, the %>% operator will send (or pipe) the output to the View function which appears below.
library(dplyr)
df %>% group_by(Admit.Day.of.Week) %>% summarize(total.count=n(),sum(Total.Costs),mean(Total.Costs)) %>% View()

 
# Insert image B05033_03_09.png
# 
# The Total.Costs seems to be roughly equal for the different days of the week. If you are now running your project with a particular methodology, this might also be a good time to keep trackof the results somewhere in one of your results folders, and note that you need to perform a statistical test, such as a t-test or an ANOVA, to test for significant differences among the days of the week.
# Standardizing data
# There are a couple of more transformations that we can perform on our Hospital data set. 
# We would like to standardize both the Total.Costs and the Total.Charges, so that we can compare them more easily. Predictive models like to see variables standardized because there is less bias towards any particular variable, since all standardized variables have approximately the same magnitude.
# The way we do this is by “normalizing” the means to 0, with a standard deviation of 1.  Computational means that we will take each value, subtract the mean and divide the results by the standard deviation. 
# In previous examples we have explicitly referred to variables using their full name (e.g df$Total.Costs which refers to the Total.Costs variable within the df dataframe). If you will be referring to many variables within a single dataframe, it sometimes makes sense to issue an attach statement, which will allow you to use the variable without the dollar sign, if your intent is to always refer to the same dataframe.
# Start off by issuing the attach(df) command so that we can use these shortcut names to apply to dataframe ‘df’.
attach(df)
# Compute a new standardized variable by subtracting the mean of Total Costs from each of the Total.Costs and dividing by the standard deviation of Total Costs.
Total.Costs.z <- mean((Total.Costs - mean(Total.Costs)) / sd(Total.Costs))

# We can also accomplish the same thing by using the scale function, which simplifies the calculation a bit:
Total.Costs.z <- scale(df$Total.Costs)
Total.Charges.z <- scale(df$Total.Charges)

# To prove to yourself that the transformation is accurate, print the mean and standard deviation of the new variables separately to verify that the mean is 0, and the standard deviation is 1.  Note that there will be some minor rounding in the results.
mean(Total.Costs.z)
sd(Total.Costs.z)
mean(Total.Charges.z)
sd(Total.Charges.z)

# Changing a variable to another type
# If you examine the str() output above, you will also see that Length of Stay is currently defined as a factor. This will need to be transformed to a new variable by using the as.integer function. Transform it to an Integer, and code a str and summary function to ensure that the transformation is correct.
los.int <- as.integer(Length.of.Stay)
head(los.int)
summary(los.int)
# Appending the variables to the existing dataframe
# We will now take the 3 new variables that we have created and append the new vectors to the existing data frame, and give it a new name.
df2 <- cbind(df,Total.Charges.z,Total.Costs.z,los.int)
str(df2)
# Extracting a subset
# Another typical task that you might want to perform is to first extract a particular characteristic of the data (such as Patient “Expired”), and then perform a similar grouping, to try to understand where the differences are. In this next example we will also use the “dplyr” package to first extract those patients admitted to a Hospital, who died, and then summarize the Total costs by each of the major diagnostic classifications. Finally, we will order the costs by the most expensive diagnoses. As you can see from the results below, infection diseases have the highest costs associated with them.
df %>% filter(as.character(Patient.Disposition) == "Expired") %>% 
  group_by(APR.MDC.Description) %>% 
   summarize(total.count=n(),TotalCosts=sum(Total.Costs)) %>% arrange(desc(TotalCosts)) %>% head()

 
# Insert image B05033_03_10.png
# Transposing a data frame
# You will sometimes be given a format which contains data which is arranged vertically and you want to flip it so that the variables are arranged horizontally.  You will also hear this referred to as long format vs. wide format. Most predictive analytics packages are set up to use long format, but there are often cases in which you want to switch rows with columns. Perhaps data is being input as a set of key pairs and you want to be able to map them to features for an individual entity. Also this may be necessary with some time series data in which the data which comes in as ‘long’ format and needs to be reformatted so that the time periods appear horizontally.
# Here is a data frame which consists of sales for each member for each month in the first quarter.  We will use the “text=’ option of theread.table function to ‘read’ table data that we have pasted directly into the code, for example, this is from data that has been pasted directly from an Excel spreadsheet.

sales_vertical <- read.table(header=TRUE, text='
                             memberid  Month sales
                             1      1         17
                             1      2         15
                             1      3         11
                             2      1          6
                             2      2         20
                             2      3         11
                             3      1          9
                             3      2         33
                             3      3         43
                             4      1         11
                             4      3         13
                             4      4         12
                             ')

sales_vertical
#    memberid Month sales
# 1         1     1    17
# 2         1     2    15
# 3         1     3    11
# 4         2     1     6
# 5         2     2    20
# 6         2     3    11
# 7         3     1     9
# 8         3     2    33
# 9         3     3    43
# 10        4     1    11
# 11        4     3    13
# 12        4     4    12
# 
# For switching the rows with the columns, we can use the “spread” function from the tidyr package

#install.packages(“tidyr”)
library(tidyr)
sales_horizontal <- spread(sales_vertical, Month, sales)
sales_horizontal

# The last line prints the results of the transpose to the console. Take a look at the output of the console to verify that what used to be rows (memberid’s) are now columns.  Each of the sales figures also appear as columns, with the column name designating the specific month. Additionally, for each month of data in which a sales figure did not appear for a particular month, NA will appear. For example, in the original data, member ‘12’ was the only member who had sales figures for Month 4.  That will appear as 12, in the month 4 column, but since the other members had no sales for that month, they will appear as NA.
sales_horizontal <- spread(sales_vertical, Month, sales)
sales_horizontal
#   memberid  1  2  3  4
# 1        1 17 15 11 NA
# 2        2  6 20 11 NA
# 3        3  9 33 43 NA
# 4        4 11 NA 13 12
# 
# Dummy variable coding
# A dummy variable is a binary flag (0 or 1) which designates the presence of absence of a feature. If you are using dummy variables, you will need to accommodate for as many levels of the dummy variable minus 1. For example if you have a category designating humidity with only 2 levels such as “High”, and “Low”, you only need to create 1 dummy variable. Let’s say it is called “is.humid”.  If the value of humidity is “High”, is.humid=1. If Humidity is “Low”, is.humid=0.  However, many predictive analytics functions handle the creation of a dummy variable internally, so there is not as much use to code dummy variables manually as there used to be. But you still may want to create flags which designate the levels of a categorical variable, which can be useful for plotting, creating customized transformations, and for manually creating interactions in a statistical model.  There are several ways to do this, you can use “Dummies” package which will create dummy variables automatically. But, you can also accomplish this via code by using the “Model Matrix” function.  This takes the categorical variable “Segment”, which contains 5 levels (A-E) and expands it into 4 separate dummy variables.
set.seed(10)
model <- data.frame(y=runif(10), x=runif(10), segment=as.factor(sample(LETTERS[1:5])))
head(model)

A <- model.matrix(y ~ x + segment,model)
head(A)

# > head(model)
#            y         x segment
# 1 0.50747820 0.6516557       E
# 2 0.30676851 0.5677378       C
# 3 0.42690767 0.1135090       D
# 4 0.69310208 0.5959253       A
# 5 0.08513597 0.3580500       B
# 6 0.22543662 0.4288094       E

A <- model.matrix(y ~ x + segment,model)

head(A)
#   (Intercept)         x segmentB segmentC segmentD segmentE
# 1           1 0.6516557        0        0        0        1
# 2           1 0.5677378        0        1        0        0
# 3           1 0.1135090        0        0        1        0
# 4           1 0.5959253        0        0        0        0
# 5           1 0.3580500        1        0        0        0
# 6           1 0.4288094        0        0        0        1
# 
# Binning: numeric and character
# Often numeric variables are ‘binned’ into categories such as “High”, “Low”, “Medium”, or “High Risk” and “Low Risk”. Even though this results in loss of information, this can result in being able to use a variable in a logistic regression, or simply using it for the purpose of simplicity. There are different ways to define the ‘cut points’ which segment a variable, but the simplest way is divide the variable into equal parts.  Taking our sales_horizontal data as an example, we can create a new categorical variable which splits the sales data along a “High” and “Low” category.  We will create a new variable called sales_cat which segments “Sales” into 2 parts, using the cut function.
# 
sales_vertical$sales_cat <- cut(sales_vertical$sales, 2, labels = c('L','H'))
sales_vertical

#    memberid Month sales sales_cat
# 1         1     1    17         L
# 2         1     2    15         L
# 3         1     3    11         L
# 4         2     1     6         L
# 5         2     2    20         L
# 6         2     3    11         L
# 7         3     1     9         L
# 8         3     2    33         H
# 9         3     3    43         H
# 10        4     1    11         L
# 11        4     3    13         L
# 12        4     4    12         L
# 
# Binning Character Data
# Character data is usually grouped according to some sort of hierarchy. But, occasionally you will want to group it based upon a text pattern contained in the actual string. Here is an example of binning character data based upon the year (the 1st 4 characters of “cats”)

cats <- as.factor(c('2016-1','2016-2','2016-3'))
sales <- c(10,20,30)
x <- cbind.data.frame(cats,sales)
x
str(x)
binned <- x
binned
levels(binned$cats) <- substring(levels(binned$cats), 1, 4)
binned
cats <- as.factor(c('2016-1','2016-2','2016-3'))
sales <- c(10,20,30)
x <- cbind.data.frame(cats,sales)
x
#     cats sales
# 1 2016-1    10
# 2 2016-2    20
# 3 2016-3    30
str(x)
# 'data.frame':	3 obs. of  2 variables:
#  $ cats : Factor w/ 3 levels "2016-1","2016-2",..: 1 2 3
#  $ sales: num  10 20 30
binned <- x
binned
#     cats sales
# 1 2016-1    10
# 2 2016-2    20
# 3 2016-3    30

#RW double check what this is doing
levels(binned$cats) <- substring(levels(binned$cats), 1, 4)
binned
  cats sales
1 2016    10
2 2016    20
3 2016    30

# Missing values
# Missing values denote the absence of a value for a variable. Since data can never be collected in a perfect manner, many missing values can appear due to human oversight, or can be introduced via any systematic process which ‘touches’ a data element.  It can be due to a survey respondent not completing a question, or, as we have seen, it can be created from joining a membership file with a transaction file. In this case, if a member did not have a purchase in a particular year, it might end up as “NA” or missing.
# The first course of attack for handling missing values is to understand why they are occurring.  In the course of plotting missing values, you not only want to produce counts of missing values, but you want to determine which sub segments may be responsible for the missing values.
# To research this, attempt to break out your initial analysis by time periods, and other attributes using some of the Bi Variate Analysis techniques which were mentioned. This will help you identify where missing values may be tucked away.
# Setting up the Missing Values Test Data Set
# 
# We will start off by using two groups of generated data.  One group is for Males who have a 3% probability of not responding to an Age question in a survey, and the other group is for Females, who have a 5% probability of not responding to an age question.
library(wakefield)
library(dplyr)

#generate some data for Males with a 5% missing value for age

set.seed(10)
f.df <- r_data_frame(
  n = 1000,
  age,
  gender(x = c("M","F"), prob = c(0,1),name="Gender"),
  education
) %>%
  r_na(col=1,prob=.05)  

#str(f.df)
summary(f.df)
set.seed(20)
#generate some data for Females with a 3% missing value for age

m.df <- r_data_frame(
  n = 1000,
  age,
  gender(x = c("M","F"), prob = c(1,0),name="Gender"),
  education
) %>%
  r_na(col=1,prob=.03)  
summary(m.df)

all.df=rbind.data.frame(m.df,f.df)


# Note that we have generated missing values by ‘piping’ the output of r_data_frame function into the r_na function which will generate the specified percentage of missing values. After the script completes, switch over to the Console to verify that NA’s were generated for the Age variable. There are 80 of them.
summary(all.df)

 

# Insert image B05033_03_11.png
# 
# The various types of missing data
# There are actually three different categories of missing values that you should become familiar with.  Understanding the type of missing value will help you determine how to handle them.
# Missing Completely at Random (MCAR)
# Some percentage of missing values will always occur naturally. When this happens, the missing data is known as “Missing Completely at Random (MCAR)”.  An example of this would be if 2% of a survey was not recorded due to a glitch in a survey response system. If this were the case one could assume that it was not related to any other variable in the data. MCAR variables are also not correlated with its own data values, i.e. it would also not be related to any other of the ‘non-missing’ values which appear in the data. 
# Testing for MCAR
# When you suspect that your data is MCAR there are various statistical tests can help you determine if MCAR MAY be occurring. One important test is the Little test which we will now run on the test missing value data set.
# First, Install the “BaylorEdPsych” package which contains the LittleMCAR test.	
try(require(BaylorEdPsych) || install.packages("BaylorEdPsych",dependencies=TRUE))
library(BaylorEdPsych)

# Now, run the litleMCAR test
test_mcar<-LittleMCAR(all.df) 

# Print the missing values found by the test.  4% of the data was found to be missing.  This makes perfect sense since 5% of the 1000 males, and 3% of the 1000 females which generated with NA’s 
print(test_mcar$amount.missing)
 
print(test_mcar$p.value)

# Print the value of the test statistic.  High values of p imply the data is MCAR while low values imply there is some pattern.  At the .05 significance level it passes the MCAR test (but barely).  We also know that we generated our own patterns of NA via the simulation, so that certainly contributed to the p-value of .07
# 
#  
# 
# Alternatively, you can use Chi-Square and regressions tests to determine if the “missingness” of a variable is related to another variable.  If you find that there is NO statistical significance between the missing variable, and any other variable, you can consider the variable MCAR. These tests can be valuable, although there methods are not fool proof. There are still assumptions that need to be made about the process that generated them. As always, the best course is to investigate the process that generated the values to see how they were generated.
# Missing at Random
# “Missing at Random” implies that the missingness of a value IS related to another variable in the analysis.  It is somewhat of a misnomer, since there is nothing random about it. So, another question to ask when dealing with missing values is “Is the fact that there are missing values in this variable related to the dynamics of any other variable?”  Again, using our survey analogy as an example, missing values for “What is your Expected Salary” might occur for certain demographics groups, who did not care to answer the question. If you found a statistically significant number of missing values at one level of a factor, but not as many within another level, that would suggest that the data was missing at random. A variable which is Missing at Random can be found by looking at some of the same techniques used above, i.e. Chi-Square, regression, Little test, and if differences ARE found you can consider the variable MAR.  For our test missing data set, we might consider this MAR since there is difference in the number of missing values for Males and Females.
# Not Missing at Random
# A variable which is not MCAR, and not MAR can be considered Not Missing at Random (NMAR).  That basically means that a missing value is related to the values of the missing value itself, or is related to a variable NOT in the model. NMAR values often show up in as survey research and clinical research where subjects are measured over time. For example, survey respondent who report severe depression at the beginning of a study can drop out at the end of the study, so if they scored high on a depression scale, that WOULD be related to the fact they have missing scores at a later date, since they might be more inclined to drop out.
# NMAR is the most difficult situation to detect, since a variable may seem to be MAR, or MCAR and really be NMAR. Missing value analysis is not an exact method, and again, that is where understanding the domain, and the underlying methods of generating data is so important.  
# Correcting for missing values
# Although it is always important to understand the source of your missing values, how you ultimately will handle them depends upon the technique that you use to analyse your data sets.  For example, Classification methods such as decision trees and Random Forests know how to deal with missing values, since they can treat them as a separate class, and you can safely leave them in the model.  However, if a variable has a large amount of missing values, say > 20%, you might want to look at imputation techniques, or try to find a better variable that measures the same thing.
# Listwise deletion
# For MCAR, eliminating rows which have missing values is acceptable.  In this example (from https://en.wikipedia.org/wiki/Listwise_deletion),  observations 3,4,and 8 will be remove from the data prior to analysis.
# 
#  
# 
# However, the downside effect of Listwise deletion is that you MAY end up deleting some non missing variables which would have an important effect on the model.  However, since the missing data is presumed random, removing some rows would not have a major effect, assuming your assumptions are correct.
# Another consideration is the amount of data you have to work with.  You do not want to end up deleting most of your data if there is one missing value which would cause you to throw out all of your data!  If you will be going this route, see if you can eliminate this variable from consideration and start with a list of variables which are reasonable complete.
# For example, if you had zip code information on most of the records, but the “State” variable was only 50% populated, you wouldn’t want to include both zipcode and State together in an algorithm which performed Listwise deletion (such as regression) since that would minimually eliminate 50% of your data.  So a first line of attack would be to see if the variables was even needed in the first place (possible thru a variable importance measure), or if there was an alternative variable which could serve as a substitute which was better populated.  Principal component analysis or basic pairwise correlation can help you identify this situation.
# Imputation methods
# Imputating a missing value means substituting the missing value for another value which is “reasonable”.  What is reasonable can range from substiting the missing value for the mean, median or mode of a variable to regression techniques, to more advanced techniques involving Monte Carlo Simulation.
# Imputing missing values using the ‘mice’ package
# In this example we will use the ‘mice’ package to impute some missing values for the ‘Age’ variable in the all.df dattaframe. The value of age will be imputed by 2 other existing variables: Gender and Education.
# To begin, install and load the “mice’ package.
# 
#install.packages("mice")
library(mice)

# We will now run the md.pattern function which will show you the distribution of the missing values over the other columns in the dataframe.  The md.pattern output is useful for suggesting which variables might be good candidates to use for imputing the missing values.
# md.pattern(all.df)
# The output from md.pattern is shown below. Each row shows a count of observation along with a ‘1’ or ‘0’ flag which indicates if the count contains completely populated values or not.
# •	The first row indicates that there are 1920 observations where Gender, Education, and Age are NOT missing.  
# •	The 2nd row shows the remaining 80 observations also have populated values for Gender, and Education, but NOT for age.
# It is important to examine md.pattern to see if there is enough “non missing” values in other variables to be able to impute missing values. 
#  
# Insert image B05033_03_12.png
# To begin the imputation process call the ‘mice’ function and assign it to a new R object.  

imp <- mice(all.df,m=5,maxit=50, seed=1010,printFlag = TRUE)
# •	In the function call, make sure you supply a random seed value, so you can replicate the same results if you run it again. 
# •	The m=5 parameter specifies that you end up with 5 ‘plausible’ imputations for the variable. 
# •	Maxit=50 specifies that there will be up to 50 iterations of the algorithm before it converges to a solution. This can be adjusted upward or downward to the desired precision.
# After you run the mice function you will see the imputation run real time, so it may take a while depending upon the number of iterations you specified.
# When it is done you can see some of the imputed value for Age (or other values) using head():
head(imp$imp$Age)
# > head(imp$imp$Age)
#      1  2  3  4  5
# 38  29 35 20 33 27
# 49  25 23 30 32 21
# 79  25 23 25 25 25
# 99  31 30 22 26 24
# 157 24 30 24 23 22
# 180 29 22 26 28 29
# 
# To actually complete the imputation, you will have to run the complete() function and assign the results to a new dataframe. This version of complete will collect ALL imputations in the assigned dataframe via the “long” parameter. 
all_imputed_df <- complete(imp, "long", include=TRUE)


# Run a table() function on the new dataframe to calculate a count of the missing values for all of the imputations, plus the original values. The original dataframe containing NA’s, is designated by imp=0.  There are addition 5 other imputations of age designated as imp 1-6
table(all_imputed_df$.imp,is.na(all_imputed_df$Age))


#  
# 
# Insert image B05033_03_13.png
# 
# To see how the imputation in action, we will filter the new dataframe for one of the original ID’s that contained missing values (#216).
# Then we can look to see how the age value changes for each imputation of Age.  There can be some variation for the imputed values. For this example it can range from a starting value of 25 up until 34.
all_imputed_df %>% filter(.id == 216)
# >all_imputed_df %>% filter(.id == 216)
#   .imp .id Age Gender                                Education
# 1    0 216  NA      M Some College, 1 or More Years, No Degree
# 2    1 216  25      M Some College, 1 or More Years, No Degree
# 3    2 216  29      M Some College, 1 or More Years, No Degree
# 4    3 216  22      M Some College, 1 or More Years, No Degree
# 5    4 216  34      M Some College, 1 or More Years, No Degree
# 6    5 216  34      M Some College, 1 or More Years, No Degree
# 
# Of course, that is for a single observation, if you look at the mean values for imp=1-6, that are all similar.
all_imputed_df %>% group_by(.imp) %>% summarize(MeanAge=mean(Age)) 

# > all_imputed_df %>% group_by(.imp) %>% summarize(MeanAge=mean(Age))
# # A tibble: 6 × 2
#     .imp MeanAge
#   <fctr>   <dbl>
# 1      0      NA
# 2      1 27.5300
# 3      2 27.5780
# 4      3 27.5230
# 5      4 27.5855
# 6      5 27.5325
# 
# Running a regression with imputed values
# Now that you have imputed a value for age, you will be able to run models such as linear  regression without having to discard missing values.  
# Let’s try a regression with imputation #2
# First extract impute #2
impute.2 <- subset(all_imputed_df,.imp=='2')

# Next, run a summary function at the console to insure there are no more NA’s

summary(impute.2)
#  .imp          .id            Age        Gender  
#  0:   0   1      :   1   Min.   :20.00   M:1000  
#  1:   0   10     :   1   1st Qu.:23.00   F:1000  
#  2:2000   100    :   1   Median :28.00           
#  3:   0   1000   :   1   Mean   :27.58           
#  4:   0   1001   :   1   3rd Qu.:32.00           
#  5:   0   1002   :   1   Max.   :35.00           
#           (Other):1994                           
#                                     Education  
#  Regular High School Diploma             :522  
#  Bachelor's Degree                       :323  
#  Some College, 1 or More Years, No Degree:295  
#  9th Grade to 12th Grade, No Diploma     :169  
#  Master's Degree                         :150  
#  Associate's Degree                      :140  
#  (Other)                                 :401  
# 
# Finally run the regression:
lm(Age ~ Education + Gender,data=impute.2)

# > lm(Age ~ Education + Gender,data=impute.2)
# 
# Call:
# lm(formula = Age ~ Education + Gender, data = impute.2)
# 
# Coefficients:
#                                       (Intercept)  
#                                          26.85358  
#              EducationNursery School to 8th Grade  
#                                           0.86901  
#      Education9th Grade to 12th Grade, No Diploma  
#                                           1.02452  
#              EducationRegular High School Diploma  
#                                           0.33593  
#            EducationGED or Alternative Credential  
#                                           1.26967  
#           EducationSome College, Less than 1 Year  
#                                           1.53750  
# EducationSome College, 1 or More Years, No Degree  
#                                           0.69232  
#                       EducationAssociate's Degree  
#                                           0.95965  
#                        EducationBachelor's Degree  
#                                           0.82072  
#                          EducationMaster's Degree  
#                                           0.84928  
#               EducationProfessional School Degree  
#                                           0.11744  
#                         EducationDoctorate Degree  
#                                           0.87017  
#                                           GenderF  
#                                          -0.03037 
# 
# Imputing Categorical Variables
# Imputing Categorical variables can be trickier than imputation of numeric variables. Numeric imputation is based upon random variates, but imputation of categorical variable are based upon statistical tests with less power such as chi-square, and they can be rule based, so if you end up imputing categorical variable, use with caution and run the results past some domain experts to see if it makes sense. You can use decision trees or Random Forests to come up with a prediction path for your missing values, and map them to a reasonable prediction value using the actual decision rules generated by the tree.
# Outliers
# Outliers are values in the data which are outside the range of what is to be expected.  “What is to be expected” is of course subjective.  Some people will define an outlier as anything beyond 3 standard deviations of a normal distribution, or anything beyond 1.5 times the interquartile ranges. This, of course, may be good starting points, but there are many examples of much real data which can defy any statistical explanation.  These rules of thumb are also highly dependent upon the form of the data.  What might be considered an outlier for a normal distribution, would not hold for a lognormal, or Poisson distribution.
# In addition to potential single variable outliers, Outliers can also exist in multivariate form, and are more prevalent as data is examined more closely in a high dimensional space.
# Whenever they appear, outliers should be examined closely since they may be simple errors or provide valuable insight.  Again, it is best to consult with other collaborators, when you suspect deviation from the norm.
# Why outliers are important
# Outlier detection is important for a couple of reasons.  First, it allows you to learn a lot about the extremes in your data.  Typical data is usually easy to explain. If you have many values of a certain category, it is usually easy to track down an explanation. It is the extreme values which can add additional insight beyond the typical, or identify faulty processes which can be fixed.
# Additionally, outliers have a profound effect upon some algorithms.  In particular, regression ,methods can be biased by the presence of outliers, and lose power because of them.
# Detecting outliers
# Graphical methods are best for initially scanning for outliers. Boxplots, histograms, and normal probability plots are very useful tools.  
# In this code example, sales data is generated with an average sale of $10,000 and a standard deviation of $3,000.  The boxplot shows some data above and below the “whiskers” of the diagram.  Additionally, the histogram shows a “gap” between the highest bar and the one just below that. These are clues that potential outliers need to be looked at more closely.
set.seed(4070)
#generate sales data
outlier.df <-data.frame(sales=rnorm(100,mean=10000,sd=3000))
#plot the data, to possible outliers
par(mfrow=c(1,2))
boxplot(outlier.df$sales, ylab="sales")
hist(outlier.df$sales)

 
# Insert image B05033_03_14.png
# 
# Another way of looking for outliers is to examine the actual quartiles, percentiles, or deciles. These measures are useful for breaking the data into equal buckets, and then observing the difference among the groupings.
# Here we can look at all of the deciles of the data using the quantile() function and specifying that we want each breakpoint at each 10% of the data
# 
deciles <- data.frame(quantile(outlier.df$sales,
                               prob=c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,.9,1)))
deciles

# >deciles
#      quantile.outlier.df.sales..prob...c.0.1..0.2..0.3..0.4..0.5..
# 10%                                                       5548.897
# 20%                                                       7409.263
# 30%                                                       8621.341
# 40%                                                       9090.793
# 50%                                                       9741.979
# 60%                                                      10364.654
# 70%                                                      11019.190
# 80%                                                      12175.635
# 90%                                                      13164.274
# 100%                                                     15363.606
# 
# Transforming the Data
# Another way to look at outliers is by first standardizing them to a normal distribution with a mean of 0 and standard deviation of 1. Using standard normal form is convenient, since the properties of the distribution never change, and some critical cut off points can be committed to memory. For example, for a standard normal distribution, quartile 1 is always at  -.67 and quartile 3 is always at +.67, so it is easy to compute the interquartile range to memory,  which is 1.34.   Using the interquartile range rule to identify outliers means that we will take 1.5 times this amount to derive the value of 2.01, so we will be considering any data point above .67+2.01=2.68 or -.67-2.01=-2.68 to be a possible outlier.   This is an example of how we can use a statistical property of a distribution to identify an outlier. You could also use a rule such as identifying any data point > greater 3 standard deviations from the mean, or by using a chi-square test to determine if your grouped data differs significantly from the theoretical distribution.  The ”outliers” package also contains several other methods and statistical tests for detecting outliers, including the Grubbs test.
# Here we will first normalize the data, and then look for data falling above or below plus or minus 2.68
# •	First use the scale() function to standardize the sales vector, and create a new vector “v1” which contains the standardize values (or z-scores)
outlier.df$v1 <- scale(outlier.df$sales)

# •	Next we will use the order() function to sort the z-scores from lowest to highest.  This will make it easy to look at the extremes using the head() and tail() functions. We can see immediately that there are two values which fall out the range -2.68 to +2.68

#sort from lowest to highest 
outlier.df <- outlier.df[order(outlier.df$v1),]
head(outlier.df)

# >head(outlier.df)
#        sales        v1
# 59  672.6731 -2.917263
# 88 2776.8597 -2.295223
# 39 3034.5596 -2.219042
# 69 3041.7867 -2.216905
# 63 4363.3742 -1.826217
# 75 4894.2080 -1.669292

tail(outlier.df)
# >tail(outlier.df)
#       sales       v1
# 77 15434.46 1.446619
# 22 16286.14 1.698392
# 71 16319.01 1.708109
# 26 16455.81 1.748549
# 66 16624.87 1.798528
# 35 20176.17 2.848362
# 
# •	Finally, we will examine the boxplot for the transformed data.  Note the shape of the distribution is exactly the same as the original data.  The only difference is that the scale of the data has changed along the y-axis.
# 
boxplot(outlier.df$v1, ylab="v1")

# We can still see the potential outliers at the top of the boxplot (small circle)
# 
# 
#  
# Insert image B05033_03_15.png
# Tracking down the cause of the outliers
# Once you have identified a possible outlier, it is always the best course to determine why they occurred. We have illustrated an outlier which appears in one set of data, however more often than now you will be splitting your data into various subsets, to try to track down the cause of the outlier.  This is assuming that you have enough data to work with.  Outlier detection for small samples is a lot tougher.
# Ways to deal with outliers
# Here are few ways to deal with the outliers:
# •	Remove them, or set them to NA.  This can make sense if you do not have too many of them, and it will make your model easier to explain. The trade-off is that you may be removing important data, so use with caution.
# •	Use a transformation to reduce the variability. Choose the appropriate transformation based upon the skewness of the data, or try a Box-Cox power transformation.  One advantage to this is that the correct transformation can reduce the influence of the extreme observations.
# •	Bring them down to a pre-controlled level. This can be accomplished by using a trimmed, or Windsorized mean.  This is done in the actuarial profession, since some risk can be capped if the variable exceeds a certain level.  
# •	Choose a classification rather than a regression type algorithm, which will not be as sensitive to outliers.  For decision trees, outliers will tend to show up in their own leafs with small counts.  At that point, you can choose to ignore the outlier by pruning the tree and collapsing it into a different category.
# •	For regression type algorithms, you can choose an algorithm which penalized large coefficients such as ridge or lasso regression who are more robust against outliers
# Example - Setting the outliers to NA
# The next step would be of course to start examining these outliers.  For our example, the extremes are part of the random number generation process, therefore they are not really outliers.  However, if you encountered this situation in your own data, you would begin to track down the reasons these extremes occur.  Start by trying to associate these extremes with other data elements.  Perhaps these outliers are appearing in certain age groups and not in others?   
# For our example, we will simply be setting the value to NA for these extreme values.  We will also be creating a new variable “v1x” to house the new variable, and will NOT overwrite the value of the original variable.  As you investigate new ways of detecting outliers, you can store the new values in additional variables, with the assurance that you can always refer back to the original variable.

outlier.df$v1x<-ifelse( (outlier.df$v1 >= 2.68 | outlier.df$v1 <=  -2.68),NA,outlier.df$v1)
tail(outlier.df)
head(outlier.df)

# Refer to the console with output of the head() and tail() command and notice the changes in the data.  When was previously considered an outlier (-2.917263), has now been mapped to NA.       
# 
# >tail(outlier.df)
#       sales       v1      v1x
# 77 15434.46 1.446619 1.446619
# 22 16286.14 1.698392 1.698392
# 71 16319.01 1.708109 1.708109
# 26 16455.81 1.748549 1.748549
# 66 16624.87 1.798528 1.798528
# 35 20176.17 2.848362       NA
# >head(outlier.df)
#        sales        v1       v1x
# 59  672.6731 -2.917263        NA
# 88 2776.8597 -2.295223 -2.295223
# 39 3034.5596 -2.219042 -2.219042
# 69 3041.7867 -2.216905 -2.216905
# 63 4363.3742 -1.826217 -1.826217
# 75 4894.2080 -1.669292 -1.669292
# 
# Also run a boxplot, and observe that the original upper outlier has been removed

boxplot(outlier.df$v1x, ylab="v1 new")



#  
# Insert image B05033_03_16.png
# Multivariate outliers
# The above example has just given an example of looking at outliers from a univariate, or single variable, perspective. However, outliers can also occur in multivariate of combination form.  In these cases visualizing outliers in 2 dimensions can be a start, but as the dimensionality increases they can be more difficult to isolate. For multivariate outliers you can use distance and influence measures such as Cook’s D or Mahalanobis distances to measure how far they are from a regression line. Principal component analysis can also help by reducing the dimensionality first, and then examining the higher order principal components which could include the outliers.
# Data Transformations
# When you are dealing with continuous skewed data, consider applying a data transformation, which can conform the data to a specific statistical distribution with certain properties.  Once you have forced the data to a certain shape, you will find it easier to work with certain models.  A simple transformation usually involves applying a mathematical function to the data.
# Some of the typical data transformations used are log, exp, and sqrt. Some work better for different kinds of skewed data, but they are not always guaranteed to work, so it is always best practice to try out several basic ones and determine if the transformation becomes workable within the modelling context.  As always, the simplest transformation is the best transformation, and do some research on how transformations work, and which ones are best for certain kinds of data.
# To illustrate the concept of a transformation, we will start by first generating an exponential distribution, which is an example of a “non-linear” distribution. Refer to the “Histogram of X”, and the “Normal Q-Q Plot” in the first row of the plot quadrant below.  Both of these plots show the data to be highly skewed, you can see the histogram is heavily weighted toward the lower range of x, and the Q-Q plot is not displaying as a straight line. So we will need to find a transformation which smoothes out the skewness.  So, we will apply the Box Cox algorithm which will determine an optimal transformation to use.
# Generating the test data
# Install the packages if needed

#install.packages("car")
#install.packages("MASS")

#Assign the libraries

library(car)
library(MASS)

#Generate the “skewed” data

set.seed(1010)
x<-rexp(1000) 		# exponential sample with parameter 1 
par(mfrow=c(2,3))

#Plot the histogram and Normal Probability plots. The par() function above specified that they will part of the first row of plots shown in the next section.
hist(x)
qqnorm(x)			# Normal probability plot for original variable

# The Box-Cox Transform
# 
# We will now illustrate the Box Cox Power Transformation (also known as Power Transformation).  This is a generic transform which will search for optimal transformations to use on your data. This transformation optimizes an exponent, called Lambda which will be applied is then applied to your data. It does this by iterating over all exponents between -5 and +5 until it has found the best one to transform your data to a normal distribution.
boxcox(x~1)	
# 
# As you can see from the plot produced from the boxcox function (3rd plot), the optimal exponent to apply the data, will be somewhere between 0 and 1.
# Next, we will apply the power function. The powerTransform function will apply the optimal lambda just calculated to the original data. 

p<-powerTransform(x)    

# You can see what the value is by switching over to the console and looking for the value of p$lamda.  The console will show that the value is 0.2873638

#RW correct spelling
p$lambda
# 
# The next step is to apply the power transformation to your existing data, and assign the results to a new vector “y”. 

y<-bcPower(x,p$lambda)	# Box-Cox transformation

# The Histogram of the new data (“Histogram of y”, last plot below) shows that the data has been transformed to a normal distribution, and the QQ plot, which measures normality, shows a nice straight line.

qqnorm(y)			# Normal probability plot for transformed variable 
hist(y)
 

# Insert image B05033_03_17.png
# 
# Variable Reduction/Variable importance
# 
# Variable reduction techniques allow you to reduce the number of variables that you need to specify to a model.  We will discuss 3 different methods to accomplish this. 
# 1.	Principal Components Analysis
# 2.	All subsets Regression
# 3.	Variable Importance
# 1) Principal components analysis
# Principle components analysis is a variable reduction technique, and can also be used to identify variable importance.  An interesting side benefit of PCA is that all of the  resulting new component variables will all be uncorrelated with each other.  Uncorrelated variables are desirable in a predictive model since too many correlated variables confound predictions, and make it difficult to tell which of the independent variables have the most influence. So, if you first perform an exploratory analysis of your data and you find that a high number of correlations exist, that would be a good opportunity to apply PCA.
# Tip:  models can tolerate some degree of correlated variables.  The situations I am speaking of are cases in which you have a large number of variables to consider, and just end up ‘throwing’ them into a model,  hoping the algorithm will determine the model by itself.  Most of the time it won’t.
# In many models where you start with a large number of variables you will find that many  of them are similar to each other and have the same predictive abilities.
# A classic example of this are predictors for standardized test scores.  While some of them are tailored to measure specific things (Reading, Math aptitude etc.), many of the predictors have high correlations with each other. The bottom line is that using 1 or 2 of them in a prediction model may not be all that different that using all 8 or 9 of them.
# PCA has the ability to identify redundancy in the data and can be thought of as a way to determine the minimum number of variables which contribute the most to the model’s variation. If you can reduce the explained variability of the data to just 2 or 3 components, that will help you reduce the dimensionality of the data.  Once you determine the components, you can use them to:
# •	Replace the original variables with the principal components
# •	Use the principal component analysis to simply identify and keep only the most useful original variables.  In this case, “useful” can mean variables with the highest variance, variables with the highest correlation with the target variable, variable which have the most ‘meaning’ etc.
# Therefore, one goal of principal component analysis is to identify a small subset of “new” variables which explain a very large part of the variance of the original data.
# 
# Where is PCA used?
# 
# Principal components are used heavily in the social sciences, marketing and advertising industries.  Related to PCA is Factor Analysis, in which the result of rotating Principal Components results in creating Latent Variables.  Latent variables attempt to describe the behaviour of the data subjectively, as opposed to Principal Components, which is simply a linear combination of the original variables, and are more or less synthetic linear equations.
# 
# A PCA example – US Arrests
# As an example, here is the correlation matrix plot for USArrests, corresponding to the number of arrests per 100,000 residents for assault, murder, and rape in each of the 50 US states in 1973. Also given is the percent of the population living in urban areas. The USArrests dataset should be loaded automatically as part of the datasets package.
# You can get description of the USArrests data set by entering the help command ?USArrests at the console.
# To see the correlation among all of the variables enter the following on the console line:
library(datasets)
pairs(USArrests)

#  The output is shown below.
# 
#  
# Insert image B05033_03_18.png
# The pairs function creates mini scatterplots for all of the different combinations of continuous variables in the dataframe. To examine a particular pair, look at the cell which intersects the appropriate row and column labels for the variables, which are shown in the diagonal row of the matrix. For example, the scatterplots for Murder with Assault are shown by locating the cells that these labels intersect: That would be in 2 places:
# Row 1, column 2 of the matrix, as well as row 2 and column 1.
# 
# Note that most of the variables seem strongly correlated with each other.  The Urban Population variable (UrbanPop) seems to be the least correlated variable, at least based upon the scatter that is represented, visually. Murder and Assault seems to have a stronger correlation. That would make me wonder if we would need to include all of the variables in a prediction model.
# To run a principal components on this data we will use the “prcomp” function. Note the comments in the code that scaling (normalization) is appropriate, since the variables have different scales. 

require(graphics)

## the variances of the variables in the
## USArrests data vary by orders of magnitude, so scaling is appropriate

prcomp(USArrests, scale = TRUE)


# The output of the prcomp function is shown below. This output describes the ‘loadings’ of each of the variables on each of the principal components.  The original variables are shown as rows, and the “new” variables  The principal components are shown as columns.  By default they are named PC1, PC2, PC3 and PC4.
# 
# Standard deviations:
# [1] 1.5748783 0.9948694 0.5971291 0.4164494
# 
# Rotation:
#                 PC1        PC2        PC3         PC4
# Murder   -0.5358995  0.4181809 -0.3412327  0.64922780
# Assault  -0.5831836  0.1879856 -0.2681484 -0.74340748
# UrbanPop -0.2781909 -0.8728062 -0.3780158  0.13387773
# Rape     -0.5434321 -0.1673186  0.8177779  0.08902432
# 
# The numbers given under each column are the actual coefficients used which are used to determine the linear combination.  So we can calculate the first, and most important Principal Component as 
# PC1=Murder * 0.5358995 + Assault*-0.5831836 + UrbanPop*-0.2781909 + Rape*-0.5434321.  
# Since the variables have been scaled (or standardized) to begin with, the magnitude of coefficients themselves can give a rough estimate of how much a variable contributes to each of the components. For example, PC1 could be described as the variation due to Murder, Rape, and Assault, while PC2 is more about the variations in Urban Population. PC3 might be about the effect of Rape within Urban Populations, and PC4 could be about Murder, when Assault is not involved.
# 
# The overwhelming power of PC1 can be shown in the following plot.  Each succeeding principal component measures the leftover variation unexplained by the previous components.
plot(prcomp(USArrests))

 
# Insert image B05033_03_19.png
# 
# The prcomp summary shows the cumulative percentage of explained variation.  

summary(prcomp(USArrests, scale = TRUE))

Importance of components:
                          PC1    PC2     PC3     PC4
Standard deviation     1.5749 0.9949 0.59713 0.41645
Proportion of Variance 0.6201 0.2474 0.08914 0.04336
Cumulative Proportion  0.6201 0.8675 0.95664 1.00000

# In the last line of the output, “Cumulative Proportion”, you can see that the first component explains 62% of the variation, and the first 2 principal components explain a total of 87% of the variation in the data.  This was based on 4 original variables. Principal Components have reduced the number of variables by 50%. Think of how many variables could be reduced if you would start with a feature set of over 100 variables?
# 2) All Subsets Regression
# All subsets regression is another method you can use for variable selection. It works by running separate regressions for different combinations of 1 variable, 2 variables, 3 variables at a time, until it has used all of the variables or until a specified stopping point. As part of the output,  the ‘best’ model for each of the combination of variables is then calculated. That will then give you an idea of which is the best single one variable model, two variable model, etc. so that you can pare down a large list of variables into a smaller number of important ones, using some plots and output statistics.
# 
# An example – airquality
# 
# In this example, we will use the regsubsets function contained within the  “leaps” package to determine which variables are important for predicting temperature. 
# 
#install.packages("leaps")
library(leaps)
data(airquality)
str(airquality)

# In the regsubsets function call below, we specify that we want the ‘best’ model for each combination of 1,2, and 3 variables.   By default, the function will compute the best model for ALL variables in the model.  In the function call, I illustrate specifying a max value, since I want to be able to stop the algorithm after a certain number of variables have been reached.  This becomes important as you use data which has a large number of variables, and you do not want to tie up precious memory. 
# 
# 
out <-regsubsets(Temp ~ .,data=airquality,nbest=1,nvmax = 99)

# Run a summary on the output.

summary(out)

# The output below shows the variables contained in the best 1-5 variable model. Note that there are only 5 variables, so you cannot have more than a 5 variable model:
# 
# 
# Subset selection object
# Call: regsubsets.formula(Temp ~ ., data = airquality, nbest = 1, nvmax = 99)
# 5 Variables  (and intercept)
#         Forced in Forced out
# Ozone       FALSE      FALSE
# Solar.R     FALSE      FALSE
# Wind        FALSE      FALSE
# Month       FALSE      FALSE
# Day         FALSE      FALSE
# 1 subsets of each size up to 5
# Selection Algorithm: exhaustive
#          Ozone Solar.R Wind Month Day
# 1  ( 1 ) "*"   " "     " "  " "   " "
# 2  ( 1 ) "*"   " "     " "  "*"   " "
# 3  ( 1 ) "*"   "*"     " "  "*"   " "
# 4  ( 1 ) "*"   "*"     " "  "*"   "*"
# 5  ( 1 ) "*"   "*"     "*"  "*"   "*"
# 
# It is useful to be able to interpret the stars in the output table. The row indicates the number of variable in the model, and the “*” in the column shows that the variable is part of that combination. So we can see that Ozone is the best single variable predictor, and Ozone, with Month is the best 2 variable predicture.
# 
# Variables in Model	Ozone	Solar.R	Wind	Month	Day
# 1	Ozone	"*"	" "	" "	" "	" "
# 2	Ozone, Month	"*"	" "	" "	"*"	" "
# 3	Ozone, Month,Solar.R	"*"	"*"	" "	"*"	" "
# 4	Ozone,Month,Solar.R, Day	"*"	"*"	" "	"*"	"*"
# 5	Ozone,Month,Solar.R, Day,Wind	"*"	"*"	"*"	"*"	"*"
# 
# 
# To see the Adjusted R-squares for each of the combinations of variables, run the following at the command line:
summary(out)$adjr2
# [1] 0.4832625 0.5746686 0.5801736 0.5836452 0.5823619
# 
# You can see that the 1 variable model has an adjusted R-Square of .48, while the two variable model Adjusted R-Square is .57  For three variables and beyond it seems as though the increase in R-Square is incremental. So it would see that a two variable model of just Ozone, and month would be adequate for predicting air quality.
# 
# Adjusted R-Square Plot
# 
# The adjusted R-Square plot is also helpful in selecting a model.  Each row of the plot below represents a separate model, with the intercept and all of the variables as columns. The plot shows how adjusted R-square (y-axis) changes for each of the variables in the model.
plot(out, scale = "adjr2")

 
# Insert image B05033_03_20.png
# To select an optimal model, look to the point at which variables have black boxes near  the top of the y-axis range.
# For our example, that would mean the 4 variable model Ozone,Month, Solar.R, Day. However, as noted above, the difference between the 2 and 4 variable model seems minimal.  However, you can see how you could use this method to reduce your variables from 5 to 2, with minimal degradation to a regression model. 
# 3) Variable Importance
# For classification targets you can use the Random Forest algorithm to determine variable importance
# For this example, a simulated sample was generated with smoking, and Family History being key factors in determining heart disease among Males.  
set.seed(1020)
#construct a 50/50 sample of Males, and Females
gender <- sample(c("M","F"), 100, replace=T,prob=c(0.50,0.50))

#assign a higher probability of smoking to the Males (95%, WAY to high!)
smokes <- ifelse(gender=="M",
                 sample(c("N","Y"), 100, replace=T,prob=c(0.05,0.95)),
                 sample(c("N","Y"), 100, replace=T,prob=c(0.45,0.55))
                 
)

#assume they also have a 60% chance of family history of heart disease

familyhistory <- ifelse(gender=="M",
                 sample(c("N","Y"), 100, replace=T,prob=c(0.40,0.60)),
                 sample(c("N","Y"), 100, replace=T,prob=c(0.50,0.50))
                 
)


HighChol <- sample(c("Y","N"), 100, replace=T,prob=c(0.50,0.50))
heartdisease <- sample(c("Y","N"), 100, replace=T,prob=c(0.05,0.95))

#bind all of the variables together

heart<- as.data.frame(cbind(smokes,HighChol,familyhistory,gender,heartdisease))
# Verify some of the generated table with some crosstabs
#row percentages for smoking by gender.  Males who smoke came out little bit higher than the 95%

prop.table(table(heart$gender,heart$smokes),1)
# > prop.table(table(heart$gender,heart$smokes),1)
#    
#              N          Y
#   F 0.42592593 0.57407407
#   M 0.04347826 0.95652174
# 
# 
#row percentage for family history by gender. Males with family history of heart disease came out also a bit higher than 60% 
prop.table(table(heart$gender,heart$familyhistory),1)

> prop.table(table(heart$gender,heart$familyhistory),1)
#    
#             N         Y
#   F 0.5370370 0.4629630
#   M 0.3913043 0.6086957
# 
# > 
# 
# Finally check out occurrence of heart disease by Gender as well.
prop.table(table(heart$gender,heart$heartdisease),1)
#    
#              N          Y
#   F 0.96296296 0.03703704
#   M 0.93478261 0.06521739
# 
# 
# Variable Influence Plot
# 
# Now we can run our Variable Influence plot. The plot below indicates High Cholesterol, and familyhistory as the most ‘important’ variables. 
# 
# 
require(randomForest)
fit <- randomForest(factor(heartdisease)~., data=heart,ntree=1000)
(VI_F <- importance(fit))
varImpPlot(fit,type=2,main="Random Forest Variable Importance Plot - Heart Disease Simulation")


 

# Insert image B05033_03_21.png
# 
# A downside to this method is that it is treating each variables effectd individually, and not considering any correlation between two variables. 
# Summary 
# In this chapter we learned all about getting data prepared for analytics, so that you can start to run models. It starts with inputting external data in raw form, and we saw that there are several ways you can accomplish these available methods. You also learned how to generate your own data. two different ways- methods you can use to join, or ‘munge’ data together, one using SQL and the other using dplyr.
# We later proceeded to cover some basic data cleaning and data exploration techniques which sometimes are usually needed after your data is input, such as standardizing and transposing the data, changing the variables type, creating ‘dummy’ variables, binning, and eliminating redundant data. You now know about the key R functions which are used to take a ‘first glance’ at the contents of the data as well as its structure.
# We then covered the important concepts of analyzing missing values and outliers, and how to handle them.
# We saw few ways to decrease the number of variables to a manageable level, using techniques such as Principal Component Analysis, and all subsets regression.
# Finally, we learned to use Random Forest algorithms to identify the most important variables for modelling. 
# This concludes the Data Preparation section, and we have just scratched the surface in terms of the ways you can prepare your data for modelling.
# In the next chapter, we will cover more detail about Random Forests, as well as regression, Decision Trees, SVM and some others which will allow us to build a solid foundation of basic algorithms that you can use for your own core models. 
# References
# Hospital Inpatient Discharges (SPARCS De-Identified): 2012. (n.d.). Retrieved from https://health.data.ny.gov/Health/Hospital-Inpatient-Discharges-SPARCS-De-Identified/u4ud-w55t







