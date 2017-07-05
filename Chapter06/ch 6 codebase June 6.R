# 6
# Using Market Basket Analysis as a Recommender Engine
# "It's not wise to violate the rules until you know how to observe them." - T.S. Eliot
# What is Market Basket Analysis?
# If you have "survived" the last chapter, you will now be introduced to the world of Market Basket Analysis. Market Basket Analysis (also sometimes called affinity analysis), is a predictive analytics technique which is used heavily in the retail industry in order to identify "baskets" of items which are purchased together. The typical use case for this is the supermarket shopping cart in which a shopper would typically purchase an assortment of items such as Milk, Bread, Cheese, etc. and the algorithm will predict how purchasing certain items together will affect the purchase of other items. It is one of those methods that retailers know to start sending you coupons, emails for things that you didn't know you needed! 
# One most quoted example of MBA is the relationship between diapers and beer: 
# "One super market chain discovered in its analysis that customers that bought diapers often bought beer as well, have put the diapers close to beer coolers, and their sales increased dramatically" - http://en.wikipedia.org/wiki/Market_basket
# However, it is not only restricted to the retail industry. Market Basket Analysis (or MBA) can be used in the insurance industry to look at the various products that an insured currently has, such as car, home, etc. as suggest possible other products such as life, disability, or investment products.
# MBA is generally considered an unsupervised learning algorithm, in that target variables are usually not specified. However, as you will see later it is possible to refine the association rules, so that specific items can be specified as target variables.
# MBA is also considered as a type of recommender engine in which purchases of a set of items imply the purchases of others. Certainly MBA and other recommender engines can share the same types of input data. However, MBA was developed before the advent of collaborative filtering techniques, as pioneered by Amazon, and is more suggestive of the integration of collected Web data, while MBA is more associated with the RFID Bar Coding technologies found in scanners. However in both cases, suggestions of future purchases based on past purchases is the goal.
# Terminology
# Critical to the understanding of MBA are the concepts of support, confidence, and lift. These are the measures which evaluated the 'goodness of fit' for a set of association rules. You will also learn some specific definitions that are used in MBA, such as consequence, antecedent, and itemsets.
# To introduce these concepts, we will first illustrate these terms through a very simplistic example. We will use only the first 10 transactions contained in the "Groceries" transaction file, which is contained in the package "arules".
# To see an example of a market basket, run the following code. Examine the output produced from the 'inspect' function, which prints items in the market basket.
rm(list = ls())
library(arules)
#library(datasets)

data(Groceries)
str(Groceries)
#RW changed added
summary(Groceries)

inspect(Groceries[10:19])
# >    items                      
# > 1  {whole milk,               
# >     cereals}                  
# > 2  {tropical fruit,           
# >     other vegetables,         
# >     white bread,              
# >     bottled water,            
# >     chocolate}                
# > 3  {citrus fruit,             
# >     tropical fruit,           
# >     whole milk,               
# >     butter,                   
# >     curd,                     
# >     yogurt,                   
# >     flour,                    
# >     bottled water,            
# >     dishes}                   
# > 4  {beef}                     
# > 5  {frankfurter,              
# >     rolls/buns,               
# >     soda}                     
# > 6  {chicken,                  
# >     tropical fruit}           
# > 7  {butter,                   
# >     sugar,                    
# >     fruit/vegetable juice,    
# >     newspapers}               
# > 8  {fruit/vegetable juice}    
# > 9  {packaged fruit/vegetables}
# > 10 {chocolate}
# The sample Market Basket
# Each transaction numbered 1-10 listed above represents a basket of items purchased by a shopper.  hese are typically all items that are associated with a particular transaction, or invoice. Each basket is enclosed within braces {}, and is referred to as an itemset. An itemset is a group of items that occur together.
# Market Basket algorithms construct rules in the form of 
# Itemset{x1,x2,x3 ...} --> Itemset{y1,y2,y3.}. 
# 
# This notation states that buyers who have purchased items on the left hand side of the formula (lhs) have a propensity to purchase items on the right hand side (rhs). The association is stated using the ??? symbol which can be interpreted as "implies"
# The lhs of the notation is also known as the antecedent, and the rhs is known as the consequence. If nothing appears on either the left hand side or right hand side there is no specific association rule for those items, however it also means that those items has appeared in the basket.
# Association rule algorithms
# Without an association rule algorithm, you are left with the computationally very expensive task of generating all possible pairs of itemsets, and then trying to prune through the best ones yourself. Associate rule algorithms help with filtering this. 
# The most popular algorithm for MBA is the apriori algorithm which is contained within the arules package. (The other popular algorithm is the eclat algorithm).
# Running apriori is fairly simple. We will demonstrate this using our demo 10 transaction itemset that we just printed.
# The apriori algorithm is based upon the principle that if a particular itemset is frequent, then all of its subsets must also be frequent. That principle it itself is helpful for reducing the number of itemsets which need to be evaluated, since it only needs to look at  the largest items sets first, and then be able to filter down.
# 1.	First, some housekeeping.  Fix the number of printable digits to 2.
options(digits = 2)  

# 2.	Next run the apriori algorithm. However only run it on rows 10 through 19 of the Groceries data set. We want to keep the results very small. Ignore warning messages for now. 
rules <- apriori(Groceries[10:19], parameter = list(supp = 0.1, conf = 0.6))
summary(rules)
# > Apriori
# > 
# > Parameter specification:
# >  confidence minval smax arem  aval originalSupport support minlen maxlen
# >         0.6    0.1    1 none FALSE            TRUE     0.1      1     10
# >  target   ext
# >   rules FALSE
# > 
# > Algorithmic control:
# >  filter tree heap memopt load sort verbose
# >     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
# > 
# > Absolute minimum support count: 1
# > Warning in apriori(Groceries[10:19], parameter = list(supp = 0.1, conf = 0.6)): You chose a very low absolute support count of 1. You might run out of memory! Increase minimum support.
# > set item appearances ...[0 item(s)] done [0.00s].
# > set transactions ...[22 item(s), 10 transaction(s)] done [0.00s].
# > sorting and recoding items ... [22 item(s)] done [0.00s].
# > creating transaction tree ... done [0.00s].
# > checking subsets of size 1 2 3 4 5 6 7 8 9 done [0.00s].
# > writing ... [2351 rule(s)] done [0.00s].
# > creating S4 object  ... done [0.00s].
# 3.	Sort the rules by support, which is one of the important evaluation metrics.
rules <- sort(rules, by = "support", decreasing = TRUE)  # 'high-confidence' rules.

# 4.	Look at the first 5 rules. Observe that it has a support of .2
inspect(head(rules, 5))
# >    lhs                 rhs              support confidence lift
# > 63 {bottled water}  => {tropical fruit} 0.2     1.00        3.3
# > 64 {tropical fruit} => {bottled water}  0.2     0.67        3.3
# > 1  {cereals}        => {whole milk}     0.1     1.00        5.0
# > 2  {chicken}        => {tropical fruit} 0.1     1.00        3.3
# > 3  {soda}           => {rolls/buns}     0.1     1.00       10.0
# Antecedents and Descendants
# The rules shown above are expressed as an implication between the antecedent (left hand side) and the Consequence (right hand side)  
# The first rule above, in bold, describes about customers who buy bottle water as also buying tropical fruit. The 3rd rule says that customers who buy cereals have a tendency to buy whole milk.
# Evaluating the accuracy of a rule
# Three main metrics have been developed which measure the importance, or accuracy of an association rule:  Support, Confidence, and Lift
# Support
# Support measures how frequently the items occur together. Imagine having a shopping cart in which there can be a very large number of combinations of items. Some items which occur rarely could be excluded from the analysis. When an item occurs frequently you will have more confidence in the association among the items, since it will be a more popular item. Often your analysis will be centered around items with high support.
# Calculating Support
# Calculating support is simple. You take the proportion of the number of times that the items in the rule appear in the basket divided by the number of itemsets. 
# .	We can see that for rule number 1, both bottled water and Tropical fruit appear together in 2 of the itemsets, therefore the support for that rule is 2/10 or 20%.
# .	In the above examples, rules number 1 and 2 have the highest support since bottled water appears times out of 10 Tropical fruit 3 times. Bottled water appears two times out of the three time for 2/3
# Confidence
# Confidence is the conditional probability that the event on the right hand side (consequence) will occur, given that the items on the left hand has occurred (antecedent). This is computed by counting the number of occurrences.
# .	For example, if we take a closer look at rule # 64, {tropical fruit} => {bottled water}, we can see that tropical fruit occurs in 3 separate itemsets, itemset 2,3 and 6. Therefore the denominator of the formula is 3. 
# .	Of those 3 itemsets, bottled water occurs in 2 of them (itemsets 2 and 3 only, but NOT 6). So the confidence is 2/3 or 67%.Note that the confidence for the reverse itemset {bottled water} => {tropical fruit} is higher, since every time bottled water is purchased, tropical fruit is purchased as well. You can easily verify that by inspecting and counting the elements by hand.
# Lift
# Lift is determined by dividing the confidence just calculated, by the independent probability of the consequent. In some respects, Lift is a better measure than support or confidence by itself since it incorporates features of both. 
# .	To calculate the lift for rule 64, we only need to determine the unconditional probability of the consequence. Since bottled water appears 2 out of 10 times (20%) as the consequence, we divide .67 by .20 to yield 3.4, which is the lift for rule 64. 
# .	When evaluating the lift metric, use 1 as a baseline lift measure, since a lift of 1 implies no relationship between the antecedent and the consequence.
# Preparing the raw data file for analysis.
# Now that we have had a short introduction to the association rules algorithm, we will illustrate applying association rules to a more meaningful example. 
# We will be using the Online Retail dataset which can be obtained from the UCI Machine Learning Repository at https://archive.ics.uci.edu/ml/datasets/Online+Retail.
# As described by the source, the data is:
# ". A transnational data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail. The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers".
# Reading the Transaction file:
# We will input the data using the read.csv function.
# Set stringsAsFactors to FALSE since we will be manipulating the variables as character strings later.
# The code illustrates the capture.output function. The capture.output function will save the metadata for the raw input file. This is done because we want to track changes done to the input, and we want to capture the contents of the same dataframe at different points in time. That will enable us to save the values of metadata and compare them points.
# We can use the file.show function to directly examine the input file if needed. This is sometimes needed if you find that there are errors in the input. It has been commented out in the code, but you are encouraged to try it out yourself.
# The knitr library will be used mostly for the purposes of display output via html via the kable function.  If you wish, you can replace kable function calls with head or print functions.
library(sqldf)
library(knitr)

setwd("C:/PracticalPredictiveAnalytics/Data")
options(stringsAsFactors = F)

OnlineRetail <- read.csv("Online Retail.csv", strip.white = TRUE)
setwd("C:/PracticalPredictiveAnalytics/Outputs")

# Look at the first few records
head(OnlineRetail)
# >   InvoiceNo StockCode                         Description Quantity
# > 1    536365    85123A  WHITE HANGING HEART T-LIGHT HOLDER        6
# > 2    536365     71053                 WHITE METAL LANTERN        6
# > 3    536365    84406B      CREAM CUPID HEARTS COAT HANGER        8
# > 4    536365    84029G KNITTED UNION FLAG HOT WATER BOTTLE        6
# > 5    536365    84029E      RED WOOLLY HOTTIE WHITE HEART.        6
# > 6    536365     22752        SET 7 BABUSHKA NESTING BOXES        2
# >      InvoiceDate UnitPrice CustomerID        Country
# > 1 12/1/2010 8:26       2.5      17850 United Kingdom
# > 2 12/1/2010 8:26       3.4      17850 United Kingdom
# > 3 12/1/2010 8:26       2.8      17850 United Kingdom
# > 4 12/1/2010 8:26       3.4      17850 United Kingdom
# > 5 12/1/2010 8:26       3.4      17850 United Kingdom
# > 6 12/1/2010 8:26       7.6      17850 United Kingdom
# file.show('C:/Users/randy/Downloads/Online Retail.csv') NOT RUN

# Save it in case we need to look at the metadata later on.

OnlineRetail.Metadata <- capture.output(str(OnlineRetail))

# print it now.  We can see that the capture.output contains the str function, and that there are 541,909 observations


