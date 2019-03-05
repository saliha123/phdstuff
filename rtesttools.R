# LOAD THE RTextTools LIBARY


library(RTextTools)

# READ THE Text files


data <- read_data(system.file("C:/data5-all.zip", package="RTextTools"), type="folder",index="C:/temp/index2.csv")
