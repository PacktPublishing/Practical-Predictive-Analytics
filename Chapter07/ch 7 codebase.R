# Ch 7. Exploring Health Care Enrollment Data as a Time Series
# "I have seen the future and it is very much like the present, only longer."
# --Kehlog Albran, The Profit
# Time Series Data
# Time Series data is usually a set of ordered data collected over equally spaced intervals. Time series data occurs in most business and scientific disciplines, and the data is closely tied to the concept of forecasting, which uses previously measured data points to predict future data points based upon a specific statistical model.
# Time series data differs from the kind of data that we have been looking at previously, because it is a set of ordered data points, it can contain components such as trend, seasonality, and autocorrelation, which have no meaning in other kinds of analysis.
# Usually time series data is collected in equally spaced intervals, such as days, weeks, quarters, or years, but that is not always the case. Measurement of events such as natural disasters are a prime example.  In some cases you can transform uneven data into equally spaced data, Often data needs to be prepped in order to have it conform to a certain model. In other cases, you can use specialized techniques such as Croston's method for forecasting intermittent, or unexpected demand for goods and services, in certain cases.
# Exploring Time Series data
# Many time series study start out by exploring one data metric which has been measured across equally spaced time intervals.  In a data science perspective, we could be interested in identifying various segments of a time series which could be exhibiting interesting trends, cyclical, or seasonal patterns. So, we always begin time series by looking at the data graphically, and producing aggregate measures before proceeding with the modeling.
# Health Insurance Coverage Data Set
# We will start by reading in a data set which contains Health Care enrollment data over a period for several categories. This data has been source -from "Table HIB-2. Health Insurance Coverage Status and Type of Coverage All Persons by Age and Sex: 1999 to 2012" and it is available from the CMS website at:
# http://www.census.gov/data/tables/time-series/demo/health-insurance/historical-series/hib.html
# This table shows the number of people covered by government and private insurance, as well as the number of people not covered.
# This table has several embedded time series across all the 14 years represented.  14 data points would not be considered an extremely long time series, however we will use this data to demonstrate how we can comb thru many time series at once. since it IS small, it will be easy enough to verify the results via visual inspection and printing subsets of the data.  As you become familiar with the methodology, it will enable you to expand to larger complex datasets with more data points, in order to isolate the most significant trends.
# Housekeeping
# As we have done in other chapters,  we will first clear the workspace, and set our working directory. Obviously, change the setwd to the path that you are using to store your files.
rm(list = ls())
#RW new
setwd("C:/PracticalPredictiveAnalytics/Data")

# Read the data in
# Next we will read in a few rows of the file (using the nrow parameters), and then run a str() function on the input to see which variables are contained within the file.  There are several metrics in the file related to Medicare enrollment. We will just concentrate on the total enrollment metrics, and not utilize some of the others, even though they probably produce separate insights.
x <- read.csv("hihist2bedit.csv", nrow = 10)
str(x)
# > 'data.frame': 10 obs. of  13 variables:
# >  $ Year        : Factor w/ 10 levels "2003","2004 (4)",..: 10 9 8 7 6 5 4 3 2 1
# >  $ Year.1      : int  2012 2011 2010 2009 2008 2007 2006 2005 2004 2003
# >  $ Total.People: num  311116 308827 306553 304280 301483 ...
# >  $ Total       : num  263165 260214 256603 255295 256702 ...
# >  $ pritotal    : num  198812 197323 196147 196245 202626 ...
# >  $ priemp      : num  170877 170102 169372 170762 177543 ...
# >  $ pridirect   : num  30622 30244 30347 29098 28513 ...
# >  $ govtotal    : num  101493 99497 95525 93245 87586 ...
# >  $ govmedicaid : num  50903 50835 48533 47847 42831 ...
# >  $ govmedicare : num  48884 46922 44906 43434 43031 ...
# >  $ govmilitary : num  13702 13712 12927 12414 11562 ...
# >  $ Not.Covered : num  47951 48613 49951 48985 44780 ...
# >  $ cat         : Factor w/ 1 level "ALL AGES": 1 1 1 1 1 1 1 1 1 1
# 
# Subsetting the columns
# For this exercise, we will be using a restricted set of columns from the csv file. We can either select the specific columns from the dataframe just read in (if we just read in the whole file), or reread the csv file using the colClasses parameter to only read the columns that are required. Often this method is preferable when you are reading large file, and will instruct read.csv to only retain the first 3 and the last 2 columns, and ignore the columns "priemp thru govmilitary".
# After re-reading in the file, with a subset of the columns, we print a few records from the beginning and end of the file. We can do this using a combination of the rbind, head and tail functions.  This will give us all of the columns we will be using for this chapter, except for some columns which we will derive in the next section.
x <- read.csv("hihist2bedit.csv", colClasses = c(NA, 
NA, NA, NA, rep("NULL", 7)))

