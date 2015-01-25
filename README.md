# GettingAndCleaningData
Getting and Cleaning data course project

Hi. This is Jesús from Spain. First of all sorry for my English.

I have consider that the script file is next to the 'UCI HAR Dataset' directory. This was not well specified in the requirements, but this seemed to me like the correct way.

I have tried to avoid using the dplyr package. So  maybe my implementation is not as efficient and/or readable as it could be.

The first point (merge all the data) is solved with two nested do.call/lapply structures. The inner one reads the subject, activity and measurement values and merges them by columns. The outer one reads the test and train directories and merges them by rows. The first column will be the subject id, the second column will be the activity, and the following ones will contain the measurements values.

For the second point the features names are read from features.txt. After that we filter the data for the features that contains 'mean()' or 'std()' in their name. I have consider that 'meanFreq()' features were not part of the project.

For the third point I have replaced the second column (activities) values with the corresponding strings in the activity_labels.txt file.

The fourth point is solved by redefining the names of the data set. As I have said before the first two columns will be "subject" and "activity". The remaining column names are obtained from the features.txt file.

For the fifth point I have created an auxiliary data structure (groups) with the possible combinations between subjects and activities. Then with do.call/mapply (we have two variables) I have managed to obtain the mean value (with colMeans) for all the combinations. This result is finally stored in tidydata.

And that is all.
Thanks for taking the time to evaluate this project.
Jesús.