cat(OnlineRetail.Metadata, sep = "\n")
# > 'data.frame': 541909 obs. of  8 variables:
# >  $ InvoiceNo  : chr  "536365" "536365" "536365" "536365" ...
# >  $ StockCode  : chr  "85123A" "71053" "84406B" "84029G" ...
# >  $ Description: chr  "WHITE HANGING HEART T-LIGHT HOLDER" "WHITE METAL LANTERN" "CREAM CUPID HEARTS COAT HANGER" "KNITTED UNION FLAG HOT WATER BOTTLE" ...
# >  $ Quantity   : int  6 6 8 6 6 2 6 6 6 32 ...
# >  $ InvoiceDate: chr  "12/1/2010 8:26" "12/1/2010 8:26" "12/1/2010 8:26" "12/1/2010 8:26" ...
# >  $ UnitPrice  : num  2.55 3.39 2.75 3.39 3.39 7.65 4.25 1.85 1.85 1.69 ...
# >  $ CustomerID : int  17850 17850 17850 17850 17850 17850 17850 17850 17850 13047 ...
# >  $ Country    : chr  "United Kingdom" "United Kingdom" "United Kingdom" "United Kingdom" ...
# change stringsasfactors back to TRUE

options(stringsAsFactors = T)


# Analysing the Input file
# After reading in the file, the nrow function, shows that transaction file containing 541909 rows. We can use our handy View function to peruse the contents. Alternatively, you can use the kable function from the knitr library to display a simple tabular display of the dataframe in the console, as indicated below. 
# .	Note that if you are also using the Rmarkdown package, the output can be formatted to appear as an HTML table in the markdown file. Otherwise it will appear as plain ASCII text.
# .	We can also look at the distribution plots of InvoiceDate, although it will need to be transformed to date format, and sorted first.
# # View(OnlineRetail)
nrow(OnlineRetail)
# > [1] 541909
library(knitr)

InvoiceDate <- gsub(" .*$", "", OnlineRetail$InvoiceDate)
InvoiceDate <- (as.Date(InvoiceDate, format = "%m/%d/%Y"))
InvoiceDate <- sort(InvoiceDate, decreasing = FALSE)

# .	We can see from the head and tail commands, as well as the plots, that the Invoices encompass the period from 12/1/2011 through 12/9/2011. We can also see several spikes in orders around the December holiday season.
#RW This was changed!!
kable(head(as.data.frame(InvoiceDate)))

# 2010-12-01
# 2010-12-01
# 2010-12-01
# 2010-12-01
# 2010-12-01
# 2010-12-01
# 
#RW This was changed!!
#kable(tail(InvoiceDate))
kable(tail(as.data.frame(InvoiceDate)))

# 2011-12-09
# 2011-12-09
# 2011-12-09
# 2011-12-09
# 2011-12-09
# 2011-12-09
# 
# Plotting the dates
par(las = 2)
barplot(table(InvoiceDate), cex.lab = 0.5, cex.main = 0.5, cex.names = 0.5, 
col = c("blue"))
# Insert Image B05033_06_01.png
# Scrubbing and Cleaning the data
# Here comes the cleaning part! Unstructured data such as text usually needs to be scrubbed and cleaned before it is in a form that is suitable for analysis. Fortunately, there are several R functions available which help you do that.
# Removing Unneeded character spaces
# We can start by removing leading and trailing blanks from each of the product description, since they add no value to the analysis and just take up extra space. The trimws is a handy function to accomplish this, since it removes both leading and trailing spaces. The nchar function will count the number of bytes in a character string, so we can run this function on OnlineRetail$Description before and after performing the string trim to see how much space we will actually be saving.
sum(nchar(OnlineRetail$Description))
# > [1] 14284888
OnlineRetail$Description <- trimws(OnlineRetail$Description)
sum(nchar(OnlineRetail$Description))
# > [1] 14283213
# We see that trimws reduced the size of the Description. Had the number increased after using the function, that would be a clue to check your code!
# Simplifying the Descriptions
# Market basket analysis using color choice analysis is an interesting topic in itself. However, for this analysis, we will remove the colors in order to simplify some of the descriptions. We can use the gsub function to remove some of the specific colors which appear as part of the product description.
#CHANGED NEW CODE
#OnlineRetail.save <- OnlineRetail
#OnlineRetail <- OnlineRetail.save
#View(OnlineRetail.save)
gsub_multiple <- function(from, to, x) {
  updated <- x
  for (i in 1:length(from)) {
    updated <- gsub(from[i], to[i], updated) 
  }
  return(updated)
}


OnlineRetail$Description <- gsub_multiple(c("RED","PINK","GREEN","SMALL","MEDIUM","LARGE","JUMBO","STRAWBERRY"), rep("",8), OnlineRetail$Description)
                                          

View(OnlineRetail) 



#RW now not needed?

# OnlineRetail$Description2 <- gsub("RED", "", saveit$Description)
# OnlineRetail$Description2 <- gsub("PINK", "", OnlineRetail$Description2)
# OnlineRetail$Description2 <- gsub("GREEN", "", OnlineRetail$Description2)
# OnlineRetail$Description2 <- gsub("SMALL", "", OnlineRetail$Description2)
# OnlineRetail$Description2 <- gsub("MEDIUM", "", OnlineRetail$Description2)
# OnlineRetail$Description2 <- gsub("LARGE", "", OnlineRetail$Description2)
# OnlineRetail$Description2 <- gsub("JUMBO", "", OnlineRetail$Description2)
# OnlineRetail$Description2 <- gsub("PINK", "", OnlineRetail$Description2)
# OnlineRetail$Description2 <- gsub("STRAWBERRY", "", OnlineRetail$Description2)
# OnlineRetail$changed <- ifelse(OnlineRetail$Description==OnlineRetail$Description2,"1","0")
# all.equal(OnlineRetail$Description,OnlineRetail$Description2)
# View(OnlineRetail[87500:875021,])
View(OnlineRetail)
# Removing colors automatically
# If we want to remove colors automatically, we can also do that as well. The colors() function returns a list of colors which are used in the current palette. We can then perform a little code manipulation in conjunction with the gsub function that we just used, to replace all of the specified colors from OnlineRetail$Description with blanks
# We will also use the kable function, which is contained within the knitr package in order to produce simple html tables of the results.
# compute the length of the field before changes
before <- sum(nchar(OnlineRetail$Description))
# get the unique colors returned from the colors function, and remove any
# digits found at the end of the string

# get the unique colors
col2 <- unique(gsub("[0-9]+", "", colors(TRUE)))

# Filter out any colors with a length > 7. This is just done to reduce the
# #number of colors to the 'popular' ones. We may miss a couple, but we can
# #filter out later.

for (i in 1:length(col2)) {
col2[i] <- ifelse(nchar(col2[i]) > 7, "", col2[i])
}

col2 <- unique(col2)


cat("Unique Colors\n")
# > Unique Colors
#RW Changed
kable(head(data.frame(col2), 10))

# white
# azure beige bisque black blue brown coral cyan
# Cleaning up the colors
# Clean up the colors a little more by capitalizing all of the colors and inserting a delimiter, and then pass the result to gsub
#RW changed
col <- toupper(paste0(col2, collapse = "|"))
cat("Pass to gsub\n", head(col, 9))
# > Pass to gsub
# >  WHITE||AZURE|BEIGE|BISQUE|BLACK|BLUE|BROWN|CORAL|CYAN|DARKRED|DIMGRAY|GOLD|GRAY|GREEN|HOTPINK|IVORY|KHAKI|LINEN|MAGENTA|MAROON|NAVY|OLDLACE|ORANGE|ORCHID|PERU|PINK|PLUM|PURPLE|RED|SALMON|SIENNA|SKYBLUE|SNOW|TAN|THISTLE|TOMATO|VIOLET|WHEAT|YELLOW
# 
# To replace the colors in the dataframe with blanks: 
# 
OnlineRetail$Description <- gsub(col, "", OnlineRetail$Description)

# Check the length to see how much was removed. As before, print the character count before and after, to insure that the Description is reduced in size.
after <- sum(nchar(OnlineRetail$Description))
print(before)
# > [1] 13682222
print(after)
# > [1] 13341097
# Verify that there are no more colors by inspection. We will look at the first 5, although you will probably want to look at more, all from different parts of the data set. We will leave "Cream" in for now, but we would remove that as well if we felt it would not help in the analysis.
#RW changed
kable(data.frame(OnlineRetail$Description[1:5]))
# HANGING HEART T-LIGHT HOLDER
# METAL LANTERN
# CREAM CUPID HEARTS COAT HANGER
# KNITTED UNION FLAG HOT WATER BOTTLE
# WOOLLY HOTTIE HEART.
# Filtering out single item transactions
# Since we will want to have a 'basket' of items to perform some association rules on, we will want to filter out the transactions that only have 1 item per invoice. (That might be useful for a separate analysis of customer who only purchased one item).
# .	Let's use sqldf to first all of the single item transactions, and then we will create a separate dataframe consisting of the number of items per customer invoice.

library(sqldf)

#.	Construct a query: How many distinct invoices were there?
# 
# sqldf("select count(distinct InvoiceNo) from OnlineRetail")
# # > Loading required package: tcltk
# # >   count(distinct InvoiceNo)
# # > 1                     25900
# # 
# # .	How many invoices contain only single transactions?

single.trans <- sqldf("select InvoiceNo, count(*) as itemcount from OnlineRetail group by InvoiceNo having count(*)==1")

# .	Add them up. This shows us that there are not a lot of single transaction items.

sum(single.trans$itemcount)
# > [1] 5841
# .	SQL Query: How many have multiple transactions?

x2 <- sqldf("select InvoiceNo, count(*) as itemcount from OnlineRetail group by InvoiceNo having count(*) > 1")

sum(x2$itemcount)
# > [1] 536068
# 
# .	Show a tabulation of the number of items per invoice to verify that they all have at least 2 items.

kable(head(x2))
# 
# 
# 
# 536365	7
# 536366	2
# 536367	12
# 536368	4
# 536370	20
# 536372	2
# InvoiceNo	itemcount
# 536365	7
# 536366	2
# 536367	12
# 536368	4
# 536370	20
# 536372	2
# 
# Looking at the distributions
# Now we can take a look at the distribution of the number of items. We can see that there is an average of 27.94 items. This will be a large enough assortment of items to do a meaningful analysis.
mean(x2$itemcount)
# > [1] 27
# 
# We can also plot a histogram. The histogram shows a definite spike at a lower item number that we know is not equal to 1 which we have filtered out. We can see what that count is by using the min() function
# 
hist(x2$itemcount, breaks = 500, xlim = c(0, 50))

# 
# 
# Insert Image: B05033_06_02.extension
# 
# 
min(x2$itemcount)
# > [1] 2
# Merging the results back into the original data
# We will want to hold on to the number of total items for each invoice on the original data frame. Merge the number of items contained in each invoice back to the original transactions, with the merge function, using Invoicenum as the key. 
# .	If you count the number of distinct invoices before and after the merge, you can see that the invoice count is lower than prior to the merge.
nrow(OnlineRetail)
# > [1] 541909
sqldf("select count(distinct InvoiceNo) from OnlineRetail")
# >   count(distinct InvoiceNo)
# > 1                     25900
tmp <- merge(OnlineRetail, x2, by = "InvoiceNo")
nrow(tmp)
# > [1] 536068
sqldf("select count(distinct InvoiceNo) from tmp")
# >   count(distinct InvoiceNo)
# > 1                     20059
# # we can see that we filtered out some members
# 
OnlineRetail <- merge(OnlineRetail, x2, by = "InvoiceNo")
# 
# .	Print the OnlineRetail Table along with the merged itemcount
# 
kable(OnlineRetail[1:5, ], padding = 0)
# 
# InvoiceNo
# StockCode	Description	Quantity	InvoiceDate	UnitPrice	CustomerID	Country	itemcount
# 536365	84406B	CREAM CUPID HEARTS COAT HANGER	8	12/1/2010 8:26	2.8	17850	United kingdom	7
# 536365	22752	SET 7 BABUSHKA NESTING BOXES	2	12/1/2010 8:26	7.6	17850	United kingdom	7
# 536365	85123A	HANGING HEART T-LIGHT HOLDER	6	12/1/2010 8:26	2.5	17850	United kingdom	7
# 536365	84029E	WOOLLY HOTTIE HEART.	6	12/1/2010 8:26	3.4	17850	United kingdom	7
# 536365	71053	METAL LANTERN	6	12/1/2010 8:26	3.4	17850	United kingdom	7
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
# 84406B	
# 8	
# 2.8	17850	United Kingdom	7
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
# Compressing the descriptions using CamelCase
# For long descriptions, sometimes it is beneficial to compress the descriptions into CamelCase to improve readability. This is especially valuable when viewing descriptions which are labels on x or y axes. 
# CamelCase is a method which some programmers use for writing compound words where spaces are first removed, and then each word begins with a capital letter. It is also a way of conserving space. 
# To accomplish this, we can write a function called .simpleCap which performs this function. To illustrate how it works, we will pass it a two element character vector c("A certain good book","A very easy book"), and observe the results.
# Custom function to map to camelcase
# This is a simple example use of this function which maps the 2 character vector c("A certain good book", "A very easy book") to CamelCase. This vector is mapped to 2 new elements:
#   [1] "ACertainGoodBook", and  [2] "AVeryEasyBook"

