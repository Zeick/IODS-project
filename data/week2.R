### ANALYSIS, WEEK 2
## EXERCISE 1
#lrn14 = read.csv2(file="http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=',', header=TRUE)
lrn14 = read.csv('learning2014.csv')
dim(lrn14)
str(lrn14) # 7 variables and 166 persons who answered the questions

# The data records the age and gender of the people.
# Points: The exam point the people got (between 7 and 33)
# Deep/Stra/Surf: An average of 8-12 questions, each with 1-5 scale.
# They tell the preference of the student to deep, strategic or surface
# thinking.

## EXERCISE 2
library(GGally)
library(ggplot2)

summary(lrn14)
pairs(lrn14[-1],col=lrn14$gender) # It's hard to see anything from this

# Here's a more advanced plot matrix with ggpairs(), where you can see something
p <- ggpairs(lrn14, mapping = aes(col=gender,alpha=0.3), lower = list(combo = wrap("facethist", bins = 20)))
p

# Women have red color. Men have blue color. There are more women than men.
# Age of both men and women are approximately the same.
# The attitude appears to be slightly better with men.
# Deep learning is the same with men and women
# Strategic learning could be a little bit better with women, also
# surface lerning. The boxplots are at almost same position, so
# the difference appears to be negligible.
# Points are the same for both men and women.

## EXERCISE 3

# Regression model for Points with explanatory variables deep, stra and surf
my_model2 <- lm(Points ~ deep + stra + surf, data = lrn14)
summary(my_model2)

# According to summary of my model, the Student t-test suggests that the variables
# I chose (stra and surf) are significant, but not deep, since its t-value
# is by its magnitude almost the same as the standard error.
# I choose new explanatory variables: attitude, stra and surf

my_model2 <- lm(Points ~ attitude + stra + surf, data = lrn14)
summary(my_model2)

# Okay, new plan. I try only attitude, with the only super-siginificant role.

my_model2 <- lm(Points ~ attitude, data = lrn14)
summary(my_model2)

## EXERCISE 4
# I interpret the points are highly dependent on attitude, and only weakly
# dependent on the learning techniques.

# The linear model is like this:
# Points = 3.53*attitude + 11.64
# This is how we can estimate what the test score of any student is, if
# we know his or her attitude.
# The R-squared is 0.19, which is low, which means that the data points
# are scattered quite far away from the estimation line and the fit
# is poor. However there appears to be a weak correlation.

## EXERCISE 5
par(mfrow = c(2,2))
plot(my_model2,which=(c(1,2,5)))

# Residuals VS Fitted supports my theory that Points are fitted
# okayish with attitude-curve. There are approximately some amount of
# data point both up and down half-planes with respect to the fit line.
# However it is easily seen that many point lie far from the fit line.

# Normal Q-Q supports the assumption that the errors are distributed
# along the Gaussian normal distribution, since almost all the points
# apperar to follow a straight line.

# Residuals VS Leverage plot is good, since there appears not to be
# significant outliers in the data which would have unreasanobly large
# leverage on the fitting of the model.


