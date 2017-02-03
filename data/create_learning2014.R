### DATA WRANGLING, WEEK 2
## EXERCISE 2
lrn14 = read.csv2(file='http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt',sep='\t',header=TRUE)
dim(lrn14)
head(lrn14)
summary(lrn14)
str(lrn14)
# Most of the data columns are ranged from 1-5.
# Female answer amount is 2 times the male answer amount.
# Age, attitude and points of answering people are also in the data set.

## EXERCISE 3
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)
lrn14$attitude <- lrn14$Attitude/10

# Choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
lrn14 <- select(lrn14,one_of(keep_columns))
lrn14 <- filter(lrn14,lrn14$Points > 0)

## EXERCISE 4
setwd('/Users/tjkarkka/Documents/Ohjelmointi/Data/IODS-project/data')
write.csv(lrn14,file='learning2014.csv')
test = read.csv('learning2014.csv')
dim(test)