# change descriptions to camelcase maybe append to itemnumber for uniqueness
.simpleCap <- function(x) {
  # s <- strsplit(x, ' ')[[1]]
  s <- strsplit(tolower(x), " ")[[1]]
  
  aa <- paste(toupper(substring(s, 1, 1)), substring(s, 2), sep = "", collapse = " ")
  gsub(" ", "", aa, fixed = TRUE)
  
}

a <- c("A certain good book", "A very easy book")
a4 <- gsub(" ", "", .simpleCap(a), fixed = TRUE)
a4
# > [1] "ACertainGoodBook"
lapply(a, .simpleCap)
# > [[1]]
# > [1] "ACertainGoodBook"
# > 
#   > [[2]]
# > [1] "AVeryEasyBook"
# 
# Let's use the .simpleCap function to create a new version of Description from our OnlineRetail dataset, and call it Desc2, which removes the blanks, and capitalizes the first letter of each word. 
OnlineRetail$Desc2 <- lapply(as.character(OnlineRetail$Description), .simpleCap)

kable(OnlineRetail[1:5, c(3, 10)], padding = 0)
# Description	Desc2
# CREAM CUPID HEARTS COAT HANGER	CreamCupidHeartsCoatHanger
# SET 7 BABUSHKA NESTING BOXES	Set7BabushkaNestingBoxes
# HANGING HEART T-LIGHT HOLDER	HangingHeartT-lightHolder
# WOOLLY HOTTIE HEART.	WoollyHottieHeart.
# METAL LANTERN	MetalLantern
# Extracting the 'last word'
# Often the first and last word of product descriptions contain useful information, and sometimes you can use a single word or phrase in place of the original longer description. This may not always be the case, but it is worth trying. In order to extract the last word from the descriptions, we can use the word function from the stringr package. 
library(stringr)
OnlineRetail$lastword <- word(OnlineRetail$Description, -1)  #supply -1 to extract the last word
OnlineRetail$Description <- trimws(OnlineRetail$Description, "l")
OnlineRetail$firstword <- word(OnlineRetail$Description, 1)
# use head(OnlineRetail) if you are no using Rmarkdown

kable(OnlineRetail[1:5, c(3, 10:12)], padding = 0)





# CREAM CUPID HEARTS COAT HANGER
# CreamCupidHeartsCoatHanger	HANGER	CREAM
# SET 7 BABUSHKA NESTING BOXES	Set7BabushkaNestingBoxes	BOXES	SET
# HANGING HEART T-LIGHT HOLDER	HangingHeartT-lightHolder	HOLDER	HANGING
# WOOLLY HOTTIE HEART.	WoollyHottieHeart.	HEART.	WOOLLY
# METAL LANTERN	MetalLantern	LANTERN	METAL
# 
# 
# 
# 
# Description	Desc2	lastword	firstword
# CREAM CUPID HEARTS COAT HANGER	CreamCupidHeartsCoatHanger
# HANGER	CREAM
# SET 7 BABUSHKA NESTING BOXES	Set7BabushkaNestingBoxes	BOXES	SET
# HANGING HEART T-LIGHT HOLDER	HangingHeartT-lightHolder	HOLDER	HANGING
# WOOLLY HOTTIE HEART.	WoollyHottieHeart.	HEART.	WOOLLY
# METAL LANTERN	MetalLantern	LANTERN	METAL
# 
# In order to see if this 'lastword' mapping makes any sense, we will sort the results so that we can see the most frequently occurring ending words. We could ultimately use this information to create category subproducts, such as CASES, BAGS, SIGNS etc.
kable(head(as.data.frame(sort(table(OnlineRetail$lastword[]), decreasing = TRUE)), 
10))

sort(table(OnlineRetail$lastword[]), decreasing = TRUE)
# 36640
# DESIGN	25557
# HOLDER	13528
# RETROSPOT	13013
# BOX	12939
# SIGN	12210
# CASES	10888
# BAG	9723
# SET	9056
# CHRISTMAS	7868
# 
# 
nrow(OnlineRetail)
# > [1] 536068
# The lastword description looks useable, so we will keep it as part of the analytics dataset.
# Creating the Test and Training Datasets
# Now that we are finished with our transformations, we will create the training and test data frames. We will perform a 50/50 split between training and test.
# # Take a sample of full vector
# 
nrow(OnlineRetail)
# > [1] 536068
pctx <- round(0.5 * nrow(OnlineRetail))
set.seed(1)

# randomize rows

df <- OnlineRetail[sample(nrow(OnlineRetail)), ]
rows <- nrow(df)
OnlineRetail <- df[1:pctx, ]  #training set
OnlineRetail.test <- df[(pctx + 1):rows, ]  #test set
rm(df)


# Display the number of rows in the training and test datasets.

nrow(OnlineRetail)
# > [1] 268034
nrow(OnlineRetail.test)
# > [1] 268034
# Saving the results
# It is a good idea to periodically save your data frames, so that you can pick up your analysis from various checkpoints. 
# In this example I will first sort them both by InvoiceNo, and then save the test and train data sets to disk, where I can always load them back into memory as needed.
#RW changed

OnlineRetail <- OnlineRetail[order(OnlineRetail$InvoiceNo), ]
OnlineRetail.test <- OnlineRetail.test[order(OnlineRetail.test$InvoiceNo), ]
# 
# # save(OnlineRetail,file='OnlineRetail.full.Rda')
# # save(OnlineRetail.test,file='OnlineRetail.test.Rda')
# 
# # load('OnlineRetail.full.Rda') load('OnlineRetail.test.Rda')
# 
# nrow(OnlineRetail)
# > [1] 268034
nrow(OnlineRetail.test)
# > [1] 268034
nrow(OnlineRetail)
# > [1] 268034

# At this point we have prepared our analytics data sets and are ready to move on to the actual analysis.
# If you wish, you can save the entire workspace to disk as follows:
save.image(file = "ch6 part 1.Rdata")
# Loading the Analytics file
# If you are still in a session in which OnlineRetail is still in memory, you are OK! However, if you are picking up where we left off, you will need to load the data that we saved in the last session. Start by setting the working directory and then loading the OnlineRetail training dataset.
#RW temporarily disabling loads and saves and rm's
#rm(list = ls())
#setwd("C:/PracticalPredictiveAnalytics/Outputs")
#load("ch6 part 1.Rdata")
# works for small data OnlineRetail <- OnlineRetail[1:10000,]
cat(nrow(OnlineRetail), "rows loaded\n")
# > 268034 rows loaded
# The cat function in the previous step should reflect the number of rows in the training data set which is 268034
# Determining the Consequent Rules
# We have seen in the data prep stage that there are a large number of itemsets generated for each invoice. To begin to demonstrate the algorithm, we will extract one representative word from each product description, and use that word as the Consequent (or rhs) to build some association rules. We have already saved the first and last words from each product description. We would examine those words more closely and see if we can filter them to result in a manageable set of transactions.
# Let's first preview the frequency of the first and last word of the descriptions in descending order. That should give us a clue as to what the popular products are.
library(arules)
# > Loading required package: Matrix
# > 
#   > Attaching package: 'arules'
# > The following objects are masked from 'package:base':
#   > 
#   >     abbreviate, write
library(arulesViz)
# > Loading required package: grid
# Print the popular "first words" of the description. We will do that by sorting the frequency of "first word" in descending order:
#   
  kable(head(as.data.frame(sort(table(OnlineRetail$firstword[]), decreasing = TRUE)), 10))
sort(table(OnlineRetail$firstword[]), decreasing = TRUE)
# SET	17381
# BAG	8720
# LUNCH	7692
# RETROSPOT	7155
# PACK	6861
# VINTAGE	6204
# HEART	4799
# HANGING	4457
# DOORMAT	4175
# REGENCY	3452
# 
# Similarly, print the popular "last words" of the description

kable(head(as.data.frame(sort(table(OnlineRetail$lastword[]), decreasing = TRUE)), 
           10))
sort(table(OnlineRetail$lastword[]), decreasing = TRUE)
# 18376
# DESIGN	12713
# HOLDER	6792
# BOX	6528
# RETROSPOT	6517
# SIGN	6184
# CASES	5465
# BAG	4826
# SET	4418
# CHRISTMAS	3963
# Looking at the popular terms above show that many transactions concern the purchases of Boxes, Cases, Signs, Bags, etc.
# Replacing Missing Values
# For lastword, we see that there are some blank values, so we will replace any blank values with any value found in firstword. 

# replace blank values in lastword, with first word.

OnlineRetail$lastword <- ifelse(OnlineRetail$lastword == "", OnlineRetail$firstword, 
                                OnlineRetail$lastword)


# After we are done with this, we will take another look at the frequencies and observe that the blank values have disappeared.

head(as.data.frame(sort(table(OnlineRetail$lastword[]), decreasing = TRUE)), 
     10)
sort(table(OnlineRetail$lastword[]), decreasing = TRUE)
# > DESIGN                                                      12713
# > HOLDER                                                       6792
# > RETROSPOT                                                    6574
# > BOX                                                          6528
# > SIGN                                                         6184
# > BAG                                                          5761
# > CASES                                                        5465
# > SET                                                          4418
# > HEART                                                        4027
# > CHRISTMAS                                                    4005
# Making the final subset
# Based upon these frequencies, we will filter the data to only include a subset of the top categories. We will exclude some of the terms which do not apply to the physical product, such as "DESIGN", "SET", and any associated colors.
# Testing OnlineRetail2 <- OnlineRetail
OnlineRetail2 <- subset(OnlineRetail, lastword %in% c("BAG", "CASES", "HOLDER", 
                                                      "BOX", "SIGN", "CHRISTMAS", "BOTTLE", "BUNTING", "MUG", "BOWL", "CANDLES", 
                                                      "COVER", "HEART", "MUG", "BOWL"))

# Run the table function again on the results to see the new frequencies.

head(as.data.frame(sort(table(OnlineRetail2$lastword[]), decreasing = TRUE)), 
     10)
           sort(table(OnlineRetail2$lastword[]), decreasing = TRUE)
# > HOLDER                                                        6792
# > BOX                                                           6528
# > SIGN                                                          6184
# > BAG                                                           5761
# > CASES                                                         5465
# > HEART                                                         4027
# > CHRISTMAS                                                     4005
# > BOTTLE                                                        3795
# > BUNTING                                                       3066
# > MUG                                                           2900
# 
# Use the nrow function to see how much of the data was filtered from the original.

cat(nrow(OnlineRetail), "Original before subsetting\n")
# > 268034 Original before subsetting
cat(nrow(OnlineRetail2), "After Subsetting\n")
# > 55609 After Subsetting
# Creating the Market Basket Transaction file
# We are almost there! There is extra step that we need to do in order to prepare our data for market basket analysis.
# The association rules package requires that the data be in transaction format. Transactions can either be specified in two different formats:
#   1.	One transaction per itemset with an identifier. This shows the entire basket in one line, just as we saw with the Groceries data.
# 2.	One single item per line with an identifier.
# Additionally, you can create the actual transaction file in two different ways, by either:
#   1.	Physically writing a transactions file
# 2.	Coercing a dataframe to transaction format. 
# For smaller amounts of data, coercing the dataframe to a transaction file is simpler, but for large transaction files, writing the transaction file first is preferable, since append files can be fed from large operational transaction systems . We will illustrate both ways.
# Method 1 - Coercing a dataframe to a transaction file.
# Now we are ready to coerce the data frame. We will create a temporary data frame containing just the transaction id (InvoiceNo), and the descriptor (lastword). 
# First we will verify the column names and numbers for these two variables. We can see that they correspond to columns 1, and 12 of the dataframe by first running a colnames function on OnlineRetail2. 
colnames(OnlineRetail2)
# >  [1] "InvoiceNo"   "StockCode"   "Description" "Quantity"    "InvoiceDate"
# >  [6] "UnitPrice"   "CustomerID"  "Country"     "itemcount"   "Desc2"      
# > [11] "lastword"    "firstword"
# 
# As a double check, display the first 25 rows, specifying the indices found above.
kable(head(OnlineRetail2[, c(1, 11)], 5))
# InvoiceNo	lastword
# 6	536365	HOLDER
# 45	536370	BOX
# 39	536370	BOX
# 57	536373	HOLDER
# 59	536373	BOTTLE
# Next we will create a temporary data frame from just these two columns, give them names, and eliminate duplicates.
# 
# First, create the dataframe with only two columns named TransactionID, and Items.
tmp <- data.frame(OnlineRetail2[, 1], OnlineRetail2[, 11])
names(tmp)[1] <- "TransactionID"
names(tmp)[2] <- "Items"