rbind(head(x), tail(x))
# >          Year Year.1 Total.People     Total Not.Covered
# > 1        2012   2012    311116.15 263165.47  47950.6840
# > 2        2011   2011    308827.25 260213.79  48613.4625
# > 3   2010 (10)   2010    306553.20 256602.70  49950.5004
# > 4        2009   2009    304279.92 255295.10  48984.8204
# > 5        2008   2008    301482.82 256702.42  44780.4031
# > 6        2007   2007    299105.71 255017.52  44088.1840
# > 331  2004 (4)   2004     20062.67  19804.54    258.1313
# > 332      2003   2003     19862.49  19615.92    246.5703
# > 333      2002   2002     19705.99  19484.01    221.9879
# > 334      2001   2001     19533.99  19354.19    179.8033
# > 335  2000 (3)   2000     19450.52  19250.63    199.8871
# > 336  1999 (2)   1999     19378.56  19189.17    189.3922
# >                          cat
# > 1                   ALL AGES
# > 2                   ALL AGES
# > 3                   ALL AGES
# > 4                   ALL AGES
# > 5                   ALL AGES
# > 6                   ALL AGES
# > 331 FEMALE 65 YEARS AND OVER
# > 332 FEMALE 65 YEARS AND OVER
# > 333 FEMALE 65 YEARS AND OVER
# > 334 FEMALE 65 YEARS AND OVER
# > 335 FEMALE 65 YEARS AND OVER
# > 336 FEMALE 65 YEARS AND OVER
# Description of the data
# Year and Year.1 (columns 1 and 2)
# Year is the year for which the annual enrollment figure are taken. You will notice that Year appears twice, in column 1 (as a factor) and then again in column2 (integer).   This is because the data has been previously preprocess, and appears twice merely for convenience, since there are certain instances in which we will prefer to use a factor, and other instances in which we prefer to use an integer. The numbers in parentheses in Year refer to footnotes in the original data source.  While you could always create integers from factors and vice versa in the code, this saves valuable processing time if certain transformations can be made available beforehand.
# Total People (column 3)
# Total People is the population size of the category. They may either enrolled for health coverage (Total), or not (Not.Covered).
# Total (Column 4)
# Total is the number of people who were enrolled for health coverage for that year and in the category "cat".
# Not.Covered (Column 5)
# Not.Covered is the number of people NOT enrolled in the specified  year and category.
# Cat  (Column 6)
# Cat is the time series subset . 
# This column, along with year,  defines the particular row.  It defines the specific demographic data for enrollment for that year.
# The "ALL AGES"  category represents the entire population for the specified year. All of the other subsets in the file should roll up to this category when totaled together.
# For example, the last category, (printed as part of tail()) represents Females Over 65, which is a subset of the ALL AGES category.
# Target Time series variable
# The variable that we will begin to look at initially, will be the variable "Not.Covered". We will be interested in examining any possible enrollment trends using this variable. Since the population size will different depending upon the category, we will calculate the percentage of people not covered in a given year by dividing the raw number corresponding the this variable, by the total in the population for that category.  This will give us a new variable named "Not.Covered.Pct".This will also standardize the metric across the different sized categories, large and small, and enable us to compare.
# After calculating the variable, we can print the first few records,and also print some summary statistics for this one variable.
x$Not.Covered.Pct <- x$Not.Covered/x$Total.People
head(x)
# >        Year Year.1 Total.People    Total Not.Covered      cat
# > 1      2012   2012     311116.2 263165.5    47950.68 ALL AGES
# > 2      2011   2011     308827.2 260213.8    48613.46 ALL AGES
# > 3 2010 (10)   2010     306553.2 256602.7    49950.50 ALL AGES
# > 4      2009   2009     304279.9 255295.1    48984.82 ALL AGES
# > 5      2008   2008     301482.8 256702.4    44780.40 ALL AGES
# > 6      2007   2007     299105.7 255017.5    44088.18 ALL AGES
# >   Not.Covered.Pct
# > 1       0.1541247
# > 2       0.1574131
# > 3       0.1629424
# > 4       0.1609860
# > 5       0.1485338
# > 6       0.1474000
# 
summary(x$Not.Covered.Pct)
# 
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
# 0.009205 0.109400 0.145300 0.154200 0.210400 0.325200
# # 
# 
# As typical with target variable, we also like to see basic plots showing the distribution of the variable.
# 
# 
hist(x$Not.Covered.Pct)
# Saving the data
# This may be a good time to save the current data to a file, since we may want to read it back later starting from the analysis stage. This will avoid having to reread the same file again, unless, of course the source data changes.
setwd("C:/PracticalPredictiveAnalytics/Outputs")

save(x, file = "x.RData")
# Determine all of the Subset Groups
# Since we have only looked at parts of the file (via head or tail), we do not know how many categories there are and how they differ in terms of health care coverage. So we will start off by looking at some of the groupings.
# In previous chapters we have used sql, and the aggregate function to group data. For this example we will use dplyr.  One advange of Dplyr is that it can also be used with 'pipe' syntax, which allows the result of one function to be passed to the next function without intermediate assignments. 
library(dplyr)
# > 
# > Attaching package: 'dplyr'
# > The following objects are masked from 'package:stats':
# > 
# >     filter, lag
# > The following objects are masked from 'package:base':
# > 
# >     intersect, setdiff, setequal, union
# # str(x)
# 
# 
# The by.cat object will show the average number insured, and the average total population for each category. Remember, this data is also grouped by year, however we just want to get a sense of what the averages are across all of the years for now. Since the arrange function will end up sorting the data by the Total population sizes, from largest to smallest, we can see that the numbers line up as expected. 
# 1.	"ALL AGES" is the largest category, 
# 2.	followed by "FEMALE ALL AGES", 
# 3.	and then "MALE ALL AGES". 
# As a sanity check, If you add the totals for the latter 2 categories, you can see that they sum to the "ALL AGES" category. 
# From the console,  we can see from the str(by.cat) function that there are 24 categories.
by.cat <- x %>% select(cat, Total, Total.People) %>% group_by(cat) %>% summarise(Avg.Total.Insured = mean(Total), 
Avg.People = mean(Total.People)) %>% arrange(desc(Avg.People))

str(by.cat)
# > Classes 'tbl_df', 'tbl' and 'data.frame': 24 obs. of  3 variables:
# >  $ cat              : Factor w/ 24 levels "18 to 24 YEARS",..: 7 14 22 24 3 4 2 23 6 15 ...
# >  $ Avg.Total.Insured: num  251243 130201 121042 66200 34762 ...
# >  $ Avg.People       : num  294700 150330 144371 73752 42433 ...
by.cat
# > Source: local data frame [24 x 3]
# > 
# >                      cat Avg.Total.Insured Avg.People
# >                   (fctr)             (dbl)      (dbl)
# > 1               ALL AGES         251242.96  294700.47
# > 2        FEMALE ALL AGES         130200.90  150329.73
# > 3          MALE ALL AGES         121042.06  144370.74
# > 4         UNDER 18 YEARS          66200.46   73752.50
# > 5         35 to 44 YEARS          34761.74   42433.12
# > 6         45 to 54 YEARS          35911.82   42100.20
# > 7         25 to 34 YEARS          29973.91   39942.64
# > 8    MALE UNDER 18 YEARS          33832.87   37700.70
# > 9      65 YEARS AND OVER          36199.32   36722.61
# > 10 FEMALE UNDER 18 YEARS          32367.59   36051.79
# > ..                   ...               ...        ...
# Merging the aggregate data back into the original data
# Often, you will want to augment your original data with some of the calculated data as derived above. In these cases, you can merge the data back into the original data using a common key. Again, we will use dplyr to take the results just obtained (by.cat), and join it back to the original data (x), using the common key "cat". 
# We will be using a left_join just for an example, however we could have used a right join to obtain the same results, since by.cat was completely derived from 'x'. After joining the two dataframes, we will end up with a new dataframe named 'x2' 
# # Merge the summary measures back into the original data. Merge by cat.
# 
#RW RM NOT NEEDED
rm(x2)
x2 <- by.cat %>% left_join(x, by = "cat")
head(x2)
# > Source: local data frame [6 x 9]
# > 
# >        cat Avg.Total.Insured Avg.People      Year Year.1 Total.People
# >     (fctr)             (dbl)      (dbl)    (fctr)  (int)        (dbl)
# > 1 ALL AGES            251243   294700.5      2012   2012     311116.2
# > 2 ALL AGES            251243   294700.5      2011   2011     308827.2
# > 3 ALL AGES            251243   294700.5 2010 (10)   2010     306553.2
# > 4 ALL AGES            251243   294700.5      2009   2009     304279.9
# > 5 ALL AGES            251243   294700.5      2008   2008     301482.8
# > 6 ALL AGES            251243   294700.5      2007   2007     299105.7
# > Variables not shown: Total (dbl), Not.Covered (dbl), Not.Covered.Pct (dbl)
# checking the time intervals
# Earlier, we mentioned needing to have equally sized time intervals. Additionally, before we perform any time series analysis, we need to check for the number of 'non-missing' time intervals. So, Let's check the number of enrollment years for each category.
# 
# Using dplyr, we can use summarize(n()) to count the number of entries for each category. 
# # -- summarize and sort by the number of years -- updated to x2
yr.count <- x2 %>% group_by(cat) %>% summarise(n = n()) %>% arrange(n)

