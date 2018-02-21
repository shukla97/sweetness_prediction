library(glmnet)
library(caTools)
set.seed(100)

split <- sample.split(new_sp$logSw , SplitRatio = 0.75)
train <- subset(new_sp, split ==T)
test <- subset(new_sp, split == F)

train_x <- model.matrix(logSw ~.-1, data = train)
train_y <- train$logSw

test_x <- model.matrix(logSw ~. -1, data = test)
test_y <- test$logSw

cv.lasso <- cv.glmnet(train_x, train_y, alpha = 1, nlambda = 100)
fit <- glmnet(train_x, train_y, alpha = 1, lambda = cv.lasso$lambda.1se)

model.predict <- predict(fit, newx = test_x)


sse <- sum((model.predict - test_y)^2)
sst <- sum((test_y - mean(train_y))^2)
1 -sse/sst
