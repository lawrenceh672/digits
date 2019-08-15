
##LOAD
setwd("~/digits")
train<-read.csv("train.csv", header = TRUE, sep = ",")
library(imager)
plot(table(t1[,2]), type = "p", col = "red")
t1<-train[1,2:785] #Skip the label
t2<-matrix(0,nrow=28,ncol=28)
for(i in c(1:27)) {
  for(j in c(1:28)) {
    t2[i,j]<-as.numeric(t1[1,i*28+j])
  }
}

##DRAW
m<-matrix(sample(0:255,replace=F), nrow = 28, ncol = 28)
image(m,col=grey.colors(255,start=0,end=1))
image(t2,col=grey.colors(255,start=0,end=1))

##Main 
main() <- function() {
  load_data();
  draw_data();
}

#Data Load Status
