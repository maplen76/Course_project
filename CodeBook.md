Clean up data

## Signals

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 

The 3 time domain signals were captured at a constant rate of 50 Hz, then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. Finally a Fast Fourier Transform (FFT) was applied to some of these signals to get frequency domain signals

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The set of variables that were estimated from these signals are

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

## Data transformation

The raw data sets are processed with run_analisys.R script to create a tidy data set 

### Merge training sets and test sets to create one data set

Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt, subject_test.txt) and activity ids (y_train.txt, y_test.txt) are merged to obtain a single data set. Variables are labelled with the names assigned by original collectors (features.txt).
Also add a new column group to identify if the record is belong to training group or test group

### Extracts only the measurements on the mean and standard deviation for each measurement

Extract the mean (the column name contain "mean") and standard deviation (the column name contain "std") for each measurement from the merged data set

### Uses descriptive activity names to name the activities in the data set

Add new column to describe the activity by merging the 2 data sets activity_labels.txt and y_train.txt (or y_test.txt)

### Appropriately labels the data set with descriptive variable names. 

Remove the parentheses
Describe the time domain signals by using TimeDomain instead of prefix "t"
Describe the frequency domain signals by using FrequencyDomain instead of prefix "f"
Transform the abbreviation "Acc" to Acceleration
Transform the abbreviation "GyroJerk" to AngularAcceleration
Transform the abbreviation "Gyro" to AngularSpeed
Transform the abbreviation "std" to StandardDeviation
'-XYZ' denote 3-axial signals in the X, Y and Z directions

### Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Convert the Merged data into a molten data frame by calling the function melt in the package reshape2
To get the  average of each variable for each activity and each subject by calling the function dcast
Each line indicate the average value of variable for each subject and each activity