tmp <- unique(tmp)
nrow(tmp)
# > [1] 33182
# Verify the results
kable(head(tmp))
# TransactionID	Items
# 1	536365	HOLDER
# 2	536370	BOX
# 4	536373	HOLDER
# 5	536373	BOTTLE
# 7	536373	MUG
# 9	536375	HOLDER
# We will now use the split function to group the descriptions (lastword which is column 2), by InvoiceID (column 1). The "as" function is the critical keyword, as it converts the results of the split to transaction form.

trans4 <- as(split(tmp[, 2], tmp[, 1]), "transactions")
# Inspecting the transaction file
# Once the data has been coerced to transaction form, we can use the inspect function to examine the data. Note: when inspecting transaction files, you do not use normal print, or head functions directly since the objects are in sparse format. You use an "inspect" function instead.
# If you happen to have the tm package loaded (which we will use later), you MUST preface inspect with alrules::inspect, since there is also an inspect function in the tm package which serves a different purpose.
# If you run an inspect command on the first 5 records, you can see that the data is in 'basket' format, i.e each invoice shows the itemsets, delimited by {},  that are associated with each invoice.
arules::inspect(trans4[1:5])
# >   items               transactionID
# > 1 {HOLDER}            536365       
# > 2 {BOX}               536370       
# > 3 {BOTTLE,HOLDER,MUG} 536373       
# > 4 {BOTTLE,HOLDER}     536375       
# > 5 {HOLDER}            536376
# Another way of displaying transactions, other than using inspect,  is to first coerce it to a matrix and then display the items as boolean values. If you have many items you will need to subset the column vectors so that they fit on the screen.
as(trans4, "matrix")[1:5, 1:5]
# >          BAG BOTTLE  BOWL   BOX BUNTING
# > 536365 FALSE  FALSE FALSE FALSE   FALSE
# > 536370 FALSE  FALSE FALSE  TRUE   FALSE
# > 536373 FALSE   TRUE FALSE FALSE   FALSE
# > 536375 FALSE   TRUE FALSE FALSE   FALSE
# > 536376 FALSE  FALSE FALSE FALSE   FALSE
as(trans4, "matrix")[1:5, 6:ncol(trans4)]
# >        CANDLES CASES CHRISTMAS COVER HEART HOLDER   MUG  SIGN
# > 536365   FALSE FALSE     FALSE FALSE FALSE   TRUE FALSE FALSE
# > 536370   FALSE FALSE     FALSE FALSE FALSE  FALSE FALSE FALSE
# > 536373   FALSE FALSE     FALSE FALSE FALSE   TRUE  TRUE FALSE
# > 536375   FALSE FALSE     FALSE FALSE FALSE   TRUE FALSE FALSE
# > 536376   FALSE FALSE     FALSE FALSE FALSE   TRUE FALSE FALSE
# Obtaining the topN purchased items
# Even before we run any association rules we can obtain counts of the topN items, as shown in the first plot.
# If we are looking for items with a specified support level, we can include that as a parameter to the function as well.
# The second plot below is another way of plotting the items, which specifies support as a filter, and it indicates higher support for "Bags","Boxes","Cases", and "Holders"
par(mfrow = c(1, 2), bg = "white", col = c("blue"))

itemFrequencyPlot(trans4, topN = 10, type = "absolute", cex.names = 0.7)
itemFrequencyPlot(trans4, support = 0.2, cex.names = 0.75)

# Insert Image: B05033_06_03.extension
# 
# 
# Reset the graphics parameters
dev.off()
# > null device 
# >           1
# Finding the association rules
# As shown earlier, the association rules are run using the apriori function. The apriori function has several filtering parameters which are used to control the number of rules which are produced. In our example we will specify the minimum support and confidence threshold that a rule needs to pass in order to be considered. 
# The number that you pass to aprior depends upon how you want to look at the rules.  It can be an initial screening, or it can be a 'deeper dive', after you have performed several passes. But generally, If we want many rules we can decrease the support and confidence parameters. If we want to focus on items which appear frequently we raise the support threshold. If we want to concentrate on higher quality and more 'accurate' rules, we would raise the confidence level.
# These numbers are not absolutes. They are numbers that you can tweak in order to limit the number of rules that you will look at, versus their quality.
# The minlen=2 parameter is often specified in order to guarantee that there are itemsets included in the left hand side of the rule.
rulesx <- apriori(trans4, parameter = list(minlen = 2, support = 0.02, confidence = 0.01))
# > Apriori
# > 
#   > Parameter specification:
#   >  confidence minval smax arem  aval originalSupport support minlen maxlen
# >        0.01    0.1    1 none FALSE            TRUE    0.02      2     10
# >  target   ext
# >   rules FALSE
# > 
#   > Algorithmic control:
#   >  filter tree heap memopt load sort verbose
# >     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
# > 
#   > Absolute minimum support count: 272 
# > 
#   > set item appearances ...[0 item(s)] done [0.00s].
# > set transactions ...[13 item(s), 13617 transaction(s)] done [0.00s].
# > sorting and recoding items ... [13 item(s)] done [0.00s].
# > creating transaction tree ... done [0.00s].
# > checking subsets of size 1 2 3 4 5 done [0.00s].
# > writing ... [829 rule(s)] done [0.00s].
# > creating S4 object  ... done [0.00s].
# The output from the apriori algorithm will tell us how many rules were generated. If you also perform a str function on rulesx, that will show you all of the sublists that are contained within the rulesx object, which can get complex.  Ordinarily the output is sufficient for analyzing the rules, but these sublists can be used programmatically to print the number of rules generated if you vary the paramaters in a loop. For our example, printing the second column of one of the sublists (rulesx@lhs@data@Dim[2]) shows that here have been 829 rules generated. This is a manageable number of rules to look at.
str(rulesx)
# > Formal class 'rules' [package "arules"] with 4 slots
# >   ..@ lhs    :Formal class 'itemMatrix' [package "arules"] with 3 slots
# >   .. .. ..@ data       :Formal class 'ngCMatrix' [package "Matrix"] with 5 slots
# >   .. .. .. .. ..@ i       : int [1:1752] 8 5 8 7 8 11 8 2 8 4 ...
# >   .. .. .. .. ..@ p       : int [1:830] 0 1 2 3 4 5 6 7 8 9 ...
# >   .. .. .. .. ..@ Dim     : int [1:2] 13 829
# >   .. .. .. .. ..@ Dimnames:List of 2
# >   .. .. .. .. .. ..$ : NULL
# >   .. .. .. .. .. ..$ : NULL
# >   .. .. .. .. ..@ factors : list()
# >   .. .. ..@ itemInfo   :'data.frame': 13 obs. of  1 variable:
#   >   .. .. .. ..$ labels: chr [1:13] "BAG" "BOTTLE" "BOWL" "BOX" ...
# >   .. .. ..@ itemsetInfo:'data.frame': 0 obs. of  0 variables
# >   ..@ rhs    :Formal class 'itemMatrix' [package "arules"] with 3 slots
# >   .. .. ..@ data       :Formal class 'ngCMatrix' [package "Matrix"] with 5 slots
# >   .. .. .. .. ..@ i       : int [1:829] 5 8 7 8 11 8 2 8 4 8 ...
# >   .. .. .. .. ..@ p       : int [1:830] 0 1 2 3 4 5 6 7 8 9 ...
# >   .. .. .. .. ..@ Dim     : int [1:2] 13 829
# >   .. .. .. .. ..@ Dimnames:List of 2
# >   .. .. .. .. .. ..$ : NULL
# >   .. .. .. .. .. ..$ : NULL
# >   .. .. .. .. ..@ factors : list()
# >   .. .. ..@ itemInfo   :'data.frame': 13 obs. of  1 variable:
#   >   .. .. .. ..$ labels: chr [1:13] "BAG" "BOTTLE" "BOWL" "BOX" ...
# >   .. .. ..@ itemsetInfo:'data.frame': 0 obs. of  0 variables
# >   ..@ quality:'data.frame':   829 obs. of  3 variables:
#   >   .. ..$ support   : num [1:829] 0.0239 0.0239 0.0206 0.0206 0.0245 ...
# >   .. ..$ confidence: num [1:829] 0.278 0.21 0.24 0.129 0.285 ...
# >   .. ..$ lift      : num [1:829] 2.43 2.43 1.5 1.5 2.03 ...
# >   ..@ info   :List of 4
# >   .. ..$ data         : symbol trans4
# >   .. ..$ ntransactions: int 13617
# >   .. ..$ support      : num 0.02
# >   .. ..$ confidence   : num 0.01
rulesx@lhs@data@Dim[2]
# > [1] 829
# Examining the rules summary
# The rule length distribution indicates the number of itemsets which appear in both the left and right side of the association. The most frequent number of item is 3, which either means that the purchase of 2 items together, implies purchasing a single item, or conversely, purchasing a single item implies purchasing two additional item.
# Examining the rules quality and observe the highest support
# The quality measures tell you something about the distribution of support, confidence, and lift. The quality function will give the support, list, and confidence for each of the rules. You can also sort the rules by each of these important measures and observe which rules have the highest measures.
# We can see from the low support distribution that there are no particular itemsets which occur more than others. If you inspect the rules sorted by the support level, you will see the highest support level at .046 Notice that this agrees with the Max. support level given in the summary. The top 3 support levels are for those customers who purchase Holders, Boxes, or signs.
summary(rulesx)
# > set of 829 rules
# > 
#   > rule length distribution (lhs + rhs):sizes
# >   2   3   4   5 
# > 156 438 220  15 
# > 
#   >    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# >   2.000   3.000   3.000   3.113   4.000   5.000 
# > 
#   > summary of quality measures:
#   >     support          confidence          lift      
# >  Min.   :0.02005   Min.   :0.1293   Min.   :1.000  
# >  1st Qu.:0.02210   1st Qu.:0.3672   1st Qu.:1.948  
# >  Median :0.02512   Median :0.5110   Median :2.393  
# >  Mean   :0.02987   Mean   :0.5068   Mean   :2.444  
# >  3rd Qu.:0.03202   3rd Qu.:0.6533   3rd Qu.:2.899  
# >  Max.   :0.09885   Max.   :0.8571   Max.   :5.419  
# > 
#   > mining info:
#   >    data ntransactions support confidence
# >  trans4         13617    0.02       0.01
head(quality(rulesx))  #also look at the quality measures for each of the rules
# >      support confidence     lift
# > 1 0.02394066  0.2779199 2.432156
# > 2 0.02394066  0.2095116 2.432156
# > 3 0.02063597  0.2395567 1.500480
# > 4 0.02063597  0.1292548 1.500480
# > 5 0.02452816  0.2847400 2.026819
# > 6 0.02452816  0.1745949 2.026819
tmp <- as.data.frame(inspect(head(sort(rulesx, by = "support"), 10)))
# >     lhs         rhs      support    confidence lift    
# > 155 {BOX}    => {HOLDER} 0.09884703 0.3417111  1.063075
# > 156 {HOLDER} => {BOX}    0.09884703 0.3075166  1.063075
# > 135 {HEART}  => {HOLDER} 0.09620328 0.4768839  1.483602
# > 136 {HOLDER} => {HEART}  0.09620328 0.2992918  1.483602
# > 151 {BAG}    => {BOX}    0.09304546 0.3859275  1.334139
# > 152 {BOX}    => {BAG}    0.09304546 0.3216552  1.334139
# > 149 {SIGN}   => {HOLDER} 0.09069545 0.4203540  1.307736
# > 150 {HOLDER} => {SIGN}   0.09069545 0.2821567  1.307736
# > 141 {CASES}  => {BOX}    0.08511420 0.4048201  1.399451
# > 142 {BOX}    => {CASES}  0.08511420 0.2942371  1.399451
# Confidence and Lift measures.
# Similar to above, sort the rules and examine the highest confidence and lift measures.
tmp <- as.data.frame(arules::inspect(head(sort(rulesx, by = "confidence"), 10)))
# >     lhs                       rhs      support    confidence lift    
# > 815 {BAG,BOWL,BOX,SIGN}    => {HOLDER} 0.02070941 0.8571429  2.666601
# > 631 {BAG,BOTTLE,BOWL}      => {BOX}    0.02181097 0.8510029  2.941890
# > 643 {BOWL,HEART,SIGN}      => {HOLDER} 0.02151722 0.8492754  2.642125
# > 820 {BAG,BOX,HEART,SIGN}   => {HOLDER} 0.02137035 0.8434783  2.624090
# > 632 {BOTTLE,BOWL,BOX}      => {BAG}    0.02181097 0.8413598  3.489734
# > 816 {BAG,BOWL,HOLDER,SIGN} => {BOX}    0.02070941 0.8392857  2.901385
# > 817 {BOWL,BOX,HOLDER,SIGN} => {BAG}    0.02070941 0.8392857  3.481131
# > 707 {BOTTLE,HEART,SIGN}    => {HOLDER} 0.02144378 0.8366762  2.602929
# > 651 {BAG,BOWL,HEART}       => {HOLDER} 0.02115003 0.8347826  2.597038
# > 719 {BOTTLE,CASES,SIGN}    => {BAG}    0.02063597 0.8289086  3.438089
tmp <- as.data.frame(arules::inspect(head(sort(rulesx, by = "lift"), 10)))
# >     lhs                      rhs     support    confidence lift    
# > 602 {BAG,HOLDER,SIGN}     => {COVER} 0.02012191 0.4667802  5.418710
# > 598 {BAG,BOX,SIGN}        => {COVER} 0.02019534 0.4661017  5.410833
# > 819 {BAG,BOX,HOLDER,SIGN} => {BOWL}  0.02070941 0.6698337  5.254105
# > 610 {BAG,BOX,HOLDER}      => {COVER} 0.02070941 0.4483307  5.204534
# > 606 {BOX,HOLDER,SIGN}     => {COVER} 0.02004847 0.4333333  5.030435
# > 634 {BAG,BOTTLE,BOX}      => {BOWL}  0.02181097 0.6279070  4.925236
# > 638 {BAG,HEART,SIGN}      => {BOWL}  0.02034222 0.6141907  4.817647
# > 662 {BAG,CASES,SIGN}      => {BOWL}  0.02144378 0.6134454  4.811801
# > 159 {BAG,BOWL}            => {COVER} 0.02092972 0.4025424  4.672992
# > 670 {CASES,HOLDER,SIGN}   => {BOWL}  0.02078284 0.5811088  4.558156
# Filtering a large number of rules
# Once we have the rules built, we can use special subsetting functions to filter items from itemsets on either the left(lhs) or right(rhs) side of the association rule. This is valuable if you are looking for particular items within the itemsets.
# Use the %in% operator to perform an exact match, or %pin% to perform a partial match.
# # to see what 'Christmas' purchases imply.

