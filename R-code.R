rm(list = ls())
library(lattice)
library(ggplot2)
library(caret)
library(readxl)
library(ellipse)

library(tidyverse)
## Reading excel file in R ###
dataset <- EGFR_31
# create a list of 80% of the rows in the original dataset we can use for training
validation_index <- createDataPartition(dataset$response, p=0.80, list=FALSE)
validation <- dataset[-validation_index,]
# use the remaining 80% of data to training and testing the models
dataset <- dataset[validation_index,]
# dimensions of dataset
dim(dataset)
dataset$response <- as.factor(dataset$response)
sapply(dataset, class)
head(dataset)
levels(dataset[, 23])
levels(dataset$response)
percentage <- prop.table(table(dataset$response)) * 100
cbind(freq=table(dataset$response), percentage=percentage)
y1 <- dataset[,1:22]
x1 <- scale(y1, center = TRUE, scale = TRUE)
x <- x1[,1:22]
y <- dataset[,23]
for(i in 1:10) {
boxplot(x[,i], main=names(dataset)[i])
}
plot(y)

correlationMatrix <- cor(dataset[,1:22])
print(correlationMatrix)
plot(correlationMatrix)
# find attributes that are highly corrected (ideally >0.75)
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.5)
# print indexes of highly correlated attributes
print(highlyCorrelated)
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
# run the RFE algorithm


# Train an rpart model and compute variable importance.
library(caret)
set.seed(100)
rPartMod <- train(response ~ ., data=dataset, method="rpart")
rpartImp <- varImp(rPartMod)
print(rpartImp)

# Train an RRF model and compute variable importance.
set.seed(100)
rrfMod <- train(response ~ ., data=dataset, method="RRF")
rrfImp <- varImp(rrfMod, scale=F)

plot(rrfImp, top = 20, main='Variable Importance')

x_p <- cbind(dataset$Age_normalized, dataset$smoking, dataset$Sex)


featurePlot(x=x_p, y=dataset$response, plot="ellipse")
featurePlot(x=x_p, y=dataset$response, plot="box")
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x_p, y=dataset$response, plot="density", scales=scales)
#control <- trainControl(method="cv", number=10)
metric <- "Accuracy"
set.seed(7)
fit.lda <- train(response~., data=dataset, method="lda", metric=metric)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(response~., data=dataset, method="rpart", metric=metric)
# kNN
set.seed(7)
fit.knn <- train(response~., data=dataset, method="knn", metric=metric)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(response~., data=dataset, method="svmRadial", metric=metric)
# Random Forest
set.seed(7)
fit.rf <- train(response~., data=dataset, method="rf", metric=metric)
# summarize accuracy of models
results <- resamples(list(lda=fit.lda, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)
dotplot(results)
dev.off()
dotplot(results)
