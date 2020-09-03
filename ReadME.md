---
title: "ReadME"
author: "Martina Ulivieri"
date: "9/3/2020"
output: word_document
---

## Week 4 Peer-graded Assignment: Getting and Cleaning Data Course Project

This repository has been created to complete the Getting and Cleaning Data course project, offered by John Hopkins University, It has the instructions on how to run analysis on Human Activity recognition dataset.

### Dataset
A full description of the data can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### File description
- CodeBook.md is a code book that describes the variables, the data, and any transformations or work in the script to clean up the data

- run_analysis.R performs the data preparation (i.e., download, unzip) and then followed by the 5 steps required as described in the course project’s definition:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- FinalData.txt is the exported final data that has been created after going through all the sequences described above.