# Read the raw data text outs you exported from Net Station
rm(list=ls())

## Specify which folder any text input goes into, plus the first few strings before condition name
folderString = "/textouts/n30/TDS-n30_gave_" ###

# setwd("../") # Go one directory up (assumes you are in NS.plots)

require(tidyverse)
# Extract data, assign each condition text file to an object; append a column that specifies which condition the dataframe is from
cond1.data <- read.delim(paste(getwd(),paste(folderString,"Loc-Nont, <multiple patients> 1.txt", sep=""),sep=""), header=F)
cond2.data <- read.delim(paste(getwd(),paste(folderString,"Loc-Rew, <multiple patients> 1.txt", sep=""),sep=""), header=F)
cond3.data <- read.delim(paste(getwd(),paste(folderString,"Loc-Targ, <multiple patients> 1.txt", sep=""),sep=""), header=F)
cond4.data <- read.delim(paste(getwd(),paste(folderString,"Obj-Nont, <multiple patients> 1.txt", sep=""),sep=""), header=F)
cond5.data <- read.delim(paste(getwd(),paste(folderString,"Obj-Rew, <multiple patients> 1.txt", sep=""),sep=""), header=F)
cond6.data <- read.delim(paste(getwd(),paste(folderString,"Obj-Targ, <multiple patients> 1.txt", sep=""),sep=""), header=F)

# Get all dataframes in the global environment, read into a list called cond.dfs
cond.dfs <- Filter(function(x) is(x, "data.frame"), mget(ls())) 

## What is your time window? 0 ms point is your event
prestim = -200; poststim = 800 ###

# Assign time every 4 ms to object, these will be rows
time.window <- seq(prestim+4, poststim, by=4)
ms <- time.window

# Assign channel names, these will be 129 columns
hydrocel.channels <- seq(1,129)

# Cast the rows and columns into each of your datafiles
list2env(lapply(cond.dfs, setNames, hydrocel.channels) # Assign column names as channel numbers for each of the dataframes in the cond.dfs list
         , .GlobalEnv) # Spit it back out into the global environment

# Regather the updated dataframes in the global environment, read into a list called cond.dfs
cond.dfs <- Filter(function(x) is(x, "data.frame"), mget(ls())) 

list2env(lapply(cond.dfs, cbind, ms) # Assign a new column called "ms" corresponding to time.window
         , .GlobalEnv) # Spit back out into the global environment


rm(cond.dfs) # clean up

