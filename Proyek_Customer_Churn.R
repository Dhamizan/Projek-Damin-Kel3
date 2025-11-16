library(dplyr)
library(rpart)
library(rpart.plot)
library(readr)
library(ggplot2)
library(caret)
library(randomForest)

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

STC <- cc_data %>% summarise(
  median = median(TotalCharges, na.rm = TRUE)
)

cc_data <- cc_data %>% mutate(
  TotalCharges = ifelse(is.na(TotalCharges), STC$median, TotalCharges)
)

ggplot(cc_data, aes(y = SeniorCitizen)) +
  geom_boxplot() # Terdapat titik di plot, namun itu setelah di cari tau bukanlah outlier.

ggplot(cc_data, aes(y = Tenure)) +
  geom_boxplot()

ggplot(cc_data, aes(y = MonthlyCharges)) +
  geom_boxplot()

ggplot(cc_data, aes(y = TotalCharges)) +
  geom_boxplot()

# SeniorCitizen

#po <- cc_data %>% summarise(
#  q1 = quantile(SeniorCitizen, 0.25),
#  q3 = quantile(SeniorCitizen, 0.75),
#  iqr = q3 - q1,
#  low = q1 - 1.5 * iqr,
#  up = q3 + 1.5 * iqr
#)

#cc_data = cc_data %>% mutate(
#  SeniorCitizen = ifelse(SeniorCitizen < po$low, po$low, ifelse(
#    SeniorCitizen > po$up, po$up, SeniorCitizen))
#)

cc_data %>% filter(SeniorCitizen == 0)
cc_data %>% filter(SeniorCitizen == 1)
cc_data %>% filter(SeniorCitizen == 2)

cc_data <- cc_data %>% select(-customerID)

# Model Decision Tree
set.seed(123)
sampel <- createDataPartition(cc_data$Churn, p = 0.8, list = FALSE)
data_train <- cc_data %>% slice(sampel)
data_test <- cc_data %>% slice(-sampel)

model_dct_train <- rpart(Churn ~ ., data = data_train, method = "class")
plot_dct_train <- rpart.plot(
  model_dct_train, type = 2, extra = 104, fallen.leaves = TRUE
)
plot_dct_train

prediksi <- predict(model_dct_train, data_test, type = "class")
head(prediksi)

level_pred = levels(prediksi)

data_test$Churn = factor(data_test$Churn, levels = level_pred)

# Evaluasi Model
evaluasi_model <- confusionMatrix(prediksi, data_test$Churn, positive = "Yes")
evaluasi_model