lhs.rules <- subset(rulesx, subset = lhs %pin% "CHRISTMAS")
lhs.rules
# > set of 44 rules
inspect(lhs.rules)
# >     lhs                   rhs       support    confidence lift    
# > 4   {CHRISTMAS}        => {COVER}   0.02063597 0.1292548  1.500480
# > 26  {CHRISTMAS}        => {CANDLES} 0.02702504 0.1692732  1.481358
# > 47  {CHRISTMAS}        => {MUG}     0.02379379 0.1490340  1.060845
# > 49  {CHRISTMAS}        => {BOWL}    0.02680473 0.1678933  1.316937
# > 51  {CHRISTMAS}        => {BUNTING} 0.03018286 0.1890524  1.108191
# > 53  {CHRISTMAS}        => {BOTTLE}  0.04553132 0.2851886  1.797876
# > 55  {CHRISTMAS}        => {HEART}   0.03708600 0.2322907  1.151475
# > 57  {CHRISTMAS}        => {CASES}   0.04751414 0.2976081  1.415484
# > 59  {CHRISTMAS}        => {SIGN}    0.03547037 0.2221711  1.029715
# > 61  {CHRISTMAS}        => {BAG}     0.04663289 0.2920883  1.211504
# > 63  {CHRISTMAS}        => {BOX}     0.05500477 0.3445262  1.191016
# > 65  {CHRISTMAS}        => {HOLDER}  0.05133289 0.3215271  1.000282
# > 253 {BOTTLE,CHRISTMAS} => {CASES}   0.02210472 0.4854839  2.309058
# > 254 {CASES,CHRISTMAS}  => {BOTTLE}  0.02210472 0.4652241  2.932850
# > 256 {BOTTLE,CHRISTMAS} => {BAG}     0.02283910 0.5016129  2.080555
# > 257 {BAG,CHRISTMAS}    => {BOTTLE}  0.02283910 0.4897638  3.087552
# > 259 {BOTTLE,CHRISTMAS} => {BOX}     0.02489535 0.5467742  1.890181
# > 260 {BOX,CHRISTMAS}    => {BOTTLE}  0.02489535 0.4526035  2.853288
# > 262 {BOTTLE,CHRISTMAS} => {HOLDER}  0.02504223 0.5500000  1.711069
# > 263 {CHRISTMAS,HOLDER} => {BOTTLE}  0.02504223 0.4878398  3.075423
# > 265 {CHRISTMAS,HEART}  => {BAG}     0.02004847 0.5405941  2.242239
# > 266 {BAG,CHRISTMAS}    => {HEART}   0.02004847 0.4299213  2.131139
# > 268 {CHRISTMAS,HEART}  => {BOX}     0.02203128 0.5940594  2.053645
# > 269 {BOX,CHRISTMAS}    => {HEART}   0.02203128 0.4005340  1.985465
# > 271 {CHRISTMAS,HEART}  => {HOLDER}  0.02247191 0.6059406  1.885102
# > 272 {CHRISTMAS,HOLDER} => {HEART}   0.02247191 0.4377682  2.170036
# > 274 {CASES,CHRISTMAS}  => {BAG}     0.02291254 0.4822257  2.000142
# > 275 {BAG,CHRISTMAS}    => {CASES}   0.02291254 0.4913386  2.336904
# > 277 {CASES,CHRISTMAS}  => {BOX}     0.02548285 0.5363215  1.854047
# > 278 {BOX,CHRISTMAS}    => {CASES}   0.02548285 0.4632844  2.203473
# > 280 {CASES,CHRISTMAS}  => {HOLDER}  0.02283910 0.4806801  1.495412
# > 281 {CHRISTMAS,HOLDER} => {CASES}   0.02283910 0.4449213  2.116135
# > 283 {CHRISTMAS,SIGN}   => {BAG}     0.02137035 0.6024845  2.498943
# > 284 {BAG,CHRISTMAS}    => {SIGN}    0.02137035 0.4582677  2.123973
# > 286 {CHRISTMAS,SIGN}   => {BOX}     0.02342660 0.6604555  2.283174
# > 287 {BOX,CHRISTMAS}    => {SIGN}    0.02342660 0.4259012  1.973961
# > 289 {CHRISTMAS,SIGN}   => {HOLDER}  0.02276566 0.6418219  1.996731
# > 290 {CHRISTMAS,HOLDER} => {SIGN}    0.02276566 0.4434907  2.055484
# > 292 {BAG,CHRISTMAS}    => {BOX}     0.02687817 0.5763780  1.992521
# > 293 {BOX,CHRISTMAS}    => {BAG}     0.02687817 0.4886515  2.026795
# > 295 {BAG,CHRISTMAS}    => {HOLDER}  0.02460160 0.5275591  1.641255
# > 296 {CHRISTMAS,HOLDER} => {BAG}     0.02460160 0.4792561  1.987825
# > 298 {BOX,CHRISTMAS}    => {HOLDER}  0.02812661 0.5113485  1.590823
# > 299 {CHRISTMAS,HOLDER} => {BOX}     0.02812661 0.5479256  1.894162
# # what purchases yielded Candles?

rhs.rules <- subset(rulesx, subset = rhs %pin% c("CANDLES"))
rhs.rules
# > set of 26 rules
# tmp <- as.data.frame(arules::inspect(head(sort(rhs.rules, by = "support"), 10)))
# >     lhs             rhs       support    confidence lift    
# > 46  {HOLDER}     => {CANDLES} 0.04920320 0.1530729  1.339584
# > 44  {BOX}        => {CANDLES} 0.04714695 0.1629855  1.426333
# > 38  {CASES}      => {CANDLES} 0.03958287 0.1882641  1.647552
# > 42  {BAG}        => {CANDLES} 0.03789381 0.1571733  1.375469
# > 36  {HEART}      => {CANDLES} 0.03473599 0.1721878  1.506865
# > 40  {SIGN}       => {CANDLES} 0.03429537 0.1589517  1.391031
# > 34  {BOTTLE}     => {CANDLES} 0.02908130 0.1833333  1.604402
# > 30  {BOWL}       => {CANDLES} 0.02805317 0.2200461  1.925686
# > 252 {BOX,HOLDER} => {CANDLES} 0.02768598 0.2800892  2.451140
# > 32  {BUNTING}    => {CANDLES} 0.02739223 0.1605682  1.405178
inspect(head(sort(rhs.rules, by = "confidence")))
# >     lhs                rhs       support    confidence lift    
# > 219 {BAG,HEART}     => {CANDLES} 0.02056253 0.3517588  3.078342
# > 213 {BOWL,BOX}      => {CANDLES} 0.02019534 0.3467844  3.034809
# > 216 {BOTTLE,HOLDER} => {CANDLES} 0.02026878 0.3183391  2.785876
# > 222 {BOX,HEART}     => {CANDLES} 0.02247191 0.3122449  2.732544
# > 237 {BAG,SIGN}      => {CANDLES} 0.02232503 0.3111566  2.723020
# > 234 {CASES,HOLDER}  => {CANDLES} 0.02232503 0.3095723  2.709156
# 
# The plot function in arules is also very flexible. You can look at various scatterplots across the various metrics, or even count and group a small number of rules and show the metrics as bubbles.

plot(rhs.rules, method = "scatterplot")

# Insert Image: B05033_06_04.extension
# 
# 
plot(rhs.rules, method = "grouped")

# Insert Image: B05033_06_05.extension
# 
# Generating Many Rules
# If you wish to generate as many rules as possible, set support and confidence to a very low number.

many_rules <- apriori(trans4, parameter = list(minlen = 1, support = 0.01, confidence = 0.01))
# > Apriori
# > 
#   > Parameter specification:
#   >  confidence minval smax arem  aval originalSupport support minlen maxlen
# >        0.01    0.1    1 none FALSE            TRUE    0.01      1     10
# >  target   ext
# >   rules FALSE
# > 
#   > Algorithmic control:
#   >  filter tree heap memopt load sort verbose
# >     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
# > 
#   > Absolute minimum support count: 136 
# > 
#   > set item appearances ...[0 item(s)] done [0.00s].
# > set transactions ...[13 item(s), 13617 transaction(s)] done [0.00s].
# > sorting and recoding items ... [13 item(s)] done [0.00s].
# > creating transaction tree ... done [0.00s].
# > checking subsets of size 1 2 3 4 5 6 7 8 done [0.00s].
# > writing ... [8898 rule(s)] done [0.00s].
# > creating S4 object  ... done [0.00s].
many_rules
# > set of 8898 rules

# Plotting many rules
# Plots are especially helpful for scenarios in which there are many rules generated, and you need to filter on specific support and confidence ranges.
# 
# Here is a plot which shows 2 of the 3 metrics, along the x and y axis, and the 3rd metric (lift, support, or confidence) as shading. As the plot below suggests, there is a cluster of rules with high lift (>8), high confidence (> .6), but all with low support.

sel <- plot(many_rules, measure = c("support", "confidence"), shading = "lift", 
            interactive = FALSE)

# Insert Image: B05033_06_06.extension
# Method 2 - Creating a physical transactions file
# Now that you know have to run association rules using the "coerce to dataframe" method, we will now illustrate the "write to file" method.
# .	In the write to file method, each item is written to a separate line, along with the identifying key, which in our case is the InvoiceId. 
# .	The advantage to the write to file method is that very large data files can be accumulated separately, and them combined together if needed. 
# .	You can use the file.show function to display the contents of the file that will be input to the association rules algorithm.

