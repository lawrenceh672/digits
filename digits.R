
##LOAD
library(graphics)
setwd("~/digits")
train<-read.csv("train.csv", header = TRUE, sep = ",")
library(imager)
t1<-train[1,2:785] #Skip the label load first image
t2<-matrix(0,nrow=28,ncol=28) #the matrix for the image function

for(i in c(1:27)) { #Fill in the matrix with those numbers
  for(j in c(1:28)) {
    t2[i,j]<-as.numeric(t1[1,i*28+j])
  }
}

##DRAW
image(t2,col=grey.colors(255,start=0,end=1))

##Draw green square
rect(0,0,100,100, density = 100, border="green", col = "green")

##Main 
main() <- function() {
  load_data();
  draw_data();
}

#Data Load Status
