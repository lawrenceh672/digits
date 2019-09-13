library(e1071)
library(png)

#Set my personal working directory
setwd("./GitHub/digits/")

train <- read.csv("train.csv")

train$label <- as.factor(train$label)

set.seed(0)
train_ind <- sample(seq_len(nrow(train)), size = 40976)

train1 <- train[train_ind, ]
train2 <- train[-train_ind, ]


## Add an alpha value to a colour
add.alpha <- function(col, alpha=1){
  if(missing(col))
    stop("Please provide a vector of colours.")
  apply(sapply(col, col2rgb)/255, 2, 
        function(x) 
          rgb(x[1], x[2], x[3], alpha=alpha))  
}


c1 <- "black"
c2 <- "gold1"
c3 <- "limegreen"
c4 <- "hotpink"
c5 <- "tomato"
c6 <- "darkorchid2"
c7 <- "cornflowerblue"
c8 <- "grey"
c9 <- "cyan"
c10 <- "lightskyblue"

kaggle_blue <- c("#20BDFB")

col1  <- c(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10)
col1_name <- as.character(col1)

library(parallel)
library(doParallel)
cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)

library(parallelSVM)
svm_model <- parallelSVM(label ~ ., train1[1:20000,],scale=FALSE,method = "C-classification", kernel = "polynomial", degree=2, numberCores = detectCores())
# svm on 20000 record due to memory constraint

svm_prediction <- predict(svm_model, newdata=train2[,-1])
xtab2 <- table(svm_prediction,train2$label)
xtab2
train2_class <- cbind(train2,svm_prediction)
train2_class <- train2_class[order(train2_class$svm_prediction),]

dig_train <- data.frame(matrix(0,nrow=28,ncol=28))

png("digit_1024.png", units="px", width=4800, height=4800, res=32)
par(mfrow=c(32,32))

for(r in 1:nrow(train2)){
  c <- 2
  plot(1,1,asp = 1,pch=20,cex=0,xlim=c(1,28),ylim=c(1,28),xaxt="n",yaxt="n",xlab="",ylab="",bty ="n",axes=F,frame.plot=F)
  for(i in 1:28){
    for(j in 1:28){
      dig_train[i,j] <- train2[r,c]
      points(i,j,pch=15,cex=3,col=add.alpha(col1_name[as.numeric(train2[r,1])],alpha=(dig_train[i,j]/255)),xaxt="n",yaxt="n",xlab="",ylab="",bty ="n",axes=F,frame.plot=F)
      c <- c+1
    }
  }
}
dev.off ()
#

dig_train <- data.frame(matrix(0,nrow=28,ncol=28))

png("digit_1024_class.png", units="px", width=4800, height=4800, res=32)
par(mfrow=c(32,32))

for(r in 1:nrow(train2_class)){
  c <- 2
  
  if(train2_class[r,1] == train2_class[r,786]){
    plot(1,1,asp = 1,pch=20,cex=0,xlim=c(1,28),ylim=c(1,28),xaxt="n",yaxt="n",xlab="",ylab="",bty ="n",axes=F,frame.plot=F)
  }
  else{
    plot(1,1,asp = 1,pch=20,cex=0,xlim=c(1,28),ylim=c(1,28),xaxt="n",yaxt="n",xlab="",ylab="",bty ="o",fg=kaggle_blue,axes=F,frame.plot=T)
  }
  
  
  for(i in 1:28){
    for(j in 1:28){
      dig_train[i,j] <- train2_class[r,c]
      points(i,j,pch=15,cex=3,col=add.alpha(col1_name[as.numeric(train2_class[r,1])],alpha=(dig_train[i,j]/255)),xaxt="n",yaxt="n",xlab="",ylab="",bty  
             ="n",axes=F,frame.plot=F)
      c <- c+1
    }
  }
}
dev.off ()
#