# - we can see that there are 14 years for all of the groups.  That is good!
print(yr.count, 10)
# > Source: local data frame [24 x 2]
# > 
#   >                      cat     n
# >                   (fctr) (int)
# > 1         18 to 24 YEARS    14
# > 2         25 to 34 YEARS    14
# > 3         35 to 44 YEARS    14
# > 4         45 to 54 YEARS    14
# > 5         55 to 64 YEARS    14
# > 6      65 YEARS AND OVER    14
# > 7               ALL AGES    14
# > 8  FEMALE 18 to 24 YEARS    14
# > 9  FEMALE 25 to 34 YEARS    14
# > 10 FEMALE 35 to 44 YEARS    14
# > ..                   ...   ...
# We can see from the above that every category has 14 years of data represented. 
# So we don't have to worry about having uniform time period for each subset.  However, this is often not the case, and if you come across this, you may need to:
#   Impute data for years that are missing
# Only use common time periods
# Use specialized time series techniques to account for unequally spaced time series.
# Picking out the top groups in terms of average population size
# In many instances, we will only want to look at the top categories, especially when there are many demographical categories which have been subsetted. In this example there are only 24 categories, but in other examples there may be a much larger number of categories. 
# The dataframe x2 is already sorted by Avg.People.  Since we know that there are 14 enrollment records for each category, we can get the top 10 categories based upon the highest base population by selecting the first 14*10 (or 140) rows.  We will store this in a new dataframe 'x3' and save this to disk.
# since we know each group has 14 years, extracting the top 10 groups is
# easy to calculate

x3 <- x2[1:(14 * 10), ]
head(x3)
# > Source: local data frame [6 x 9]
# > 
#   >        cat Avg.Total.Insured Avg.People      Year Year.1 Total.People
# >     (fctr)             (dbl)      (dbl)    (fctr)  (int)        (dbl)
# > 1 ALL AGES            251243   294700.5      2012   2012     311116.2
# > 2 ALL AGES            251243   294700.5      2011   2011     308827.2
# > 3 ALL AGES            251243   294700.5 2010 (10)   2010     306553.2
# > 4 ALL AGES            251243   294700.5      2009   2009     304279.9
# > 5 ALL AGES            251243   294700.5      2008   2008     301482.8
# > 6 ALL AGES            251243   294700.5      2007   2007     299105.7
# > Variables not shown: Total (dbl), Not.Covered (dbl), Not.Covered.Pct (dbl)
# # 
#RW needed?
save(x3, file = "x3.RData")
# Plotting the data using Lattice
# The Lattice package is a useful package to learn especially for analysts who like to work in formula notation (y~x).
# In this example we will run a lattice plot in order to plot Not.Covered.Pct on the y axis, Year on the x axis, and produce separate plots by category.
# The main call is specified by:
#   xyplot(Not.Covered.Pct ~ Year | cat, data = x3)
# Since we are plotting the top ten groups, we can specify layout=c(5,2) to indicate we want to arrange the 10 plots in a 5*2 matrix. Not.Covered.Pct is to be arranged on the y axis (left side of the ~ sign), and Year is arranged along the x-axis (Right side of ~ sign). The bar (|) indicates that the data is to be plotted separately by each category.
library(lattice)
x.tick.number <- 14
at <- seq(1, nrow(x3), length.out = x.tick.number)
labels <- round(seq(1999, 2012, length.out = x.tick.number))

p <- xyplot(Not.Covered.Pct ~ Year | cat, data = x3, type = "l", main = list(label = "Enrollment by Categories", 
                                                                             cex = 1), par.strip.text = list(cex = 0.5), scales = list(x = list(labels = labels), 
                                                                                                                                       cex = 0.4, rot = 45), layout = c(5, 2))

trellis.device()

print(p)

# Plottingthe data using ggplot
# If you like using ggplot, a similar set of graphs can be rendered using facets.
require("ggplot2")

.df <- data.frame(x = x3$Year.1, y = x3$Not.Covered.Pct, z = x3$cat, s = x3$cat)
.df <- .df[order(.df$x), ]
.plot <- ggplot(data = .df, aes(x = x, y = y, colour = z, shape = z)) + geom_point() + 
  geom_line(size = 1) + scale_shape_manual(values = seq(0, 15)) + scale_y_continuous(expand = c(0.01, 
                                                                                                0)) + facet_wrap(~s) + xlab("Year.1") + ylab("Not.Covered.Pct") + labs(colour = "cat", 
                                                                                                                                                                       shape = "cat") + theme(panel.margin = unit(0.3, "lines"), legend.position = "none")
print(.plot)


# Sending output to an external File
# One benefit of assigning plots to a plot object is that you can later send the plots to an external file, such as pdf, view it exernally, and even view it in your browser directly from R.  For example, for the Lattice graphs example, you can use treliis.device and specify the output parameters, and then print the object. As we illustrated in an earlier chapter, you can use browseURL to open the PDF in your browser.
# send to pdf
#RW not needed
#setwd("C:/Users/randy/Desktop/ch7")
trellis.device(pdf, file = "x3.pdf", paper = "a4r", height = 8.3, width = 11.7, 
               col = F)

# --Not run 
# print(p) 
# 
#RW check this part
dev.off()
browseURL('x3.pdf')

