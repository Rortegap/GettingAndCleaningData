
##Training and test file reading
train = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train[,ncol(train)+1] <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
train[,ncol(train)+1]  <-  read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

test = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test[,ncol(test)+1] <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test[,ncol(test)+1] <-  read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

###Read features

features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] <-  gsub('[-()]', '', features[,2])

##Subset features by the variables we want to check 

colAnalysis <- grep(".*Mean.*|.*Std.*", features[,2])

#Restraint features variables
features<-features[colAnalysis,]


# Add two columns for subject and activity
colAnalysis <- c(colAnalysis, 562, 563)

## activityLabels reading
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

dataset <- rbind(train, test)

#Select the columns for the analysis 
dataset<-dataset[,colAnalysis]

# Add the column names (features) to dataset
colnames(dataset) <- c(features$V2, "Activity", "Subject")

#Change the code of the activity by the label of the activity
currentActivity = 1
for (currentActivityLabel in activityLabels$V2) {
  dataset$Activity <- gsub(currentActivity, currentActivityLabel, dataset$Activity)
  currentActivity <- currentActivity + 1
}

dataset$Activity <- as.factor(dataset$Activity)
dataset$Subject <- as.factor(dataset$Subject)

tidy = aggregate(dataset, by=list(Activity = dataset$Activity, Subject=dataset$Subject), mean)
# Remove two last columnns
#
tidy[,90] = NULL
tidy[,89] = NULL

write.table(tidy, "tidy.txt", sep="\t",row.name=FALSE)
