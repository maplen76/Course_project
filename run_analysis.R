#download the file
u <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url = u)

#unzip the file
zipPath <- "D:/R/getdata_projectfiles_UCI HAR Dataset.zip"
unzip(zipfile = zipPath)

#reading features
features <- read.table(file = "UCI HAR Dataset/features.txt")
activity <- read.table(file = "UCI HAR Dataset/activity_labels.txt")
names(activity) <- c("activity_label", "activity_name")

#reading training data
#reading Each row identifies the subject who performed the activity for each window sample
#Its range is from 1 to 30
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "subject"
#reading Training set
X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
names(X_train) <- features[,2]
#reading Training labels
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
names(y_train) <- "activity_label"
y_train$id <- 1:nrow(x = y_train)
#3.Uses descriptive activity names to name the activities in the data set
y_train <- merge(y_train, activity)
y_train <- y_train[order(y_train$id),c(1,3)]

#define a new variable to identify the trainning data
group_train <- data.frame(group = rep("train", nrow(X_train)))
train <- cbind(group_train, subject_train, y_train, X_train)

#reading test data
#reading Each row identifies the subject who performed the activity for each window sample
#Its range is from 1 to 30
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subject"
#reading Training set
X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
names(X_test) <- features[,2]
#reading Training labels
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
names(y_test) <- "activity_label"
y_test$id <- 1:nrow(x = y_test)
# 3.Uses descriptive activity names to name the activities in the data set
y_test <- merge(y_test, activity)
y_test <- y_test[order(y_test$id),c(1,3)]

group_test <- data.frame(group = rep("test", nrow(X_test)))
test <- cbind(group_test, subject_test, y_test, X_test)
# 1.Merges the training and the test sets to create one data set
tt <- rbind.data.frame(train, test)
temp <- names(tt)
write.table(x = tt, file = "Human_Activity_Recognition.txt", sep="\t", row.names = FALSE)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
mean_m <- grep(pattern = ".mean\\(\\).", temp)
std_m <- grep(pattern = ".std\\(\\).", temp)
ms <- tt[,c(1, 2, 3, 4, mean_m, std_m)]

#5.From the data set in step 4, creates a second,
#independent tidy data set with the average of each variable for each activity and each subject.
install.packages("reshape2")
library(reshape2)

ms_names <- names(ms)
msMelt <- melt(ms, id = ms_names[1:4], measure.vars = ms_names[c(-1, -2, -3, -4)])
secData <- dcast(msMelt, activity_name + subject ~ variable, mean)