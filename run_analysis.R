# What this script does? 
#
# - Merges the training and the test sets to create one data set.
# - Extracts only the measurements on the mean and standard deviation for each measurement. 
# - Uses descriptive activity names to name the activities in the data set
# - Appropriately labels the data set with descriptive activity names. 
# - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(data.table)

# Returns only the measurements names that contains 'mean' and 'std' 
get_measurements <- function (fileName) {
    data <- read.table(fileName, col.names = list("ID", "measurement"))
    data <- subset(data, grepl("-mean()|-std()", data$measurement))
	data
}

# activity names
get_activities <- function (fileName) {
    read.table(fileName, col.names = list("ID", "activity"))
}

do_merge <- function (base_dir, test_name, train_name) {
    data <- read.table(paste(base_dir, "test", test_name, sep="/"))
    data <- rbind(data, read.table(paste(base_dir, "train", train_name, sep="/")))
    data
}

read_dataset <- function (base_dir = "UCI HAR Dataset") {
    
    activities <- get_activities((paste(base_dir, "activity_labels.txt", sep="/")))
    measurements <- get_measurements((paste(base_dir, "features.txt", sep="/")))
    
    subject <- do_merge(base_dir, "subject_test.txt", "subject_train.txt")
    X <- do_merge(base_dir, "X_test.txt", "X_train.txt")
    Y <- do_merge(base_dir, "y_test.txt", "y_train.txt")

	act_lbls <- as.character(activities[Y$V1, ]$activity)

	merged_ds <- cbind(X[, measurements$ID], subject=subject, activity_id=Y, activity=act_lbls)
    names(merged_ds) <- c(as.character(measurements$measurement), "subject", "activity_id", "activity")
	data.table(merged_ds)
}

build_tidy_dataset <- function (original_dataset, dest_file) {
    new_data <- original_dataset[, lapply(.SD, mean), by=c("subject", "activity_id", "activity")]
	write.table(new_data, dest_file)
    new_dataset
}

merged_dataset <- read_dataset()
tidy_dataset <- build_tidy_dataset(merged_dataset, "tidy.txt")