browseURL('file://c://PracticalPredictiveAnalytics//Outputs//x3.pdf')
# Examining the output
# If we examine our 'top' plots we can see that some groups seem to be trending more than others. For example, the under 18 age group shows a enrollment trend that is declining, while the 25-54 age groups are trending up.
# Detecting linear trend
# In a linear trend model, one constructs a linear regression least squares line by running an lm regression thru the data points. These models are good for initially exploring trends visually.  We can take advantages of our lm function,  which is available in base R, in order to specifically calculate the slope of the trend line. 
# For example, we can compute the slope of the trend line for our first group ("ALL AGES"), and we can see that it has an upward trend. 
# After running the regression using the lm function, we can subsequently use the coef function to specifically extract the slope and the intercept from the lm model. Since this is a regression in which there is only one independent variable (Time), there will only be one coefficient.
lm(Not.Covered.Pct ~ Year.1, data = x2[1:14, ])
# > 
#   > Call:
#   > lm(formula = Not.Covered.Pct ~ Year.1, data = x2[1:14, ])
# > 
#   > Coefficients:
#   > (Intercept)       Year.1  
# >   -4.102621     0.002119
coef(lm(Not.Covered.Pct ~ Year.1, data = x2[1:14, ]))
# >  (Intercept)       Year.1 
# > -4.102621443  0.002119058
# Automating the regressions
# Now that we have seen how we can run a single time series regression, we can move on to   automating separate regressions and extracting the coefficients over all of the categories.
# There are several ways to do this. One way is by using the do() function within the dplyr package. In the example below: 
#   .	The data is first grouped by category
# .	Then, a linear regression (lm function) is run for each category, with Year as the independent variable, and Not.Covered as the dependent variable.
# .	The coefficient is extracted from the model. The coefficient will act as a proxy for trend Finally, a dataframe of lists is create (fitted.models) , where the coefficients and intercepts are stored for each regression run on every category. The categories which have the highest positive coefficients exhibit the greatest increasing linear trend, while the declining trend is indicated by negative coefficients.
library(dplyr)

fitted_models = x2 %>% group_by(cat) %>% do(model = coef(lm(Not.Covered.Pct ~ 
                                                              Year.1, data = .)))
# All of the generated models are now in the fitted_models object.
# The kable function from knitr gives a simple output which displays the intercept as the first number and the coefficient in the "model" column.  As a check, We can see that the coefficients in the "ALL AGES" model, are the identical to those derived in the previous section.
# str(fitted_models)
library(knitr)
kable(fitted_models)
# Cat	Model
# 18 to 24 YEARS	-0.4061834427, 0.0003367988
# 25 to 34 YEARS	-11.375187597, 0.005796182
# 35 to 44 YEARS	-10.916822084, 0.005534037
# 45 to 54 YEARS	-11.544566448, 0.005829194
# 55 to 64 YEARS	-4.709612146, 0.002409908
# 65 YEARS AND OVER	-1.2562375095, 0.0006334125
# ALL AGES	-4.102621443, 0.002119058
# FEMALE 18 to 24 YEARS	-2.677300003, 0.001455388
# FEMALE 25 to 34 YEARS	-9.990978769, 0.005088009
# FEMALE 35 to 44 YEARS	-9.564724041, 0.004850188
# FEMALE 45 to 54 YEARS	-10.36336551, 0.00523537
# FEMALE 55 to 64 YEARS	-4.102774957, 0.002108343
# FEMALE 65 YEARS AND OVER	-1.3674510779, 0.0006887743
# FEMALE ALL AGES	-3.817483824, 0.001970059
# FEMALE UNDER 18 YEARS	3.267593386, -0.001578328
# MALE 18 to 24 YEARS	4.036127727, -0.001862991
# MALE 25 to 34 YEARS	-9.715950286, 0.004983621
# MALE 35 to 44 YEARS	-7.706624821, 0.003941543
# MALE 45 to 54 YEARS	-10.975387917, 0.005549255
# MALE 55 to 64 YEARS	-5.370380544, 0.002738269
# MALE 65 YEARS AND OVER	-0.4834523450, 0.0002479691
# MALE ALL AGES	-4.315036958, 0.002232003
# MALE UNDER 18 YEARS	2.914343264, -0.001401998
# UNDER 18 YEARS	3.086509947, -0.001487938
# Ranking the coefficients
# Now that we have the coefficients, we can begin to rank each of the categories by increasing trend. Since the results we have obtained so far are contained in embedded lists, which are a bit difficult to work with, we can perform some code manipulation to transform them into a regular data frame, with 1 row per category, consisting of the category name, coefficient, and coefficient rank.
#RW remove
library(dplyr)
# extract the coefficients part from the model list, and then transpose the
# data frame so that the coefficient appear one per row, rather than 1 per
# column.

xx <- as.data.frame(fitted_models$model)
xx2 <- as.data.frame(t(xx[2, ]))

# The output does no contain the category name, so we will merge it back
# from the original data frame.

xx4 <- cbind(xx2, as.data.frame(fitted_models))[, c(1, 2)]  #only keep the first two columns

# rankthe coefficients from lowest to highest. Force the format of the rank
# as length 2, with leading zero's

tmp <- sprintf("%02d", rank(xx4[, 1]))

# Finally prepend the rank to the actual category
xx4$rankcat <- as.factor(paste(tmp, "-", as.character(xx4$cat)))

# name the columns
names(xx4) <- c("lm.coef", "cat", "coef.rank")
# and View the results
View(xx4)
# As you can see, columns 2,3, and 4 now contain neatly arranged representation of the coefficients, category, and coef.rank, which was derived by ranking lm.coef from smallest to largest, and then prepending the rank order to the category.
# 
# Merging scores back into the original dataframe
# We will augment the original x2 dataframe with this new information by merging back by category, and then by sorting the dataframe by the rank of the coefficient, this will allow us to use this as a proxy for trend.
x2x <- x2 %>% left_join(xx4, by = "cat") %>% arrange(coef.rank, cat)


