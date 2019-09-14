library(e1071)
library(png)

#Set my personal working directory
setwd("./GitHub/digits/")

train <- read.csv("train.csv")

train$label <- as.factor(train$label)

set.seed(859)
number_training_samples = 500 #Select the training indices
number_testing_samples = 32 * 32 #For testing limit the work to be done, try to keep under 42000 total
rows <- seq_len(nrow(train))

training_rows <- sample(rows, size = number_training_samples)
#remove training rows from rows
rows<-rows[-training_rows]
#select the testing rows
testing_rows <- sample(rows, size = number_testing_samples)
#remove the testing rows
rows<-rows[-testing_rows]

training <- train[training_rows, ] #training data set
testing <- train[testing_rows, ] #testing data 


## Add an alpha value to a colour
add.alpha <- function(col, alpha=1){
  if(missing(col))
    stop("Please provide a vector of colours.")
  apply(sapply(col, col2rgb)/255, 2, 
        function(x) 
          rgb(x[1], x[2], x[3], alpha=alpha))  
}

#The basic colors
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

#organize the colors into a vector
color_names  <- c(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10)
color_names <- as.character(color_names)

library(parallel)
library(doParallel)
cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)

library(parallelSVM)
#create the prediction model and run it on the remaining elements in the test set
svm_model <- parallelSVM(label ~ ., training,scale=FALSE,method = "C-classification", kernel = "polynomial", degree=2, numberCores = detectCores())
svm_prediction <- predict(svm_model, newdata=testing[,-1])

#Create a confusion matrix
confusion_matrix <- table(svm_prediction,testing$label)
confusion_matrix

#add a column for the svm prediction to the testing data 
train2_class <- cbind(testing,svm_prediction)
train2_class <- train2_class[order(train2_class$svm_prediction),]

#Make the digits 28x28 image matrix into a data frame for output to graphics files
training_image_matrix <- data.frame(matrix(0,nrow=28,ncol=28))

png("digit_1024.png", units="px", width=4800, height=4800, res=32)
par(mfrow=c(32,32))

for(r in 1:nrow(testing)){
  #skip the first column which has the label
  c <- 2
  plot(1,1,asp = 1,pch=20,cex=0,xlim=c(1,28),ylim=c(1,28),xaxt="n",yaxt="n",xlab="",ylab="",bty ="n",axes=F,frame.plot=F)
  for(i in 1:28){
    for(j in 1:28){
      #fill in each pixel
      pixel_value<-testing[r,c]#pixel value
      training_image_matrix[i,j] <- pixel_value
      #color for the number from the color names index
      color <- color_names[as.numeric(testing[r,1])]
      points(i,j,pch=15,
             cex=3,
             col=add.alpha(color,alpha=(pixel_value/255)),
             xaxt="n",yaxt="n",
             xlab="",ylab="",
             bty ="n",axes=F,
             frame.plot=F)
      c <- c+1 #advance to next pixel
    }
  }
}
dev.off ()

training_image_matrix <- data.frame(matrix(0,nrow=28,ncol=28))

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
      training_image_matrix[i,j] <- train2_class[r,c]
      points(i,j,pch=15,cex=3,col=add.alpha(color_names[as.numeric(train2_class[r,1])],alpha=(training_image_matrix[i,j]/255)),xaxt="n",yaxt="n",xlab="",ylab="",bty  
             ="n",axes=F,frame.plot=F)
      c <- c+1
    }
  }
}
dev.off ()
#

