rm(df)
df <- read.table(text = 'Treatment	Gender	Age	Duration	Pain 
                 P	F	68	1	0
                 P	M	66	26	1
                 A	F	71	12	0
                 A	M	71	17	1
                 B	F	66	12	0
                 A	F	64	17	0
                 P	M	70	1	1
                 A	F	64	30	0
                 B	F	78	1	0
                 B	M	75	30	1
                 A	M	70	12	0
                 B	M	70	1	0
                 P	M	78	12	1
                 P	M	66	4	1
                 A	M	78	15	1
                 P	F	72	27	0
                 B	F	65	7	0
                 P	M	67	17	1
                 P	F	67	1	1
                 A	F	74	1	0
                 B	M	74	16	0
                 B	F	67	28	0
                 B	F	72	50	0
                 A	F	63	27	0
                 A	M	62	42	0
                 P	M	74	4	0
                 B	M	66	19	0
                 A	M	70	28	0
                 P	M	83	1	1
                 P	M	77	29	1
                 A	F	69	12	0
                 B	M	67	23	0
                 B	M	77	1	1
                 P	F	65	29	0
                 B	M	75	21	1
                 P	F	70	13	1
                 P	F	68	27	1
                 B	M	70	22	0
                 A	M	67	10	0
                 B	M	80	21	1
                 P	F	67	30	0
                 B	F	77	16	0
                 B	F	76	9	1
                 A	F	69	18	1
                 P	F	64	1	1
                 A	F	72	25	0
                 B	M	59	29	0
                 A	M	69	1	0
                 B	F	69	42	0
                 P	F	79	20	1
                 B	F	65	14	0
                 A	M	76	25	1
                 B	F	69	24	0
                 P	M	60	26	1
                 A	F	67	11	0
                 A	M	75	6	1
                 P	M	68	11	1
                 A	M	65	15	0
                 P	F	72	11	1
                 A	F	69	3	0',header = TRUE)

str(df)
table(df$Pain)
prop.table(table(df$Pain))
setwd("C:/PracticalPredictiveAnalytics/Data")
save(df,file="pain_raw.Rda")


PainGLM <- glm(Pain ~ Treatment + Gender + Age + Duration, data=df, family="binomial")

summary(PainGLM)
cbind(exp(coef(PainGLM)),confint(PainGLM))

quantile(residuals(PainGLM, type="deviance")) # residuals

mean(residuals(PainGLM, type="deviance"))
plot(residuals(PainGLM, type="deviance"))

#install.packages("car")
library(car)
avPlots(PainGLM, id.method="mahal", id.n=2)

df[c(26,27,28,25),]

set.seed(1020)
lottery <- data.frame(
  cbind(x=rnorm(n=1000000,1000000,100),y=rnorm(1000000,1000001,100)  )
)
summary(lottery)

t.test(lottery$x,lottery$y)


set.seed(1020)
lottery <- data.frame(
  cbind(x=rnorm(n=100000,1000000,100),y=rnorm(n=100000,1000001,100)  )
)
summary(lottery)
t.test(lottery$x,lottery$y)

library(RcmdrMisc)

stepwise(PainGLM, direction='forward/backward', criterion='AIC')


library(effects)
output <- glm(Pain ~ Treatment + Gender + Age + Duration + Age:Treatment
              ,data=df, family="binomial")
summary(output)

install.package(effects)
library(effects)
output <- glm(Pain ~ Treatment + Gender + Age + Duration + Age:Treatment , data=df, family="binomial")
summary(output)

plot(effect("Treatment*Age", output, xlevels=list(age=0:99)),
     ticks=list(at=c(.001, .005, .01, .05, seq(.1,.9,by=.2), .95, .99, .995))) 

install.packages("pscl")

library(pscl)
pR2(PainGLM)



oldpar <- par(oma=c(0,0,3,0), mfrow=c(2,2))
plot(PainGLM)
par(oldpar)


library(TeachingDemos)
set.seed(1)
if(interactive()) {vis.test(residuals(PainGLM, type="response"), vt.qqnorm, nrow=4, ncol=4, npage=1)}

install.packages("ResourceSelection")
library(ResourceSelection)
hoslem.test(PainGLM$y,fitted(PainGLM))
str(hoslem$observed)
hoslem <- hoslem.test(PainGLM$y,fitted(PainGLM))
cbind(hoslem$observed,hoslem$expected)

dummy.vars <- model.matrix(df$Pain ~ df$Treatment + df$Gender + df$Age + df$Duration)[,-1]
x <- as.matrix(data.frame(df$Duration,dummy.vars))
head(x)


install.packages("glmnet")
library(glmnet)
options(scipen = 999)
mod.result<-glmnet(x,y=as.factor(df$Pain),alpha=1,family='binomial')
summary(mod.result$lambda)

plot(mod.result,xvar="lambda")


head(print(mod.result)) 
tail(print(mod.result))


coef(mod.result,s=0.1957000)   #  4 of 5 coefficient are at 0, too much shrinkage
coef(mod.result,s=0.0131800)   #  only 1 coefficient is set to 0

coef(mod.result,s=0.0120100)   #   All coefficients are included 

coef(mod.result,s=0.01)


statedf <- as.data.frame(state.x77)
x <- data.frame(statedf,state.abb,state.region)
summary(x)

hist(x$Life.Exp)

install.packages("rpart")
install.packages("rattle")					 
install.packages("rpart.plot")				 
install.packages("RColorBrewer")				 

library(rpart)
library(rattle)					 
library(rpart.plot)				 
library(RColorBrewer)				 
set.seed(1020)
y1 <- rpart(Life.Exp ~ .,data=x,cp=.01)
prp(y1, type=4, extra=1) 


print(y1)


y2 <- rpart(Life.Exp ~ Population + Income + Illiteracy +
              Murder +
              HS.Grad +
              Frost +
              Area +
              state.region,method='anova',data=x
)

prp(y2, type=4, extra=1)

install.packages("partykit")
library(partykit)
y2 <- ctree(Life.Exp ~ .,data=x)
y2
plot(y2)

PrunedTree <- prp(y1,type=4, extra=1,snip=TRUE)$obj 

prp(PrunedTree, type=4, extra=1)


library(graphics)
library(dplyr)

x <- read.table("C:/PracticalPredictiveAnalytics/Data/CDNOW_master.txt", quote="\"", stringsAsFactors=FALSE)

x$xd <- as.Date(as.character(x$V2), "%Y%m%d")
x$diffdate <- as.integer(as.Date("1998-07-01")  - x$xd)
#rename the columns

colnames(x) <- c("id","orig.date","units.bought","TotalPaid","purch.date","Days.since")
str(x)
summary(x)

attach(x)
#cluster on the RFM variables
y <- subset(x, select = c(units.bought,TotalPaid,Days.since))

#always set seed before clustering

set.seed(1020)

clust3 <- kmeans( y,3)
clust3$betweenss/clust3$totss


clust5 <- kmeans( y,5)
clust5$betweenss/clust5$totss

clust7 <- kmeans( y,7)
clust7$betweenss/clust7$totss

#elbow method
set.seed(1020)
# Compute and plot wss for k = 3 to k = 15
df <- sapply(3:15,function(k){kmeans(y,k)$tot.withinss})

plot(3:15, df,type='b',xlab="# of clusters",ylab="Total Within Clusters SS")

#cluster assignments
clusters3 <- clust3$cluster
clusters5 <- clust5$cluster
clusters7 <- clust7$cluster

#usually but now always the middle cluster is the average cluster
par(mfrow=c(1,3))
hist(clusters3)
hist(clusters5)
hist(clusters7)

#append the clusters the original data
append.clust <- data.frame(x, clusters3,clusters5,clusters7)

install.packages("cluster")
library(cluster) 
set.seed(1020)
sampleit <- append.clust[sample(nrow(append.clust), 100), ]
str(sampleit)

prcomp(append.clust[,c(3,4,6)], scale = TRUE)
par(mfrow=c(1,3))
clusplot(sampleit[,c(3,4,6)], sampleit$clusters3, color=TRUE, shade=TRUE,labels=2, lines=0)
clusplot(sampleit[,c(3,4,6)], sampleit$clusters5, color=TRUE, shade=TRUE,labels=2, lines=0)
clusplot(sampleit[,c(3,4,6)], sampleit$clusters7, color=TRUE, shade=TRUE,labels=2, lines=0)

head(append.clust)
library(dplyr)
attach(append.clust)
append.clust %>% select(units.bought,TotalPaid,Days.since,clusters3) %>% 
  group_by(clusters3) %>% 
  summarise_each(funs(n(),mean))
append.clust %>% select(units.bought,TotalPaid,Days.since,clusters5) %>% 
  group_by(clusters5) %>% 
  summarise_each(funs(n(),mean))
append.clust %>% select(units.bought,TotalPaid,Days.since,clusters7) %>% 
  group_by(clusters7) %>% 
  summarise_each(funs(n(),mean))


require(graphics)
setwd("C:/PracticalPredictiveAnalytics/Data")
load("pain_raw.Rda")

df2 <- subset(df, select=c(Age,Duration,Pain))
df2 <- scale(df2)  
head(df2)
fit <- hclust(dist(df2), "average")

groups <- cutree(fit, k=3) 
rect.hclust(fit, k=3, border="red")
cluster1 <- df[c(35,52,10,30),]
View(cluster1)

cluster2 <- df[c(23,49,25,47),]

View(cluster2)

cluster3 <- df[c(20,26,38,53),]
View(cluster3)


#generate a non-linear circle of point

radius <- 2
t2 <- data.frame(x=radius * cos(seq(0,6,length = 20)),y = radius * sin(seq(0, 6, length = 20)))
names(t2) <- c("Latitude","High.Low.Temp")
plot(t2$Latitude,t2$High.Low.Temp)

# create a new variable and plot it against on the original points

t2$z = (t2$Latitude^2*t2$High.Low.Temp^2)

plot(t2$High.Low.Temp,t2$z)


install.packages("e1071")
install.packages("RTextTools")

library(e1071)
library(RTextTools)
data <- read.csv("C:/PracticalPredictiveAnalytics/Data/Consumer_Complaints.csv", sep=",")



data <- subset(data, select=c(Issue,Consumer.complaint.narrative))
data.samp <- subset(data[1:50,], select=c(Issue,Consumer.complaint.narrative))
str(data)
View(data.samp)


# Create the document term matrix
dtMatrix <- create_matrix(data.samp["Consumer.complaint.narrative"],minDocFreq = 1, removeNumbers=TRUE, 
                          minWordLength=4,removeStopwords=TRUE,removePunctuation=TRUE,stemWords = FALSE)


xx = as.data.frame( t(as.matrix(  dtMatrix )) ) 
head(xx)


dtMatrix <- create_matrix(data["Consumer.complaint.narrative"],minDocFreq = 1, removeNumbers=TRUE, 
                          minWordLength=4,removeStopwords=TRUE,removePunctuation=TRUE,stemWords = FALSE)


freq <- colSums(as.matrix(dtMatrix))   
length(freq) 
head(freq)
freq.df <- as.data.frame(freq)
View(freq.df)

container <- create_container(dtMatrix, data$Issue, trainSize=1:500,virgin=FALSE) 
str(container)


# train a SVM Model
model <- train_model(container, "SVM", kernel="linear", cost=1)
str(model)
head(model)
summary(model)


predictionData <- data$Consumer.complaint.narrative[501:1000] 

# create a prediction document term matrix 
predMatrix <- create_matrix(predictionData, originalMatrix=dtMatrix) 

# create the corresponding container

plength = length(predictionData);
predictionContainer <- create_container(predMatrix, labels=rep(0,plength), testSize=1:plength, virgin=FALSE) 


# predict
results <- classify_model(predictionContainer, model)
head(results)
aggregate(results$SVM_PROB, by=list(results$SVM_LABEL), FUN=mean, na.rm=TRUE)