# exclude some columns so as to fit on one page
head(x2x[, c(-2, -3, -4, -8)])
# > Source: local data frame [6 x 7]
# > 
#   >                   cat Year.1 Total.People    Total Not.Covered.Pct
# >                (fctr)  (int)        (dbl)    (dbl)           (dbl)
# > 1 MALE 18 to 24 YEARS   2012     15142.04 11091.86       0.2674787
# > 2 MALE 18 to 24 YEARS   2011     15159.87 11028.75       0.2725034
# > 3 MALE 18 to 24 YEARS   2010     14986.02 10646.88       0.2895460
# > 4 MALE 18 to 24 YEARS   2010     14837.14 10109.82       0.3186139
# > 5 MALE 18 to 24 YEARS   2008     14508.04 10021.66       0.3092339
# > 6 MALE 18 to 24 YEARS   2007     14391.92 10230.61       0.2891425
# > Variables not shown: lm.coef (dbl), coef.rank (fctr)
# Plotting the data with the trend lines
# Now that we have the trend coefficients, we will use ggplot to first plot enrollment for all of the 24 categories, and then create a 2nd set up plots which add the trend line based upon the linear coefficients we have just calculated.
# Code Notes: Facet_wrap will order the plots by the value of variable 'z', which was assigned to the coefficient rank. Thus, we can get to see the categories with declining enrollment first, ending with the categories having the highest trend in enrollment from the period 1999-2012
# Tip: I like to assign the variables that I will be changing to standard variable names, like x,y,and z, so that I can remember there usage (e.g variable x is always the x variable, and y always the x variable). But you can supply the variable names directly in the call to ggplot, or set up your own function to do the same thing.



library(ggplot2)
.df <- data.frame(x = x2x$Year.1, y = x2x$Not.Covered.Pct, z = x2x$coef.rank, 
                  slope = x2x$lm.coef)
.plot <- ggplot(data = .df, aes(x = x, y = y, colour = 1, shape = z)) + geom_point() + 
  scale_shape_manual(values = seq(0, 24)) + scale_y_continuous(expand = c(0.1, 
  0)) + scale_x_continuous(expand = c(0.1, 1)) + facet_wrap(~z) + xlab("Year.1") + 
  ylab("Not.Covered.Pct") + labs(colour = "cat", shape = "cat") + theme(panel.margin = unit(0.3, 
  "points"), legend.position = "none") + theme(strip.text.x = element_text(size = 6))
#RW?
print(.plot)

# As you can see, for the "ALL AGES" category, overall Non Covered percentage is seen to be increasing over the time period, until 2010 (where the Affordable Care Act was enacted), and then will begin to decrease. Contrarily, the under 18 age group shows a decrease in the proportion of non-insured relative to the population size.
# We can take a closer look at the top and bottom four categories, along with the "ALL AGES" category, to examine this more closely. This time we will add our own trend line using the geom_smooth parameter, which will add a linear regression trendline.
# .df <- data.frame(x = x2x$Year.1, y = x2x$Not.Covered.Pct, z =
# x2x$coef.rank, slope=x2x$lm.coef)

# declining enrollment
.df2 <- rbind(head(.df,(4*14)), tail(.df,(4*14)), .df[.df$z == "12 - ALL AGES", ])

.plot2 <- ggplot(data = .df2, aes(x = x, y = y, colour = 1, shape = z)) + geom_point() + 
  scale_shape_manual(values = seq(0, nrow(.df2))) + scale_y_continuous(expand = c(0.1,0)) + 
  scale_x_continuous(expand = c(0.1, 1)) + facet_wrap(~z) + xlab("Year.1") + 
  ylab("Not.Covered.Pct") + labs(colour = "cat", shape = "cat") + theme(panel.margin = unit(0.3,"points"), 
  legend.position = "none") + geom_smooth(method = "lm", se = FALSE, 
  colour = "red")
print(.plot2)

# Plotting all the categories on 1 graph.
# Sometimes we like to plot all of the lines on one graph rather having them as separate plots. To achieve this, we will alter the synax a bit, so that the categories show up as stacked lines. Again we can see the percentage of uninsured align across ages, with the under 18 group having the lowest uninsured rate, and the 25-54 group having the highest.

library(ggplot2)
### plot all on one graph

.df <- data.frame(x = x3$Year.1, y = x3$Not.Covered.Pct, z = x3$cat)
rm(.df)
rm(.plot)
.df <- x3[order(x3$Year.1), ]
# str(.df)
.plot <- ggplot(data = .df, aes(x = Year.1, y = Not.Covered.Pct, colour = cat,shape = cat)) + 
  geom_point() + geom_line(size = 1) + scale_shape_manual(values = seq(0,15)) + 
  ylab("Not.Covered.Pct") + labs(colour = "cat", shape = "cat") + theme_bw(base_size = 14,base_family = "serif")


print(.plot)


# Adding labels
# It can sometimes be a bit difficult to discern the differences among the categories based the legend, especially as the number of categories increase, so we can use the directlables library to mark each line with the category name. Now we can see, for example, that ALL MALES have a higher uninsured rate than ALL FEMALES over all time periods.
library(directlabels)
direct.label(.plot, list(last.points, hjust = 0.75, cex = 0.75, vjust = 0))

# Performing some automated forecasting using the ets function
# So far we have looked at ways in which we can explore any linear trends which may be inherent in our data.  That provided a solid foundation for the next step, prediction. Now we will begin to start to look at how we can perform some actual forecasting.
# Converting the dataframe to a time series object
# As a preparation step, We will use the ts function to convert our dataframe to a time series object. It is important that time series be equally spaced before converting to a ts object. At minimum, you supply the time series variable, and start and end dates as argument to the ts function.
# After creating a new object "x", run a str() function to verify that all of the 14 time series from 1999 to 2012 have been created. 
# only extract the 'ALL' timeseries
x <- ts(x2$Not.Covered.Pct[1:14], start = c(1999), end = c(2012), frequency = 1)

