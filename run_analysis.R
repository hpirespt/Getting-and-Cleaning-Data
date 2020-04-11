run_analysis<-function(){
    library(dplyr)
    
    #path definitions
    pathfeatures<-".\\data\\UCI HAR Dataset\\features.txt"
    pathactivities<-".\\data\\UCI HAR Dataset\\activity_labels.txt"
    
    pathtestX<-".\\data\\UCI HAR Dataset\\test\\X_test.txt"
    pathtesty<-".\\data\\UCI HAR Dataset\\test\\y_test.txt"
    pathsubject_test<-".\\data\\UCI HAR Dataset\\test\\subject_test.txt"
    
    pathtestX<-".\\data\\UCI HAR Dataset\\test\\X_test.txt"
    pathtesty<-".\\data\\UCI HAR Dataset\\test\\y_test.txt"
    pathsubject_test<-".\\data\\UCI HAR Dataset\\test\\subject_test.txt"
    
    pathtrainX<-".\\data\\UCI HAR Dataset\\train\\X_train.txt"
    pathtrainy<-".\\data\\UCI HAR Dataset\\train\\y_train.txt"
    pathsubject_train<-".\\data\\UCI HAR Dataset\\train\\subject_train.txt"
    ######################################################################################
    
    #read data
    features<-read.table(pathfeatures, sep="")
    activities<-read.table(pathactivities, sep="")
    
    test_X_data<- read.table(pathtestX, sep = "")
    test_y_data<- read.table(pathtesty, sep = "")
    subject_test<- read.table(pathsubject_test, sep = "")
    
    train_X_data<- read.table(pathtrainX, sep = "")
    train_y_data<- read.table(pathtrainy, sep = "")
    subject_train<- read.table(pathsubject_train, sep = "")
    #######################################################################################
    
    #add headers with names to test_X_data
    colnames(test_X_data)<-features[,2]
    colnames(train_X_data)<-features[,2]
    #######################################################################################
    
    #Bind subject and Y_test with Cbind and give names to columns: subject, acactivitieslabels (Because it reprsents the activities by numbers)
    Y_subBind_test<-data.frame(cbind(subject_test,test_y_data))
    colnames(Y_subBind_test)<-c("subject","activitieslabels")
    
    Y_subBind_train<-data.frame(cbind(subject_train,train_y_data))
    colnames(Y_subBind_train)<-c("subject","activitieslabels")
    #######################################################################################
    
    #Bind Y_subbind with Test_X data:
    Comp_Test <- cbind(Y_subBind_test, test_X_data)
    Comp_Train <- cbind(Y_subBind_train, train_X_data)
    #######################################################################################
    
    
    #Bind both dataframes
    Final_dataset<-rbind(Comp_Test,Comp_Train)
    
    
    #Replace activities labels for the names presents in activities.txt
    Final_dataset$activitieslabels<-factor(Final_dataset$activitieslabels)
    levels(Final_dataset$activitieslabels) <- activities$V2
    #######################################################################################
    
    #get mean columns
    get_means<-grep("mean()" , names(Final_dataset), value=TRUE)
    get_meanfreq<-grep("meanFreq()" , names(Final_dataset), value=TRUE)
    get_cols_mean<-setdiff(get_means, get_meanfreq)
    
    #get std columns
    get_cols_std<-grep("std()" , names(Final_dataset), value=TRUE)
    ######################################################################################
    
    #Tidy Datase: Subsetting Final_dataset to only have subject, activities, mean and std columns
    #Sort columns by sybject and activities
    Tidy_dataset<-Final_dataset[,c("subject","activitieslabels",get_cols_mean,get_cols_std)]
    
    Tidy_dataset<-arrange(Tidy_dataset, subject, activitieslabels)
    #####################################################################################
    
    #start creating Tidy dataset 2: average of each variable for each activity and each subject
    #using dplyr functions
    Tidy_dataset_2<-group_by(Tidy_dataset,subject,activitieslabels)
    Tidy_dataset_2<-summarise_each(Tidy_dataset_2,  funs = mean)
    #####################################################################################
    
    # Writing Tidy_dataset_2 txt file
    write.table(Tidy_dataset_2,"Tidy_dataset_2.txt",row.name=FALSE )

    #Print Tidy Dataset
    Tidy_dataset
    #####################################################################################
}