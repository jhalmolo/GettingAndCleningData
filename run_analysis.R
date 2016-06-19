##Installation and upload of package plyr
install.packages("plyr")
require(plyr)

# Load files and directories
UCI_DIR <- "UCI\ HAR\ Dataset"
FEATURE_FILE <- paste(UCI_DIR, "/FEATURES.txt", sep = "")
ACTIVITY_LABELS_FILE <- paste(UCI_DIR, "/ACTIVITY_LABELS.txt", sep = "")
X_TEST_FILE  <- paste(UCI_DIR, "/test/X_TEST.txt", sep = "")
Y_TEST_FILE  <- paste(UCI_DIR, "/test/Y_TEST.txt", sep = "")
SUBJECT_TEST_FILE <- paste(UCI_DIR, "/test/SUBJECT_TEST.txt", sep = "")
X_TRAIN_FILE <- paste(UCI_DIR, "/train/X_TRAIN.txt", sep = "")
Y_TRAIN_FILE <- paste(UCI_DIR, "/train/Y_TRAIN.txt", sep = "")
SUBJECT_TRAIN_FILE <- paste(UCI_DIR, "/train/SUBJECT_TRAIN.txt", sep = "")

# Load data
FEATURES <- read.table(FEATURE_FILE, colClasses = c("character"))
ACTIVITY_LABELS <- read.table(ACTIVITY_LABELS_FILE, col.names = c("ActivityId", "Activity"))
X_TEST <- read.table(X_TEST_FILE)
Y_TEST <- read.table(Y_TEST_FILE)
SUBJECT_TEST <- read.table(SUBJECT_TEST_FILE)
X_TRAIN <- read.table(X_TRAIN_FILE)
Y_TRAIN <- read.table(Y_TRAIN_FILE)
SUBJECT_TRAIN <- read.table(SUBJECT_TRAIN_FILE)

# 1. Merges the training and the test sets to create one data set.

TRAIN_SENSOR_DATA <- cbind(cbind(X_TRAIN, SUBJECT_TRAIN), Y_TRAIN)
TEST_SENSOR_DATA <- cbind(cbind(X_TEST, SUBJECT_TEST), Y_TEST)
SENSOR_DATA <- rbind(TRAIN_SENSOR_DATA, TEST_SENSOR_DATA)
SENSOR_LABELS <- rbind(rbind(FEATURES, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(SENSOR_DATA) <- SENSOR_LABELS

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

SENSOR_DATA_MEAN <- SENSOR_DATA[,grepl("mean|std|Subject|ActivityId", names(SENSOR_DATA))]

# 3. Uses descriptive activity names to name the activities in the data set

SENSOR_DATA_MEAN <- join(SENSOR_DATA_MEAN, ACTIVITY_LABELS, by = "ActivityId", match = "first")
SENSOR_DATA_MEAN <- SENSOR_DATA_MEAN[,-1]

# 4. Appropriately labels the data set with descriptive names.

names(SENSOR_DATA_MEAN) <- gsub('\\(|\\)',"",names(SENSOR_DATA_MEAN), perl = TRUE)
names(SENSOR_DATA_MEAN) <- make.names(names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('Acc',"Acceleration",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('GyroJerk',"AngularAcceleration",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('Gyro',"AngularSpeed",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('Mag',"Magnitude",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('^t',"TimeDomain.",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('^f',"FrequencyDomain.",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('\\.mean',".Mean",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('\\.std',".StandardDeviation",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('Freq\\.',"Frequency.",names(SENSOR_DATA_MEAN))
names(SENSOR_DATA_MEAN) <- gsub('Freq$',"Frequency",names(SENSOR_DATA_MEAN))

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

DATA_AVG = ddply(SENSOR_DATA_MEAN, c("Subject","Activity"), numcolwise(mean))
write.table(DATA_AVG, file = "DATA_AVG.txt")