str(x)
# >  Time-Series [1:14] from 1999 to 2012: 0.154 0.157 0.163 0c.161 0.149 ...
# Smoothing the data using Moving Averages
# One simple technique used to analyze time series are simple and exponential moving averages. Both Simple Moving averages and Exponential Moving Average are ways in which we can smooth out the random noise in the series and observe cycles and trends.
# Simple Moving Average
# A simple Moving Average will simply take the sum of the time series variable for the last k periods and then will divide it by the number of periods. In this sense, it is identical to the calculation for the mean. However what makes it different from a simple mean is that:
#   .	the average will shift for every additional time period.  Moving averages are backward looking, and every time a time period shifts, so will the average.  That is why they are called "Moving". Moving Average are sometimes called Rolling Averages.
# .	The look backwards period can shift.  That is the 2nd characteristic of a moving average.  A 10 period moving average will take the average of the last 10 data elements, while a 20 period moving average will take the sum of the last 20 data points, and then divide by 20.  
# Computing the SMA using a function
# To compute a rolling 5 period moving average for our data, we will use the Simple Moving Average (SMA) function from the TTR package, and then display the first few rows.
library(TTR)
MA <- SMA(x, n = 5)
cbind(head(x, 14), head(MA, 14))
# >            [,1]      [,2]
# >  [1,] 0.1541247        NA
# >  [2,] 0.1574131        NA
# >  [3,] 0.1629424        NA
# >  [4,] 0.1609860        NA
# >  [5,] 0.1485338 0.1568000
# >  [6,] 0.1474000 0.1554551
# >  [7,] 0.1523271 0.1544379
# >  [8,] 0.1464598 0.1511414
# >  [9,] 0.1433967 0.1476235
# > [10,] 0.1455136 0.1470194
# > [11,] 0.1391090 0.1453612
# > [12,] 0.1347953 0.1418549
# > [13,] 0.1308892 0.1387408
# > [14,] 0.1362041 0.1373023
# There are many ways in which you can plot the moving average with the original data. Using base R, use the ts.plot function to do this, which takes the original series and the moving average of the series as arguments.
ts.plot(x, MA, gpars = list(xlab = "year", ylab = "Percentage of Non-Insured",lty = c(1:2)))
title("Percentage of Non-Insured 1999-2012 - With SMA")

# You can see how moving averages are helpful in showing the upward and downward movements of the data, and also help smooth the data to help eliminate some of the noise.  Also notice that a moving average needs some "starter" data to begin calculations, so that is why the dotting moving average line is missing from the first 4 time periods of the graph.  Only by the 5th period is it able to determine the calculation by summing up the values which correspond to the time period 1999-2003 and then dividing by 5.  The next point is derived by summing up the values corresponding the the time periods 2000-2004 and then again dividing by 5.
# Verifying the SMA Calculation
# It is always important to be able to verify calculation, to insure that the values have been performed correctly, and to promote understanding.
# In the case of the Simple Moving Average, we can switch to the console, and calculate the value of the SMA for the last 5 data points:
#   First we calculate the sum of the elements and then divide by the number of data points in the moving average (5):
  sum(x[10:14])/5
# > [1] 0.1373023
# That matches exactly with the column , given for the Simple Moving Average (SMA)
# Exponential Moving Average
# For a Simple Moving Average, equal weight is given to all data points, regardless of how old or how recent they occurred.   An Exponential Moving Average (EMA) gives move weight to recent data, under the assumption that the future is move likely to look like the recent past, rather than the "older past".
# The exponential Moving average is actually a much simpler calculation. An EMA begins by calculating a simple moving average. When it reach the specified number of lookback periods (n) it computes the current value by weighing the value of the current value with the previous value of the EMA. 
# This weighting is specified by the smoothing (or ratio ) factor. When ratio=1, the predicted value is entirely based upon the last time value. For ratios b=0, the prediction is based upon the average of the entire lookback period.  Therefore the closer the smoothing factor is to 1, the more weight it will give to recent data.  If you want to give additional weight to older data, decrease the smoothing factor towards 0.
# Generally the formula for an EMA is:
# {Current Data Point - EMA(previous)} x smoothing factor + EMA(previous day)
# To compute the EMA, you can use the EMA function (from the TTR package).  You need to specify a smoothing constant (ratio), as well as a lookback period (n).
# Computing the EMA using a function
# The following code computes the EMA, along with the Simple Moving Average which was computed in the last section.
# The following plot shows the data in graph form.  You can see that each data point is closer to its EMA that to the SMA, which as mentioned earlier, weights all previous data points equally within the lookback period. In this regard EMA's react quicker to the recent data, while SMA are slower moving, and have less variability.  Of course both are affected by the parameters, especially the lookback period.  Longer lookbacks will make for slower moving averages, in both cases.
ExpMA <- EMA(x, n = 5, ratio = 0.8)
cbind(head(x, 15), head(MA, 15), head(ExpMA, 15))
# >            [,1]      [,2]      [,3]
# >  [1,] 0.1541247        NA        NA
# >  [2,] 0.1574131        NA        NA
# >  [3,] 0.1629424        NA        NA
# >  [4,] 0.1609860        NA        NA
# >  [5,] 0.1485338 0.1568000 0.1568000
# >  [6,] 0.1474000 0.1554551 0.1492800
# >  [7,] 0.1523271 0.1544379 0.1517177
# >  [8,] 0.1464598 0.1511414 0.1475114
# >  [9,] 0.1433967 0.1476235 0.1442196
# > [10,] 0.1455136 0.1470194 0.1452548
# > [11,] 0.1391090 0.1453612 0.1403382
# > [12,] 0.1347953 0.1418549 0.1359039
# > [13,] 0.1308892 0.1387408 0.1318922
# > [14,] 0.1362041 0.1373023 0.1353417
ts.plot(x, ExpMA, gpars = list(xlab = "year", ylab = "Percentage of Non-Insured",lty = c(1:2)))
title("Percentage of Non-Insured 1999-2012 - With EMA")
#using 
# Using the ets function
# We will now use the ets function (forecast package) to compute an exponentially smoothed model for the "ALL AGES" category.
# The ets function is flexible in that it can also incorporate trend, as well as seasonality for its forecasts. 
# We will just be illustrating a simple exponentially smoothed model ("ANN").  However, for completeness, you should know that you specify three letters when calling the ets function, and you should be aware of what each letter represents.  Otherwise, it will model based upon the default parameters.
# Here is the description as specified by the package author, Hydman:
#   .	The first letter denotes the error type ("A", "M" or "Z")
# .	The second letter denotes the trend type ("N","A","M" or "Z")
# .	The third letter denotes the season type ("N","A","M"or "Z")
# In all cases, "N"=none, "A"=additive, "M"=multiplicative and "Z"=automatically selected.
# So for our example, if we want to model a simple exponentially smoothed model, as we did in our manual calculations, so we would specify model=ANN. 
# Forecasting using "ALL AGES" 
# The code below will perform the following steps:
#   .	First in will filter out the "ALL AGES" category 
# .	Create a time series object
# .	Run a simple exponential model, using the ets function
# Note that we did not specify a smoothing factor.  The ets functions calculates the optimal smoothing factor, (alpha, shown via the summary function) which in this case is .99, which means that model time series takes about 99% of the previous value to incorporate into the next time series prediction.
library(dplyr)
# > 
#   > Attaching package: 'dplyr'
# > The following objects are masked from 'package:stats':
#   > 
#   >     filter, lag
# > The following objects are masked from 'package:base':
#   > 
#   >     intersect, setdiff, setequal, union
library(forecast)
# > Loading required package: zoo
# > 
#   > Attaching package: 'zoo'
# > The following objects are masked from 'package:base':
#   > 
#   >     as.Date, as.Date.numeric
# > Loading required package: timeDate
# > This is forecast 7.1
x4 <- x2[x2$cat == "ALL AGES", ]

