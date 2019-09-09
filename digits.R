
##LOAD
library(graphics)
library(imager)
library(caret)
setwd("~/digits")
train<-read.csv("data/train.csv", header = TRUE, sep = ",")
test<-read.csv("data/test.csv", header = TRUE, sep = ",")
t1<-train[1,2:785] #Skip the label load first image
t2<-matrix(0,nrow=28,ncol=28) #the matrix for the image function

sample_size <- 100

t2<-matrix(unlist(t1),nrow=28,ncol=28) # same thing as loop

##DRAW
image(t2,col=grey.colors(255,start=0,end=1))

#Now bring in the sample size number, not just 1
t1<-train[1:9,2:785] #Skip the label load first image
t2<-list()
for(k in c(1:sample_size)) {
  t2[[k]]<-matrix(unlist(t1[k,]),nrow=28,ncol=28) # same thing as loop
  }

#Now make one big image
t1<-train[1:sample_size,2:785] #Skip the label load first image
t2<-matrix(unlist(t1),nrow=28,ncol=28*sample_size) # same thing as loop

#use parallel processing
library(parallel)
library(doParallel)
cluster <- makeCluster(detectCores() - 1) # convention to leave 1 core for OS
registerDoParallel(cluster)


#Now try random forest on a small sample size
sample_size<-200
t1<-train[1:sample_size,] #Skip the label load first image
t2<-train[sample_size:1100,] #get a small test set
t1$label<-as.factor(t1$label)
t2$label<-as.factor(t2$label)
pred<-train(label~.,method="rf",data=t1)
predictions<-predict(pred,newdata=t2)
t3<-t2$label
cmRF<-confusionMatrix(t3,predictions)
cmRF #for example 100 samples is 64% right, but even 200 takes a while but its 77.4% right


##Main 
main() <- function() {
  load_data();
  draw_data();
}

#Data Load Status
output$numbers <- renderPlot({
  if(data_loaded == FALSE){
    rect(0,0,100,100, border="red", col = "blue") #blue is not loaded
    text(0,0, "Not Loaded")
  }
  
  if(data_loaded == TRUE) {
    rect(0,0,100,100, border="blue", col = "red") #red is loaded
    text(0,0, "Loaded")
    data_loaded=2
  }
  image(t2,col=grey.colors(255,start=0,end=1))
})

output$samples <- renderText({
  sample_size_reactor()
})

