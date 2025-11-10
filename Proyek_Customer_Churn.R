library(dplyr)
library(rpart)
library(rpart.plot)
library(readr)

path_data = "https://raw.githubusercontent.com/YBIFoundation/Dataset/main/TelecomCustomerChurn.csv"
cc_data = read_csv(path_data)
is.data.frame(cc_data)

head(cc_data)
str(cc_data)
glimpse(cc_data)

colSums(is.na(cc_data))

row(cc_data)
summary(cc_data)
nrow(cc_data)
<<<<<<< HEAD

cc_data <- cc_data %>% mutate(
  TotalCharges = ifelse(is.na(TotalCharges), mean(TotalCharges, na.rm = TRUE))
)
=======
>>>>>>> 562b3a55b129e15607efefa66339e0e3d16c6797