# set up as a time series object
x <- ts(x4$Not.Covered.Pct, start = c(1999), end = c(2012), frequency = 1)

fit <- ets(x, model = "ANN")
summary(fit)
# > ETS(A,N,N) 
# > 
#   > Call:
#   >  ets(y = x, model = "ANN") 
# > 
#   >   Smoothing parameters:
#   >     alpha = 0.9999 
# > 
#   >   Initial states:
#   >     l = 0.1541 
# > 
#   >   sigma:  0.0052
# > 
#   >       AIC      AICc       BIC 
# > -106.3560 -105.2651 -105.0779 
# > 
#   > Training set error measures:
#   >                        ME        RMSE        MAE        MPE     MAPE
# > Training set -0.001279923 0.005191075 0.00430566 -0.9445532 2.955436
# >                   MASE        ACF1
# > Training set 0.9286549 0.004655079
# Plotting the Predicted and Actual Values
# Next, we can plot the predicted vs actual values.  Notice that the predicted values are almost identical to the actual values, however they are always one step ahead.
plot(x)
lines(fit$fitted, col = "red")
# We can 
# The forecast(fit) method
# The forecast method contains many objects which you can display, so as the fitted value, original values, confidence intervals and residuals.  Use str(forecast(fit)) to see which objects are available.
# We will use cbind to print out the original data point, fitted data point, and model fitting method.
# We can also use View to show some of the forecast object in matrix form.
cbind(forecast(fit)$method,forecast(fit)$x,forecast(fit)$fitted,forecast(fit)$residuals)
# Time Series:
#   Start = 1999 
# End = 2012 
# Frequency = 1 
# forecast(fit)$method   forecast(fit)$x forecast(fit)$fitted forecast(fit)$residuals
# 1999           ETS(A,N,N)  0.15412470117969    0.154120663632029    4.03754766081788e-06
# 2000           ETS(A,N,N) 0.157413125646824    0.154124700770241     0.00328842487658335
# 2001           ETS(A,N,N) 0.162942355969924    0.157412792166205     0.00552956380371911
# 2002           ETS(A,N,N) 0.160986044554207    0.162941795214416      -0.001955750660209
# 2003           ETS(A,N,N) 0.148533847659868    0.160986242887746     -0.0124523952278778
# 2004           ETS(A,N,N) 0.147400008880004    0.148535110462768    -0.00113510158276331
# 2005           ETS(A,N,N) 0.152327126236553    0.147400123991157     0.00492700224539561
# 2006           ETS(A,N,N) 0.146459794092561    0.152326626587079    -0.00586683249451758
# 2007           ETS(A,N,N)  0.14339666192983    0.146460389050636    -0.00306372712080566
# 2008           ETS(A,N,N) 0.145513631588618    0.143396972623751     0.00211665896486724
# 2009           ETS(A,N,N) 0.139109023459534    0.145513416937297    -0.00640439347776356
# 2010           ETS(A,N,N) 0.134795323545856    0.139109672931905    -0.00431434938604935
# 2011           ETS(A,N,N) 0.130889234985064    0.134795761065932    -0.00390652608086872
# 2012           ETS(A,N,N) 0.136204104247743    0.130889631147599     0.00531447310014455

View(forecast(fit))


# Plotting the future values with confidence bands
# Use the plot function to plot the future predictions. Notice that the prediction for the last value encompasses upper and lower confidence bands surrounding a horizontal prediction line. But why a horizontal prediction line? This is saying that there is no trend or seasonality for the exponential model, and that the best prediction is based upon the last value of the smoothed average.  However, we can see that there is significant variation to the prediction, based upon the confidence bands. The confidence bands will also increase in size as the forecast period increases, to reflect the uncertainty associated with the forecast.
plot(forecast(fit))



# If we 
# 
# Modifying the model to include a trend components
# Earlier, we added a linear trend line to the data. If we wanted to incorporate a linear trend into the forecast as well, we can substitute "A" for the second parameter (trend parameter), which yields an "AAN" model (Holt's linear trend). This type of method allows exponential smoothing with a trend.  
fit <- ets(x, model = "AAN")
summary(fit)
# > ETS(A,A,N) 
# > 
#   > Call:
#   >  ets(y = x, model = "AAN") 
# > 
#   >   Smoothing parameters:
#   >     alpha = 0.0312 
# >     beta  = 0.0312 
# > 
#   >   Initial states:
#   >     l = 0.1641 
# >     b = -0.0021 
# > 
#   >   sigma:  0.0042
# > 
#   >       AIC      AICc       BIC 
# > -108.5711 -104.1267 -106.0149 
# > 
#   > Training set error measures:
#   >                        ME        RMSE         MAE        MPE    MAPE
# > Training set -0.000290753 0.004157744 0.003574276 -0.2632899 2.40212
# >                   MASE       ACF1
# > Training set 0.7709083 0.05003007
plot(forecast(fit))

# Running the ets function iteratively over all of the categories
# Now that we have run an ets model on one category, we can construct some code to automate model construction over ALL of the categories.  In the process, we will also save some of the accuracy measures so that we can see how our models performed.
# .	First, we will sort the dataframe by category, and then by year. 
# .	Then initialize a new dataframe (onestep.df) that we will use to store the accuracy results for each moving window prediction of test and training data
# .	Then we will process each of the groups, all which have 14 time periods, as an iteration in a for loop
# .	For each iteration, extract a test and training dataframe
# .	Fit a simple exponential smoothed model for the training dataset
# .	Apply a model fit to the test dataset
# .	Apply the accuracy function in order to extract the validation statistics
# .	Store each of them in the onestep.df dataframe which was initialized in the previous step
df <- x2 %>% arrange(cat, Year.1)

# create results data frame
onestep.df <- data.frame(cat = character(), rmse = numeric(), mae = numeric(), 
                         mape = numeric(), acf1 = numeric(), stringsAsFactors = FALSE)

