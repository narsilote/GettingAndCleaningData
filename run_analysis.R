
#1 Merges the training and the test sets to create one data set.

dirs <- c ("test", "train")
files <- c("subject", "y", "X")
data <- do.call(rbind, lapply(dirs, function(x)
  {
  filenames <- paste("UCI HAR Dataset/", x, "/", files, "_", x, ".txt", sep="")
  do.call(cbind, lapply(filenames, function(x) {read.table(x)}))
  }))
rm(dirs, files)

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
data <- data[, c(1, 2, grep("mean\\(\\)|std\\(\\)", features$V2) + 2)]

#3 Uses descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
data[,2] <- activities[data[,2],2]
rm(activities)

#4 Appropriately labels the data set with descriptive variable names. 

names(data) <- c("subject", "activity", features[grep("mean\\(\\)|std\\(\\)", features$V2),2])
rm(features)

#5 From the data set in step 4, creates a second, independent tidy data set with the 
#  average of each variable for each activity and each subject.
groups <- expand.grid(unique(data$subject), unique(data$activity), stringsAsFactors = FALSE)
names(groups) <- c("subject", "activity")
tidydata <- cbind(groups, do.call(rbind, mapply(function(x, y)
  { colMeans(data[data$subject == x & data$activity == y, 3:length(data)]) }, 
  groups$subject, groups$activity, SIMPLIFY = FALSE)))
rm(groups)
