GettingAndCleaningData002
=========================

## get_measurements(fileName) 
```
read the feature file (fileName parameter) and returns only the measures with mean() and std()
```

## get_activities(fileName)
```
Read the activity name file
```

## do_merge(base_dir, test_name, train_name)
```
Merge the train and test files (applied to 'X', 'y' and 'subject' files)

the files names must be passed (test_name and train_name)
```

## read_dataset(base_dir = "UCI HAR Dataset")
```
generates the datatable of the whole data

merge all X , Y and subjects and uses the activities and measurements data to filter and label it

'base_dir' is where it'll search the needed files
```

## build_tidy_dataset(original_dataset, dest_file)
```
get the original dataset (original_dataset), get the avarage value of each variable grouping by subject and activity and save it in a file (dest_file)
```