setwd("C:/PracticalPredictiveAnalytics/Outputs")
#RW is this needed?
#load("OnlineRetail.full.Rda")
# OnlineRetail <- OnlineRetail[1:100,]
nrow(OnlineRetail)
# > [1] 268034
head(OnlineRetail)
# >   InvoiceNo StockCode                       Description Quantity
# > 5    536365     71053                     METAL LANTERN        6
# > 6    536365     21730 GLASS STAR FROSTED T-LIGHT HOLDER        6
# > 2    536365     22752      SET 7 BABUSHKA NESTING BOXES        2
# > 4    536365    84029E             WOOLLY HOTTIE  HEART.        6
# > 1    536365    84406B    CREAM CUPID HEARTS COAT HANGER        8
# > 8    536366     22632            HAND WARMER  POLKA DOT        6
# >      InvoiceDate UnitPrice CustomerID        Country itemcount
# > 5 12/1/2010 8:26      3.39      17850 United Kingdom         7
# > 6 12/1/2010 8:26      4.25      17850 United Kingdom         7
# > 2 12/1/2010 8:26      7.65      17850 United Kingdom         7
# > 4 12/1/2010 8:26      3.39      17850 United Kingdom         7
# > 1 12/1/2010 8:26      2.75      17850 United Kingdom         7
# > 8 12/1/2010 8:28      1.85      17850 United Kingdom         2
# >                           Desc2 lastword firstword
# > 5                  MetalLantern  LANTERN     METAL
# > 6 GlassStarFrostedT-lightHolder   HOLDER     GLASS
# > 2      Set7BabushkaNestingBoxes    BOXES       SET
# > 4            WoollyHottieHeart.   HEART.    WOOLLY
# > 1    CreamCupidHeartsCoatHanger   HANGER     CREAM
# > 8            HandWarmerPolkaDot      DOT      HAND
# concatenate the Invoice Number to the Description separated by a delimiter
data2 <- paste(OnlineRetail$InvoiceNo, OnlineRetail$Desc2, sep = "!")

# eliminate duplicates
data2 <- unique(data2)
# 

write(data2, file = "demo_single")
# file.show('demo_single')
# Reading the transaction file back in
# Use the read.transaction to read the delimited file back into memory formatted as a transaction file. This will have the same results as coercing the dataframe to a transaction file as we did earlier. 
# The difference is that the transactions are formatted one transaction per line, as specified by the format='single' option. We also specify where the transactionid and item desriptions are via the cols option. It is possible to have multiple descriptors and transaction id's, and identify them with the cols options. The sep keyword designates the delimiter, which in this case is the ! character. There is also a remove duplicate transactions option, which is a logical value which determines whether or not you want to eliminate duplicates.
# The returned object, trans, is an itemMatrix. You can type 'trans' to see the dimension, or run the dim(trans) to see the dimensions. This will tell you how many transactions the itemMatrix is based upon.
# As before, to view the items in the trans object, use the inspect function.
library(arules)
library(arulesViz)
setwd("C:/PracticalPredictiveAnalytics/Outputs")

# file.show('demo_single')
trans <- read.transactions("demo_single", format = "single", sep = "!", cols = c(1, 
2), rm.duplicates = FALSE, quote = "")
trans
# > transactions in sparse format with
# >  19403 transactions (rows) and
# >  3462 items (columns)
dim(trans)
# > [1] 19403  3462
inspect(trans[1:5])
# >   items                            transactionID
# > 1 {CreamCupidHeartsCoatHanger,                  
# >    GlassStarFrostedT-lightHolder,               
# >    MetalLantern,                                
# >    Set7BabushkaNestingBoxes,                    
# >    WoollyHottieHeart.}                    536365
# > 2 {HandWarmerPolkaDot}                    536366
# > 3 {FeltcraftPrincessCharlotteDoll,              
# >    KnittedMugCosy,                              
# >    LoveBuildingBlockWord,                       
# >    Poppy'sPlayhouseKitchen}               536367
# > 4 {CoatRackParisFashion}                  536368
# > 5 {CircusParadeLunchBox,                        
#   >    LunchBoxILoveLondon,                         
#   >    MiniJigsawSpaceboy,                          
#   >    PandaAndBunniesStickerSheet,                 
#   >    Postage,                                     
#   >    RoundSnackBoxesSetOf4Woodland,               
#   >    SpaceboyLunchBox,                            
#   >    ToadstoolLedNightLight}                536370
# Take a look at some of the frequently purchases items. Use the itemFrequencePlot function to see a simple barchart of the top item purchases.
dim(trans)
# > [1] 19403  3462
# look up any item in labels to see if it is there.

itemFrequencyPlot(trans, topN = 10, cex.names = 1)

# Insert Image: B05033_06_07.extension
# 
# The itemLabels function lists all of the labels associated with the itemset. Since the top ranked item has an unusual abbreviation in it (T-light), you could check to see if there are other items which have that term in it. To accomplish this, use the grep function.

result <- grep("T-light", itemLabels(trans), value = TRUE)
str(result)
# >  chr [1:96] "6ChocolateLoveHeartT-lights" ...
head(result)
# > [1] "6ChocolateLoveHeartT-lights"   "AgedGlassSilverT-lightHolder" 
# > [3] "AntiqueSilverT-lightGlass"     "AssortedColourT-lightHolder"  
# > [5] "BeadedChandelierT-lightHolder" "BonneJamJarT-lightHolder"
# Apply the rules engine again. We will use a small support and confidence level to generate many rules.
rules1 <- apriori(trans, parameter = list(minlen = 1, support = 0.001, confidence = 0.001))
# > Apriori
#  > 
#   > Parameter specification:
#   >  confidence minval smax arem  aval originalSupport support minlen maxlen
# >       0.001    0.1    1 none FALSE            TRUE   0.001      1     10
# >  target   ext
# >   rules FALSE
# > 
#   > Algorithmic control:
#   >  filter tree heap memopt load sort verbose
# >     0.1 TRUE TRUE  FALSE TRUE    2    TRUE
# > 
#   > Absolute minimum support count: 19 
# > 
#   > set item appearances ...[0 item(s)] done [0.00s].
# > set transactions ...[3462 item(s), 19403 transaction(s)] done [0.03s].
# > sorting and recoding items ... [2209 item(s)] done [0.01s].
# > creating transaction tree ... done [0.01s].
# > checking subsets of size 1 2 3 4 done [0.20s].
# > writing ... [63121 rule(s)] done [0.02s].
# > creating S4 object  ... done [0.02s].
rules1
# > set of 63121 rules
# Sort the rules by the 3 measures support, confidence, lift to get an idea of some of the more valuable rules. Sort by confidence,support, and lift to look at the highest scoring rules in each category.
tmp <- as.data.frame(inspect(tail(sort(rules1, by = "lift"))))
# >       lhs                             rhs                         
# > 38860 {AssortedColourBirdOrnament} => {StorageBagSuki}            
# > 38861 {StorageBagSuki}             => {AssortedColourBirdOrnament}
# > 38893 {BagRetrospot}               => {AssortedColourBirdOrnament}
# > 38892 {AssortedColourBirdOrnament} => {BagRetrospot}              
# > 11539 {AlarmClockBakelike}         => {RexCash+carryShopper}      
# > 11538 {RexCash+carryShopper}       => {AlarmClockBakelike}        
# >       support     confidence lift     
# > 38860 0.001030768 0.02724796 0.8976097
# > 38861 0.001030768 0.03395586 0.8976097
# > 38893 0.001700768 0.03122044 0.8252999
# > 38892 0.001700768 0.04495913 0.8252999
# > 11539 0.001082307 0.01621622 0.7183636
# > 11538 0.001082307 0.04794521 0.7183636
tmp <- as.data.frame(inspect(head(sort(rules1, by = "support"))))
# >      lhs    rhs                         support    confidence lift
# > 2207 {}  => {HangingHeartT-lightHolder} 0.07256610 0.07256610 1   
# > 2208 {}  => {HeartOfWicker}             0.07004072 0.07004072 1   
# > 2209 {}  => {AlarmClockBakelike}        0.06674226 0.06674226 1   
# > 2205 {}  => {BagRetrospot}              0.05447611 0.05447611 1   
# > 2201 {}  => {RegencyCakesd3Tier}        0.05251765 0.05251765 1   
# > 2190 {}  => {PartyBunting}              0.04184920 0.04184920 1
tmp <- as.data.frame(inspect(head(sort(rules1, by = "confidence"))))
# >   lhs                               rhs                      support confidence     lift
# > 1 {PolkadotCup,                                                                         
#   >    RetrospotCharlotteBag,                                                               
#   >    SpotCeramicDrawerKnob}        => {AlarmClockBakelike} 0.001082307  1.0000000 14.98301
# > 2 {AlarmClockBakelike,                                                                  
#   >    Charlie+lolaHotWaterBottle,                                                          
#   >    ChristmasGinghamTree}         => {BabushkaNotebook}   0.001185384  0.9200000 48.24530
# > 3 {ChristmasHangingStarWithBell,                                                        
#   >    RegencyTeacupAndSaucer}       => {AlarmClockBakelike} 0.001133845  0.9166667 13.73443
# > 4 {PolkadotBowl,                                                                        
#   >    RetrospotCharlotteBag,                                                               
#   >    SpotCeramicDrawerKnob}        => {AlarmClockBakelike} 0.001133845  0.9166667 13.73443
# > 5 {AlarmClockBakelikeChocolate,                                                         
#   >    PolkadotCup}                  => {AlarmClockBakelike} 0.001030768  0.9090909 13.62092
# > 6 {BabushkaNotebook,                                                                    
#   >    Charlie+lolaHotWaterBottle,                                                          
#   >    HeartMeasuringSpoons}         => {AlarmClockBakelike} 0.001339999  0.8965517 13.43304
# You can also coerce the rules to a dataframe and use kable to print the first 10 rows, or subset as you choose.
rules1 <- sort(rules1, by = "confidence")
rules1.df <- as(rules1, "data.frame")
cat("using kable to print rules")
# > using kable to print rules
library(knitr)
kable(rules1.df[1:10, ])
# 
# Rules	support	confidence	lift
# 62966	{PolkadotCup,RetrospotCharlotteBag,SpotCeramicDrawerKnob} => {AlarmClockBakelike}	0.0010823	1.0000000	14.98301
# 62971	{AlarmClockBakelike,Charlie+lolaHotWaterBottle,ChristmasGinghamTree} => {BabushkaNotebook}	0.0011854	0.9200000	48.24530
# 51467	{ChristmasHangingStarWithBell,RegencyTeacupAndSaucer} => {AlarmClockBakelike}	0.0011338	0.9166667	13.73443
# 62982	{PolkadotBowl,RetrospotCharlotteBag,SpotCeramicDrawerKnob} => {AlarmClockBakelike}	0.0011338	0.9166667	13.73443
# 51338	{AlarmClockBakelikeChocolate,PolkadotCup} => {AlarmClockBakelike}	0.0010308	0.9090909	13.62092
# 63058	{BabushkaNotebook,Charlie+lolaHotWaterBottle,HeartMeasuringSpoons} => {AlarmClockBakelike}	0.0013400	0.8965517	13.43304
# 62970	{BabushkaNotebook,Charlie+lolaHotWaterBottle,ChristmasGinghamTree} => {AlarmClockBakelike}	0.0011854	0.8846154	13.25420
# 62972	{AlarmClockBakelike,BabushkaNotebook,ChristmasGinghamTree} => {Charlie+lolaHotWaterBottle}	0.0011854	0.8846154	76.62586
# 51347	{AlarmClockBakelikeChocolate,DinerWallClock} => {AlarmClockBakelike}	0.0011338	0.8800000	13.18505
# 51356	{AlarmClockBakelikeChocolate,BoxOf24CocktailParasols} => {AlarmClockBakelike}	0.0011338	0.8800000	13.18505
# Plotting the rules
# The default plot of the rules will give you a scatterplot of all of the rules showing support on the x-axis and confidence on the y-axis. We can see from the density that confidence can vary from high to low with most of the density occurring at the .5 level. Support tends to be low, and the highest support level attains ~.07.
plot(rules1)

# Insert Image: B05033_06_08.extension
# Creating subsets of the rules
# As we did before, we can look at some of the subsets by parsing left or right side.
# For example, we might be interested in seeing what items yielded purchasing Chocolate things.
# .	Subset the rules set using the %pin% operator (Partial match), and look for any transactions where "Chocolate" appears in the right hand side.

purchased.this <- "Chocolate"

lhs.rules <- subset(rules1, subset = rhs %pin% purchased.this)

# .	Printing lhs.rules shows that there are 487 of them. 
# 
print(lhs.rules)
# > set of 487 rules
# 
# .	Sort them by lift, inspect them, and plot the first 15 as a graph.
# 
lhs.rules <- sort(lhs.rules, by = "lift")

