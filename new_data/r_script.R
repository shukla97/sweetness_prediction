# loading libraries 
library(glmnet)
library(caTools)
set.seed(100)

# Reading data
sp <- read.csv("C:/Users/Shubham Shukla/Desktop/internship/new/sweetness_prediction/ecfp.csv")
sp1 <- read.csv("C:/Users/Shubham Shukla/Desktop/internship/new/sweetness_prediction/new_data/ecfp_new.csv")

# Train data using sp and test data using sp1
train <- subset(sp, select = -c(smiles))
test <- subset(sp1, select = -c(smiles))

#converting train data into matrix
train_x <- model.matrix(Sweetness ~. -1, data = train)
train_y <- log10(train$Sweetness)

# Converting test data into matrix
test_x <- model.matrix(logSw ~.-1, data = test)
test_y <- sp1$logSw

# Using cv in lasso to choose model
cv.lasso <- cv.glmnet(train_x, train_y, alpha = 1, nlambda= 100)

#Developing model using best cv value
fit <- glmnet(train_x,train_y, alpha = 1, lambda = cv.lasso$lambda.1se)
fit

#Predicting using sp1 datset
log.predict <- predict(fit,test_x)

#Calculating R_square 
sse <- sum((test_y - log.predict)^2)
sst <- sum((test_y - mean(test_y))^2)
1 - (sse/sst)