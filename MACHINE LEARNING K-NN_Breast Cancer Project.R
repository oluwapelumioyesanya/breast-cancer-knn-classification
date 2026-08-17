data<-read.csv("C:\\Users\\USER\\Documents\\cancer.csv", stringsAsFactors = FALSE)
data

View(data)
str(data)
summary(data) #STATISTICAL SUMMARY

data<-data[-1]  #to remove the first variable which is not useful(id)
data
View(data)

library(class)
#DIAGNOSIS: M(malignant; which is cancerous) AND B(belign; tumorous but not cancerous)
#To check for the number of patients classified under M(malignant) and B(benign)
table(data$diagnosis)
data$diagnosis<- factor(data$diagnosis, levels=c("B", "M"), labels=c("Benign", "Malignant"))
data$diagnosis
table(data$diagnosis)

#proportion of M and B; percentage of M and B
round(prop.table(table(data$diagnosis))*100, digits = 1)
summary(data[c("radius_mean", "area_mean", "smoothness_mean")])

#NORMALIZE THE DATA
#create a normalize() function

normalise<-function(x){
  return((x-min(x))/(max(x)-min(x)))
}

#Test normalize
normalise(c(1,2,3,4,5))

data_n<-as.data.frame(lapply(data[2:31], normalise))
data_n
summary(data_n[c("radius_mean", "area_mean", "smoothness_mean")])

#creating training and test datasets
data_train<-data_n[1:469, ]
data_test<-data_n[470:569, ]

#creating labels for training and test datasets
data_train_labels<-data[1:469, 1]
data_test_labels<-data[470:569, 1]

data_train_labels
data_test_labels

#TRAINING A MODEL ON THE DATA
#Training in the KNN involves storing the input data in a structured format.
#To classify our test instances, we will use a KNN implementation from the class package

data_test_pred<-knn(train=data_train, test=data_test, cl=data_train_labels, k=21)
data_test_pred

#Evaluating model performance
#install.packages("gmodels")
library(gmodels)

#create a cross-tabulation
CrossTable(x=data_test_labels, y=data_test_pred, prop.chisq =FALSE)

#IMPROVING MODEL PERFORMANCE (the model failed so we go on to improve on the data)
#Transformation - using Z-score standardization to re-scale features

data$X <- NULL
data_z<-as.data.frame(scale(data[-1]))

#summary statistics to confirm transformation
summary(data_z$area_mean)

#creating training and test datasets
data_train<-data_z[1:469, ]
data_test<-data_z[470:569, ]

#creating labels for training and test datasets
data_train_labels<-data[1:469, 1]
data_test_labels<-data[470:569, 1]


#CLASSIFICATION (error)
data_test_pred<-knn(train=data_train, test=data_test,cl=data_train_labels,k=21)
data_test_pred

#create a cross-tabulation
CrossTable(x=data_test_labels, y=data_test_pred, prop.chisq = FALSE)

#using normalised data and adjusting k-value
data_test_pred<-knn(train=data_train,test=data_test,cl=data_train_labels, k=5)
data_test_pred

CrossTable(x=data_test_labels,y=data_test_pred, prop.chisq = FALSE)

data_test_pred<-knn(train=data_train, test=data_test, cl=data_train_labels, k=30)
data_test_pred
CrossTable(x=data_test_labels, y=data_test_pred, prop.chisq = FALSE)