inspect(head(sort(lhs.rules, by = "lift")))
# >   lhs                                rhs                                 support confidence     lift
# > 1 {CakeTowelSpots}                => {CakeTowelChocolateSpots}       0.001185384  0.2911392 89.66626
# > 2 {BiscuitsBowlLight,                                                                               
#   >    DollyMixDesignBowl}            => {ChocolatesBowl}                0.001030768  0.4444444 68.98844
# > 3 {BakingMouldHeartChocolate}     => {BakingMouldHeartMilkChocolate} 0.001030768  0.2941176 57.64409
# > 4 {BakingMouldHeartMilkChocolate} => {BakingMouldHeartChocolate}     0.001030768  0.2020202 57.64409
# > 5 {BiscuitsBowlLight}             => {ChocolatesBowl}                0.001700768  0.3586957 55.67817
# > 6 {MarshmallowsBowl}              => {ChocolatesBowl}                0.002422306  0.2397959 37.22208
# 
# .	The directional graph is a good way to illustrate which purchases influence other purchase once you have narrowed down the number of itemset to a small number.
# .	The DollyMixDesignBowl and MarshmallowsBowl appear as large and darker bubbles indicating that they are better predictors for "Chocolate" purchase relative to support, confidence and lift.
plot(lhs.rules[1:15], method = "graph", control = list(type = "items", cex = 0.5))

# Insert Image: B05033_06_09.extension
# 
# .	Finally, If you wish to save you workspace, use the save.image command.
save.image(file = "ch6 part 2.Rdata")

# Text Clustering
# In the previous sections we used the lastword technique for categorizing the types of purchases by simple keywords. We could also use more sophisticated techniques such as word clustering to try to identify which types of purchasing clusters occur and then use that to subset the association rules. To illustrate text clustering on our OnlineRetail dataset will first need to load our training and test dataframes that we previously saved. Also, issue a set.seed command since we will be doing some sampling later on.
#setwd("C:/Users/randy/Desktop/ch6")
# load the training data
#load("OnlineRetail.full.Rda")
set.seed(1)

# We previously demonstrated some text mining examples using a package called RTextTools. Another popular text mining package is "Tm". Tm has been around for a long time, and it will be useful to know this package works. Tm requires that all text data be converted to a corpus first. That can be done using the VCorpus function. We can use vector input, since we already have the data available in an existing data frame, and there is no need to read in additional external data.
library(tm)
# > Loading required package: NLP
attach(OnlineRetail)
nrow(OnlineRetail)
# > [1] 268034
corp <- VCorpus(VectorSource(OnlineRetail$Description))

# Displaying the corp object shows you some information about the metadata

head(corp)
# > <<VCorpus>>
#   > Metadata:  corpus specific: 0, document level (indexed): 0
# > Content:  documents: 6
# Converting to a Document Term Matrix
# Once we have a corpus, we can proceed to convert it to a document term matrix. When building DTM, care must be given to limiting the amount of data and resulting terms that are processed. If not parameterized correctly, it can take a very long time to run. Parameterization is accomplished via the options. We will remove any stopwords, punctuation and numbers. Additionally, we will only include minimum word length of 4.

library(tm)
dtm <- DocumentTermMatrix(corp, control = list(removePunctuation = TRUE, wordLengths = c(4, 
                                                                                         999), stopwords = TRUE, removeNumbers = TRUE, stemming = FALSE, bounds = list(global = c(5, 
                                                                                                                                                                                  Inf))))
save.image(file = "OnlineRetail-dtm.Rdata")


# We can begin to look at the data by using the inspect function.  Note: this is different from the inspect function in arules, and if you have the arules package loaded, you will want to preface this inspect with tm::inspect
#RW put a save file here since it is the longest running part

inspect(dtm[1:10, 1:10])
# > <<DocumentTermMatrix (documents: 10, terms: 10)>>
#   > Non-/sparse entries: 0/100
# > Sparsity           : 100%
# > Maximal term length: 8
# > Weighting          : term frequency (tf)
# > 
#   >     Terms
# > Docs abstract acapulco account acrylic address adult advent afghan aged
# >   1         0        0       0       0       0     0      0      0    0
# >   2         0        0       0       0       0     0      0      0    0
# >   3         0        0       0       0       0     0      0      0    0
# >   4         0        0       0       0       0     0      0      0    0
# >   5         0        0       0       0       0     0      0      0    0
# >   6         0        0       0       0       0     0      0      0    0
# >   7         0        0       0       0       0     0      0      0    0
# >   8         0        0       0       0       0     0      0      0    0
# >   9         0        0       0       0       0     0      0      0    0
# >   10        0        0       0       0       0     0      0      0    0
# >     Terms
# > Docs ahoy
# >   1     0
# >   2     0
# >   3     0
# >   4     0
# >   5     0
# >   6     0
# >   7     0
# >   8     0
# >   9     0
# >   10    0
# After the DTM has been created, we can look at the metadata that has been producted by issuing a print(dtm) command. We can see the number of documents and terms by looking at the first line.
print(dtm)
# > <<DocumentTermMatrix (documents: 268034, terms: 1675)>>
#   > Non-/sparse entries: 826898/448130052
# > Sparsity           : 100%
# > Maximal term length: 20
# > Weighting          : term frequency (tf)
# Remove Sparse Terms
# Most TDM's are initially filled with a lot of empty space. That is because every word in a corpus is indexed, and there are many words which occur so infrequently, that they do not matter analytically. Removing sparse terms is a method in which we can reduce the number of terms to a manageable size, and also save space at the same time.
# The removeSparseTerms function will reduce the number of terms in the Description from 268034 to 62.
dtms <- removeSparseTerms(dtm, 0.99)
dim(dtms)
# > [1] 268034     62

# As an alternative to inspect, we can also view it in matrix form

View(as.matrix(dtms))



# Insert Image: B05033_06_10.extension
# Finding Frequent Terms
# The tm package has a useful function called findFreqTerms which is useful to find the frequency of the popular terms used. The second argument to the function restricts the results to terms which have a minimum frequency specified. We can also compute the occurrences by summing up the 1's and 0's for each term in the TDM. Then we can sort the list and display the highest and lowest frequency occurrences.
# 
data.frame(findFreqTerms(dtms, 10000, Inf))
# >   findFreqTerms.dtms..10000..Inf.
# > 1                            cake
# > 2                       christmas
# > 3                          design
# > 4                           heart
# > 5                           metal
# > 6                       retrospot
# > 7                         vintage
freq <- colSums(as.matrix(dtms))
# there are xx terms
length(freq)
# > [1] 62
ord <- order(freq)
# look at the top and bottom number of terms
freq[head(ord, 12)]
# >     union     skull      zinc      bird      wood      wall  birthday 
# >      2752      2770      2837      2974      2993      3042      3069 
# >    colour charlotte      star   antique    silver 
# >      3089      3114      3121      3155      3175
freq[tail(ord, 10)]
# >   hanging      sign     lunch     metal      cake christmas    design 
# >      8437      8580      9107     10478     10623     12534     14884 
# >   vintage retrospot     heart 
# >     16755     17445     19520
# 
# For presentation purposes, a barplot is also useful for displaying the relative frequencies.
# 
barplot(freq[tail(ord, 10)], cex.names = 0.75, col = c("blue"))

# B05033_06_11.pngWe could also do a little code manipulation to only display the topN most frequent term.

dtmx <- dtms[, names(tail(sort(colSums(as.matrix(dtms))), 12))]
inspect(dtmx[1:10, ])
# > <<DocumentTermMatrix (documents: 10, terms: 12)>>
# > Non-/sparse entries: 3/117
# > Sparsity           : 98%
# > Maximal term length: 9
# > Weighting          : term frequency (tf)
# > 
# >     Terms
# > Docs pack holder hanging sign lunch metal cake christmas design vintage
# >   1     0      0       0    0     0     1    0         0      0       0
# >   2     0      1       0    0     0     0    0         0      0       0
# >   3     0      0       0    0     0     0    0         0      0       0
# >   4     0      0       0    0     0     0    0         0      0       0
# >   5     0      0       0    0     0     0    0         0      0       0
# >   6     0      0       0    0     0     0    0         0      0       0
# >   7     0      0       0    0     0     0    0         0      0       0
# >   8     0      0       0    0     0     0    0         0      0       0
# >   9     0      0       0    0     0     0    0         0      0       0
# >   10    0      0       0    0     0     0    0         0      0       0
# >     Terms
# > Docs retrospot heart
# >   1          0     0
# >   2          0     0
# >   3          0     0
# >   4          0     1
# >   5          0     0
# >   6          0     0
# >   7          0     0
# >   8          0     0
# >   9          0     0
# >   10         0     0
# Kmeans clustering of terms
# Now we can cluster the Term Document Matrix using Kmeans. We will specify that 5 clusters be generated.

kmeans5 <- kmeans(dtms, 5)

# Once kmeans is done, we will append the cluster number to the original data, and then create 5 subsets based upon the cluster.

kw_with_cluster <- as.data.frame(cbind(OnlineRetail, Cluster = kmeans5$cluster))

# subset the five clusters
cluster1 <- subset(kw_with_cluster, subset = Cluster == 1)
cluster2 <- subset(kw_with_cluster, subset = Cluster == 2)
cluster3 <- subset(kw_with_cluster, subset = Cluster == 3)
cluster4 <- subset(kw_with_cluster, subset = Cluster == 4)
cluster5 <- subset(kw_with_cluster, subset = Cluster == 5)
# Examining Cluster 1
# 
# Print out a sample of the data.

head(cluster1[10:13])
# Desc2  lastword firstword Cluster
# 50   VintageBillboardLove/hateMug       MUG   VINTAGE       1
# 86              BagVintagePaisley   PAISLEY       BAG       1
# 113         ShopperVintagePaisley   PAISLEY   SHOPPER       1
# 145         ShopperVintagePaisley   PAISLEY   SHOPPER       1
# 200  VintageHeadsAndTailsCardGame      GAME   VINTAGE       1
# 210 PaperChainKitVintageChristmas CHRISTMAS     PAPER       1
# 
# Table the frequencies and print out the most popular terms in the clusters.  Observe that many of these items have to do with Chrismas and Paisley items, which seem to occur together.
# 
# tail(sort(table(cluster1$lastword)), 10)
# MUG      GAME   BUNTING     CARDS    DESIGN      LEAF           
# 427       431       456       482       535       717       911 
# DOILY   PAISLEY CHRISTMAS 
# 1073      1699      1844
# 
# Examining Cluster 2
# 
# After tabling Cluster 2 below, it looks like this cluster has something to do with "Hanging Holders"
head(cluster2[10:13])
# Desc2 lastword firstword Cluster
# 6     GlassStarFrostedT-lightHolder   HOLDER     GLASS       2
# 57        HangingHeartT-lightHolder   HOLDER   HANGING       2
# 62    GlassStarFrostedT-lightHolder   HOLDER     GLASS       2
# 70        HangingHeartT-lightHolder   HOLDER   HANGING       2
# 81        HangingHeartT-lightHolder   HOLDER   HANGING       2
# 156 ColourGlassT-lightHolderHanging  HANGING    COLOUR       2
# 

tail(sort(table(cluster2$lastword)), 10)
# ANTIQUE	LANTERN	HLDR	DECORATION		GLASS	T-LIGHT	HANGING	HEART	HOLDER
# 167	181	226	260	319	361	531	639	668	6792
# 
# Examining Cluster 3
# 
# Cluster 3 may have to do with customers purchasing sets of design boxes.

head(cluster3[10:13])
# Desc2 lastword firstword Cluster
# 5                    MetalLantern  LANTERN     METAL       3
# 2        Set7BabushkaNestingBoxes    BOXES       SET       3
# 4              WoollyHottieHeart.   HEART.    WOOLLY       3
# 1      CreamCupidHeartsCoatHanger   HANGER     CREAM       3
# 8              HandWarmerPolkaDot      DOT      HAND       3
# 10 FeltcraftPrincessCharlotteDoll     DOLL FELTCRAFT       3

tail(sort(table(cluster3$lastword)),10)
head(cluster4[10:13])
# Desc2  lastword firstword Cluster
# 100 LunchBoxWithCutleryRetrospot RETROSPOT     LUNCH       4
# 102   PackOf72RetrospotCakeCases     CASES      PACK       4
# 84       60TeatimeFairyCakeCases     CASES        60       4
# 94     3PieceRetrospotCutlerySet       SET         3       4
# 91             LunchBagRetrospot RETROSPOT     LUNCH       4
# 127             RetrospotMilkJug       JUG RETROSPOT       4

