
##import features
features <- read.table("./features.txt")

##import training data
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

##import test data
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

##question 1 
##Merges the training and the test sets to create one data set.
## "data"_global the merged files (train+test)

X_global <- rbind(X_train,X_test)
Y_global<- rbind(Y_train,Y_test) 
subject_global<-rbind(subject_train,subject_test) 
##  I add the names to the columns
names(X_global)<-features[,2]
names(Y_global)<-"Activity"
names(subject_global)<-"Subject_ID"
## then I merge the three data.frame into one dataframe
data_global<-cbind(X_global,Y_global,subject_global)


## question 2
## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
##We create a vector containing the indexes of the variables containinng mean or STD
mean_indices<-grep("mean",names(data_global),ignore.case=TRUE)
std_indices<-grep("std",names(data_global),ignore.case=TRUE)

##we take thhe union of these two vectors
mean_std_indices <-union(mean_indices,std_indices)

##We subset X_global with indices in mean_std_indices and add the subject and activity columns
mean_std <- cbind(data_global[,mean_std_indices],Y_global,subject_global)


# question 3
##Uses descriptive activity names to name the activities in the data set
activity_labels <- data.frame(seq(1:6),c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
names(activity_labels)<-c("num_ID","labels")
## "for boucle" for eache activitty category
mean_std$Activity <- as.character(mean_std$Activity)
for (i in 1:6){
mean_std$Activity[mean_std$Activity==i]<-as.character(activity_labels[i,2])  
}
mean_std$Activity <- as.factor(mean_std$Activity)

##saving the file
##write.table(mean_std, file = "Question4.txt", row.names = FALSE)


# question 4
##Appropriately labels the data set with descriptive variable names. 
## first replace "t" with "time" anf "f" with "frequency"
names(mean_std)<-gsub("^t", "Time", names(mean_std))
names(mean_std)<-gsub("^f", "Frequency", names(mean_std))

## then acc-> accelerometer, gyro -> gyroscope, bodybody -> body , mag -> magnitude
names(mean_std)<-gsub("Acc", "Accelerometer", names(mean_std))
names(mean_std)<-gsub("Gyro", "Gyroscope", names(mean_std))
names(mean_std)<-gsub("BodyBody", "Body", names(mean_std))
names(mean_std)<-gsub("Mag", "Magnitude", names(mean_std))


##question 4
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##new data.frame :agg_mean_std
mean_std$Subject_ID <- as.factor(mean_std$Subject_ID)
agg_mean_std <-aggregate(. ~Subject_ID + Activity,data=mean_std,FUN=mean, na.rm=TRUE)
agg_mean_std <-agg_mean_std[order(agg_mean_std$Subject_ID,agg_mean_std$Activity),]


##saving the file
write.table(agg_mean_std, file = "Question5.txt", row.names = FALSE)