require(data.table)

# Set all files paths
datadir <- "UCI HAR Dataset/"
files = c(
  test = c(
    subject = paste0(datadir,"test/subject_test.txt"),
    activity = paste0(datadir,"test/y_test.txt"),
    data = paste0(datadir,"test/X_test.txt")
  ),
  train = c(
    subject = paste0(datadir,"train/subject_train.txt"),
    activity = paste0(datadir,"train/y_train.txt"),
    data = paste0(datadir,"train/X_train.txt")
  ),
  features = paste0(datadir,"features.txt"),
  actlabels =  paste0(datadir,"activity_labels.txt")
)

# Get the names (features)
columns <- c("subject", "activity", as.character(read.table(files["features"])[,2]), "dataset" )
columns <- gsub("[(),-]", "", tolower(columns) )
filter <- sort( c(1, 2, grep("mean",columns), grep("std",columns), 564) )

# Get activities names
activities <- as.character(read.table(files["actlabels"])[,2])
activities <- gsub("[(),-_]", "", tolower(activities) )

# Read the train set
data_train <- data.frame(
  read.table(files["train.subject"]),
  read.table(files["train.activity"]),
  read.table(files["train.data"]),
  dataset = "train"
)
names(data_train) <- columns

# Read the test set
data_test <- data.frame(
  read.table(files["test.subject"]),
  read.table(files["test.activity"]),
  read.table(files["test.data"]),
  dataset = "test"
)
names(data_test) <- columns

# Join the training and the test set and get means and stds
data_all <- rbind(data_train, data_test)
data_all <- data_all[,filter]
data_all[,2] <- activities[data_all[,2]]

# Tidy data with average values only
filter <- c( 1, 2, grep("mean",names(data_all)), 89)
tidy_data <- data_all[ ,filter]
tidy_data[,2] <- activities[tidy_data[,2]]