tail(sort(table(cluster4$lastword)), 10)
# APRON   NAPKINS      BANK                  PC      TINS    DESIGN 
# 486       511       512       514       531       664      1203 
# BAG     CASES RETROSPOT 
# 1395      4318      6485 
# Examining Cluster 5
# 
# Finally, Cluster 5 seems to be concerned with the purchases of Bottles.  Possible having to do with perfumes, elixir's and tonics.

head(cluster5)
# > head(cluster5[10:13])
# Desc2 lastword firstword Cluster
# 59  KnittedUnionFlagHotWaterBottle   BOTTLE   KNITTED       5
# 68  KnittedUnionFlagHotWaterBottle   BOTTLE   KNITTED       5
# 181       AssortedBottleTopMagnets  MAGNETS  ASSORTED       5
# 206      EnglishRoseHotWaterBottle   BOTTLE   ENGLISH       5
# 229   RetrospotHeartHotWaterBottle   BOTTLE RETROSPOT       5
# 261   HotWaterBottleTeaAndSympathy SYMPATHY       HOT       5
# 

tail(sort(table(cluster5$lastword)), 10)

# BABUSHKA  MAGNETS    TONIC   ELIXIR  PERFUME   OPENER SYMPATHY   POORLY     CALM   BOTTLE 
# 87       95      108      112      132      149      318      345      418     3795 
# Creating a DTM from the test data set, and calculating the new cluster assignments
# The goal in this exercise is to score the test dataset based upon the predict method for the training dataset.
# First, let's read in our test data set and create a document term matrix. In this example we will use the create_matrix function from RTextTools which can create a TDM first without having a separate step of creating a corpus

#load("OnlineRetail.test.Rda")
library(RTextTools)
# > Loading required package: SparseM
# > 
#   > Attaching package: 'SparseM'
# > The following object is masked from 'package:base':
#   > 
#   >     backsolve
dtMatrixTest <- create_matrix(OnlineRetail.test$Description, minDocFreq = 1, 
                              removeNumbers = TRUE, minWordLength = 4, removeStopwords = TRUE, removePunctuation = TRUE, 
                              stemWords = FALSE, weighting = weightTf)

# As we did before for the training dataset, remove the sparse terms.
dtMatrixTest <- removeSparseTerms(dtMatrixTest, 0.99)
dtMatrixTest
# > <<DocumentTermMatrix (documents: 268034, terms: 61)>>
#   > Non-/sparse entries: 349663/16000411
# > Sparsity           : 98%
# > Maximal term length: 10
# > Weighting          : term frequency (tf)
# kmeans function does not have a prediction method. However we can use the flexclust package which does. Since the prediction method can take a long time to run, we will illustrate it only on a sample number of rows and columns. In order to compare the test and training results, they also need to have the same number of columns. Reload the test and training data we have saved, and create the TDM's from scratch, based upon the sample.size

set.seed(1)
sample.size <- 10000
max.cols <- 10

library("flexclust")
#load("OnlineRetail.full.Rda")


# Create the sample
OnlineRetail <- OnlineRetail[1:sample.size, ]
require(tm)
library(RTextTools)
# Create the DTM for the training data

dtMatrix <- create_matrix(OnlineRetail$Description, minDocFreq = 1, removeNumbers = TRUE, 
minWordLength = 4, removeStopwords = TRUE, removePunctuation = TRUE, stemWords = FALSE, 
weighting = weightTf)
# Check the dimensions of the data.  We can see that there are 1300 terms.  Virtually all of them are space terms so we will remove them from the matrix.

dim(dtMatrix)
# > [1] 10000  1300

dtMatrix <- removeSparseTerms(dtMatrix, 0.99)

# Removing the sparse terms reduces the number of columns from 1300 to 62!

dim(dtMatrix)
# > [1] 10000    62
# We will only keep same number of terms (max.cols) in test and train.

dtMatrix <- dtMatrix[, 1:max.cols]

# repeat kmeans using the kcca function. Clusters=5

clust1 = kcca(dtMatrix, k = 5, kccaFamily("kmeans"))
clust1
# > kcca object of family 'kmeans' 
# > 
# > call:
# > kcca(x = dtMatrix, k = 5, family = kccaFamily("kmeans"))
# > 
# > cluster sizes:
# > 
# >    1    2    3    4    5 
# >  360  120  152  387 8981
# 
# 
# Print the number of products categorized in each cluster

table(clust1@cluster)
# > 
# >    1    2    3    4    5 
# >  360  120  152  387 8981
# 
# Merge the clusters with the training data, and show the cluster assigned to each

kw_with_cluster2 <- as.data.frame(cbind(OnlineRetail, Cluster = clust1@cluster))

head(kw_with_cluster2)
# >   InvoiceNo StockCode                       Description Quantity
# > 5    536365     71053                     METAL LANTERN        6
# > 6    536365     21730 GLASS STAR FROSTED T-LIGHT HOLDER        6
# > 2    536365     22752      SET 7 BABUSHKA NESTING BOXES        2
# > 4    536365    84029E             WOOLLY HOTTIE  HEART.        6
# > 1    536365    84406B    CREAM CUPID HEARTS COAT HANGER        8
# > 8    536366     22632            HAND WARMER  POLKA DOT        6
# >      InvoiceDate UnitPrice CustomerID        Country itemcount
# > 5 12/1/2010 8:26      3.39      17850 United Kingdom         7
# > 6 12/1/2010 8:26      4.25      17850 United Kingdom         7
# > 2 12/1/2010 8:26      7.65      17850 United Kingdom         7
# > 4 12/1/2010 8:26      3.39      17850 United Kingdom         7
# > 1 12/1/2010 8:26      2.75      17850 United Kingdom         7
# > 8 12/1/2010 8:28      1.85      17850 United Kingdom         2
# >                           Desc2 lastword firstword Cluster
# > 5                  MetalLantern  LANTERN     METAL       5
# > 6 GlassStarFrostedT-lightHolder   HOLDER     GLASS       5
# > 2      Set7BabushkaNestingBoxes    BOXES       SET       5
# > 4            WoollyHottieHeart.   HEART.    WOOLLY       5
# > 1    CreamCupidHeartsCoatHanger   HANGER     CREAM       5
# > 8            HandWarmerPolkaDot      DOT      HAND       5
# Run the predict method on the training set. We will eventually apply it to the test data
pred_train <- predict(clust1)

# Load the test data set, take an identical sample size as was taken for the training data, and repeat the procedure starting with creating the term document matrix on the sample. 
# 
#load("OnlineRetail.test.Rda")
OnlineRetail.test <- OnlineRetail.test[1:sample.size, ]
dtMatrix.test <- create_matrix(OnlineRetail.test$Description, minDocFreq = 1, 
removeNumbers = TRUE, minWordLength = 4, removeStopwords = TRUE, removePunctuation = TRUE, 
stemWords = FALSE, weighting = weightTf)
# Remove sparse terms
dtMatrix.test <- removeSparseTerms(dtMatrix.test, 0.99)

# reduced to 61 terms
dim(dtMatrix.test)
# > [1] 10000    61
# Take the first max.col terms
dtMatrix.test <- dtMatrix.test[, 1:max.cols]

dtMatrix.test
# > <<DocumentTermMatrix (documents: 10000, terms: 10)>>
# > Non-/sparse entries: 2072/97928
# > Sparsity           : 98%
# > Maximal term length: 8
# > Weighting          : term frequency (tf)
# Verify that the test and training data have the same number of dimensions
dim(dtMatrix)
# > [1] 10000    10
dim(dtMatrix.test)
# > [1] 10000    10
# Run prediction function on training data, and apply it to the test data


pred_test <- predict(clust1, newdata = dtMatrix.test)

# Table the cluster assignments for the test dat

table(pred_test)
# > pred_test
# >    1    2    3    4    5 
# >  171  113  201  146 9369
# 
# Finally, merge the clusters with the test data, and show the cluster categories assigned to each. For this demonstration, display two transactions for each cluster 
kw_with_cluster2_score <- as.data.frame(cbind(OnlineRetail.test, Cluster=pred_test))
head(kw_with_cluster2_score)
clust1.score=head(subset(kw_with_cluster2_score,Cluster==1),2)
clust2.score=head(subset(kw_with_cluster2_score,Cluster==2),2)
clust3.score=head(subset(kw_with_cluster2_score,Cluster==3),2)
clust4.score=head(subset(kw_with_cluster2_score,Cluster==4),2)
clust5.score=head(subset(kw_with_cluster2_score,Cluster==5),2)
head(clust1.score[,10:13])
head(clust2.score[,10:13])
head(clust3.score[,10:13])
head(clust4.score[,10:13])
head(clust5.score[,10:13])

# > head(clust1.score[,10:13])
# Desc2 lastword firstword Cluster
# 89  PackOf60PaisleyCakeCases    CASES      PACK       1
# 96 PackOf60DinosaurCakeCases    CASES      PACK       1
# > head(clust2.score[,10:13])
# Desc2 lastword firstword Cluster
# 61            WoodenFrameAntique             WOODEN       2
# 140 AntiqueGlassDressingTablePot      POT   ANTIQUE       2
# > head(clust3.score[,10:13])
# Desc2 lastword firstword Cluster
# 148 3TierCakeTinAndCream    CREAM         3       3
# 143 3TierCakeTinAndCream    CREAM         3       3
# > head(clust4.score[,10:13])
# Desc2 lastword firstword Cluster
# 126 ZincWillieWinkieCandleStick    STICK      ZINC       4
# 488              LoveBirdCandle   CANDLE      LOVE       4
# > head(clust5.score[,10:13])
# Desc2 lastword firstword Cluster
# 3      HangingHeartT-lightHolder   HOLDER   HANGING       5
# 7 KnittedUnionFlagHotWaterBottle   BOTTLE   KNITTED       5
# 
# Running the aprior algorithm on the clusters
# Circling back to the arules algorithm, we can use the predicted clusters which were generated, instead of "lastword" in order to develop some rules.
# .	We will use the "coerce to dataframe" method to generate the transaction file as previously generated
# .	Create a rules_clust algorithm which builds association rules based upon the itemset of clusters {1,2,3,4,5}
# .	Inspect some of the generated rules by lift.
library(arules)
colnames(kw_with_cluster2_score)
kable(head(kw_with_cluster2_score[,c(1,13)],5))
tmp <- data.frame(kw_with_cluster2_score[,1],kw_with_cluster2_score[,13])
names(tmp) [1] <- "TransactionID"
names(tmp) [2] <- "Items"
tmp <- unique(tmp)
trans4 <- as(split(tmp[,2], tmp[,1]), "transactions")
rules_clust <- apriori(trans4,parameter = list(minlen=2,support = 0.02,confidence = 0.01))
summary(rules_clust)
#RW new arules::inspect
tmp <- as.data.frame(arules::inspect( head(sort(rules_clust, by="lift"),10)))  

# > tmp <- as.data.frame(inspect( head(sort(rules_clust, by="lift"),10)    ) )
# lhs      rhs support    confidence lift    
# 22 {2,5} => {4} 0.03065693 0.3088235  3.022059
# 1  {2}   => {4} 0.03065693 0.3043478  2.978261
# 2  {4}   => {2} 0.03065693 0.3000000  2.978261
# 23 {4,5} => {2} 0.03065693 0.3000000  2.978261
# 32 {1,5} => {4} 0.02773723 0.2087912  2.043171
# 9  {4}   => {1} 0.02773723 0.2714286  2.020963
# 10 {1}   => {4} 0.02773723 0.2065217  2.020963
# 31 {4,5} => {1} 0.02773723 0.2714286  2.020963
# 35 {3,5} => {4} 0.03357664 0.1965812  1.923687
# 11 {4}   => {3} 0.03357664 0.3285714  1.891357
# Summarizing the metrics
# Running a summary on the rules_clust object indicates an average support of .05, and average confidence of .43
# This demonstrates that using clustering can be a viable way to develop association rules, and reduced resources and the number of dimensions at the same time.
# 
# support          confidence           lift      
# Min.   :0.02044   Min.   :0.09985   Min.   :0.989  
# 1st Qu.:0.02664   1st Qu.:0.19816   1st Qu.:1.006  
# Median :0.03066   Median :0.27143   Median :1.526  
# Mean   :0.05040   Mean   :0.43040   Mean   :1.608  
# 3rd Qu.:0.04234   3rd Qu.:0.81954   3rd Qu.:1.891  
# Max.   :0.17080   Max.   :1.00000   Max.   :3.022  
# 
# 
# Summary

