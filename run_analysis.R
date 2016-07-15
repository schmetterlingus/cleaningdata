# Start with setting your working directory properly
# run_analysis.R should be one level higher than unzipped dir.
# Otherwise you need to change "wd" variable.

require(data.table)
require(dplyr)

# Config
wd <- "UCI HAR Dataset/" # set working dir
files <- list( #set files paths
  labels = paste0( wd, "activity_labels.txt" ),
  trainingset = paste0( wd, "train/X_train.txt" ),
  traininglabels = paste0( wd, "train/y_train.txt" ),
  trainingsubject = paste0( wd, "train/subject_train.txt" ),
  testset = paste0( wd, "test/X_test.txt" ),
  testlabels = paste0( wd, "test/y_test.txt" ),
  testsubject = paste0( wd, "test/subject_test.txt" )
  )

# Load
cleanlabels <- function(x) { #clean labels and trun to lowercase
  if ( !is.integer(x)) 
     gsub("_", "", tolower(x) )
}

actlab <- read.csv(files$labels, sep = " ", header = F) # read in activity labels
colnames(actlab) <- c("actno","actdesc") #Name activity headers
actlab$actdesc <- apply(actlab, 1, function(x) ( gsub("_", "", tolower(x[2]))) )

# Get all the tables and merge them calculating standard dev
# and mean value. "Set" value tells whether the observation
# comes form training or test set.
#
# dt:
# - subject: subject no
# - activityno: activity number
# - mean: mean value for the observation
# - sd: standard deviation value for the observation
# - set: the dataset (training/test)

dt <- rbind (
  data.table(
    subject = read.csv(files$trainingsubject, header = F),
    activityno = read.csv(files$traininglabels, header = F),
    mean = apply( read.table(files$trainingset), 1, mean),
    sd = apply( read.table(files$trainingset), 1, sd),
    set = "training"
  ),
  data.table(
    subject = read.csv(files$testsubject, header = F),
    activityno = read.csv(files$testlabels, header = F),
    mean = apply( read.table(files$testset), 1, mean),
    sd = apply( read.table(files$testset), 1, sd),
    set = "test"
  )
)

names(dt) <- c("subject", "activityno", "mean", "sd", "set" )
dt <- mutate(dt, activity = actlab[dt$activityno,2] )# change activity no into descriptions

dt <- arrange(dt, subject, activityno)


# Independent tidy data set with the average
# of each variable for each activity and each subject
#
# sdt:
# - subject
# - activity
# - avg: avarage
# - sd: standard deviation

sdt <- data.table( aggregate(dt$mean, by = list(dt$subject, dt$activity), FUN = mean) )
sdt <- mutate(sdt, sd = aggregate(dt$sd, by = list(dt$subject, dt$activity), FUN = sd)[,3] )
names( sdt ) <- c("subject", "activity", "avg", "sd" )
