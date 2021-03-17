#Key points
#The working directory is where R looks for files and saves files by default.
#See your working directory with getwd(). Change your working directory with setwd().
#We suggest you create a directory for each project and keep your raw data inside that directory.
#Use the file.path() function to generate a full path from a relative path and a file name. Use file.path() instead of paste() because file.path() is aware of your operating system and will use the correct slashes to navigate your machine.
#The file.copy() function copies a file to a new path.

# see working directory
getwd()

# change your working directory
setwd()

# set path to the location for raw data files in the dslabs package and list files
path <- system.file("extdata", package="dslabs")
list.files(path)

# generate a full path to a file
filename <- "murders.csv"
fullpath <- file.path(path, filename)
fullpath

# copy file from dslabs package to your working directory
file.copy(fullpath, getwd())

# check if the file exists
file.exists(filename)