# 
# 
library(forecast)
iterations <- 0
for (i in seq(from = 1, to = 999, by = 14)) {
  j <- i + 13
  # pull out the next category.  It will always be 14 records.
  x4 <- df[i:j, ]
  x <- ts(x4$Not.Covered.Pct, start = c(1999), end = c(2012), frequency = 1)
  
  # assign the first 10 records to the training data, and the next 4 to the
  # test data.
  
  
  trainingdata <- window(x, start = c(1999), end = c(2008))
  testdata <- window(x, start = c(2009), end = c(2012))
  
  
  par(mfrow = c(2, 2))
  
  # first fit the training data, then the test data. 
  # Use simple exponential smoothing
  fit <- ets(trainingdata, model = "ANN")
  # summary(fit)
  fit2 <- ets(testdata, model = fit)
  onestep <- fitted(fit2)
  
  iterations <- iterations + 1
  onestep.df[iterations, 1] <- paste(x4$cat[1])
  onestep.df[iterations, 2] <- accuracy(onestep, testdata)[, 2]  #RMSE
  onestep.df[iterations, 3] <- accuracy(onestep, testdata)[, 3]  #MAE
  onestep.df[iterations, 4] <- accuracy(onestep, testdata)[, 5]  #MAPE
  onestep.df[iterations, 5] <- accuracy(onestep, testdata)[, 7]  #ACF1
  
  if (iterations == 24) 
    break
}

# Viewing the prediction with the original values
# In the code above the fit object contains the original training data along with the fitted values. We can also print the residuals, which are the actual values minus the fitted values. The residuals are important, since they are usually the basis for the accuracy measures.
tail(x4)
# > Source: local data frame [6 x 9]
# > 
#   >              cat Avg.Total.Insured Avg.People      Year Year.1
# >           (fctr)             (dbl)      (dbl)    (fctr)  (int)
# > 1 UNDER 18 YEARS          66200.46    73752.5      2007   2007
# > 2 UNDER 18 YEARS          66200.46    73752.5      2008   2008
# > 3 UNDER 18 YEARS          66200.46    73752.5      2009   2009
# > 4 UNDER 18 YEARS          66200.46    73752.5 2010 (10)   2010
# > 5 UNDER 18 YEARS          66200.46    73752.5      2011   2011
# > 6 UNDER 18 YEARS          66200.46    73752.5      2012   2012
# > Variables not shown: Total.People (dbl), Total (dbl), Not.Covered (dbl),
# >   Not.Covered.Pct (dbl)
head(onestep.df)
# >                 cat        rmse         mae      mape      acf1
# > 1    18 to 24 YEARS 0.013772470 0.009869590  3.752381 1.0000552
# > 2    25 to 34 YEARS 0.004036661 0.003380938  1.217612 1.0150588
# > 3    35 to 44 YEARS 0.006441549 0.004790155  2.231886 0.9999469
# > 4    45 to 54 YEARS 0.004261185 0.003129072  1.734022 0.9999750
# > 5    55 to 64 YEARS 0.005160212 0.004988592  3.534093 0.7878765
# > 6 65 YEARS AND OVER 0.002487451 0.002096323 12.156875 0.9999937
cbind(fit$x, fit$fitted, fit$residuals)
# > Time Series:
#   > Start = 1999 
# > End = 2008 
# > Frequency = 1 
# >           fit$x fit$fitted fit$residuals
# > 1999 0.11954420  0.1056241  0.0139200744
# > 2000 0.10725759  0.1056255  0.0016320737
# > 2001 0.10649619  0.1056257  0.0008705016
# > 2002 0.10291788  0.1056258 -0.0027078918
# > 2003 0.10393522  0.1056255 -0.0016902769
# > 2004 0.09942592  0.1056253 -0.0061994140
# > 2005 0.10320781  0.1056247 -0.0024169001
# > 2006 0.11231138  0.1056245  0.0066869135
# > 2007 0.10587369  0.1056251  0.0002485556
# > 2008 0.09527547  0.1056252 -0.0103496921

mean(fit$residuals)
# > [1] -6.056125e-07
# We should also plot the residuals for this category. 
absresid <- abs(fit2$residuals)
plot(absresid)

# Fit2 is the testdata along with the fitted values from the model developed from the training data (fit).
cbind(fit2$x, fit2$fitted, fit2$residuals)
# > Time Series:
#   > Start = 2009 
# > End = 2012 
# > Frequency = 1 
# >          fit2$x fit2$fitted fit2$residuals
# > 2009 0.09745024  0.09451361   0.0029366252
# > 2010 0.09785322  0.09451391   0.0033393083
# > 2011 0.09397731  0.09451424  -0.0005369347
# > 2012 0.08877369  0.09451419  -0.0057404940

mean(fit2$residuals)
# > [1] -3.738216e-07
# Accuracy Measures
# Using the residuals, we can measure the error from the predicted and actual values based upon three popular accuracy measures.
# Mean Absolute Error (MAE):  This measure takes the mean of the absolute values of all of the errors (residuals)
# Root Mean Squared Error (RMSE): The root mean square error measures the error by first taking the mean of all of the squared errors, and then takes the square root of the mean, in order to revert back to the original scale.  This is a standard statistical method of measuring errors.
# Tip: Both MAE, and RMSE are scale dependent measures, which means that that they can be used to compare problems with similar scales.  When comparing accuracy among models with different scales, other scale independent measures such as MAPE should be used.
# Mean Percentage Error MAPE - This is the absolute difference between the actual and forecasted value, expressed as a percentage of the actual value.  This is intuitively easy to understand and is a very popular measure. 
# 
# We can look at the worst performing models, in terms of a metric such as MAPE, by simply sorting the onestep.df object by the MAPE columns.
onestep.df %>% arrange(., desc(mape)) %>% head()
# >                      cat        rmse         mae      mape      acf1
# > 1 MALE 65 YEARS AND OVER 0.002647903 0.002226841 17.440671 0.5781697
# > 2    MALE 35 to 44 YEARS 0.039044319 0.024111701 14.218445 0.9999903
# > 3      65 YEARS AND OVER 0.002487451 0.002096323 12.156875 0.9999937
# > 4    MALE 25 to 34 YEARS 0.024195057 0.019901117  6.748294 0.9999310
# > 5    MALE 45 to 54 YEARS 0.017711280 0.010388681  6.380865 0.9999900
# > 6  FEMALE 55 to 64 YEARS 0.006749771 0.005610275  4.021224 0.5038707
# Charting all of the MAPE's at once show that the exponential model works better for the younger groups, and seems to degrade for older groups, especially for Males.
lattice::barchart(cat ~ mape, data = onestep.df)


