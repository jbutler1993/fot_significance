### Load Excel ###

library(readxl)
library(writexl)
library(dplyr)
library(tibble)
library(data.table)

responses <-  read_excel("C:/Users/jb000299/Downloads/FOT_responses_Oct24.xlsx") # 'responses' excel

times <- c("April 2024", "October 2023", "April 2023", "October 2022", "April 2022", "October 2021", "April 2021", "October 2020", "September 2019") # Needs to be all iterations except the latest

## Creating the table
significance <- data.frame(
  question = character(), # Column 'question' as text
  answer = character(),  # Column 'answer' as text
  timeone = character(),   # Column 'time1' as text
  timetwo = character(),   # Column 'time2' as text
  pvalue = double()     # Column 'pvalue' as a decimal
)

### Function for z-test

fot_significance <- function(timeinput1, questioninput, answerinput) {
  
  ### Input the function variables ###
  
  time1 <- "October 2024" # The latest iteration of the survey
  time2 <- timeinput1 # The iteration being compared to
  answer1 <- answerinput # The specific answer
  question1 <- questioninput # The specific Survey Question
  
  ### Data ###
  
  latest <- responses %>%
    filter(time == time1) 
  
  previous <- responses %>%
    filter(time == time2)
  
  latest_question <- latest %>%
    filter(question == question1) %>%
    filter(answer == answer1) # create a table of the latest time
  
  previous_question <- previous %>%
    filter(question == question1) %>%
    filter(answer == answer1) # create a table of the latest time
  
  # Group 1
  n1 <- latest_question$total # Sample size for group 1
  x1 <- latest_question$number  # Number of successes in group 1
  
  # Group 2
  n2 <- previous_question$total # Sample size for group 2
  x2 <- previous_question$number  # Number of successes in group 2
  
  # Performing the two-proportion z-test
  # H0: p1 = p2 (the proportions are equal)
  # H1: p1 b	  p2 (the proportions are not equal)
  
  ### Manipulation ###
  
  # Step 1: Compute the sample proportions
  p1 <- x1 / n1
  p2 <- x2 / n2
  
  # Step 2: Compute the pooled sample proportion
  p_pool <- (x1 + x2) / (n1 + n2)
  
  # Step 3: Compute the standard error
  SE <- sqrt(p_pool * (1 - p_pool) * (1/n1 + 1/n2))
  
  # Step 4: Compute the test statistic
  z <- (p1 - p2) / SE
  
  # Step 5: Set the significance level (alpha)
  alpha <- 0.05
  
  # Step 6: Find the critical value for the test statistic
  critical_value <- qnorm(1 - alpha / 2)
  
  # Step 7: Print the variables
  
  print(question1)
  print(answer1)
  print(time1)
  print(time2)
  
  # Step 8: Calculate the p-value
  p_value <- 2 * (1 - pnorm(abs(z)))
  
  if (length(p_value) > 1) {
    p_value <- max(p_value)
  }
  
  cat("The p-value is:", p_value, "\n")
  
  # Step 9: Add to the table
  
  function_df <- data.frame(question = question1, answer = answer1, timeone = time1, timetwo = time2, pvalue = p_value)
  
  significance <<- rbind(significance, function_df)
  
}


### Running of Answers

## Vision

# Do you know what Defra's vision means for farming?

for (time in times) {
  fot_significance(time, "Do you know what Defra's vision means for farming?", "Yes, I fully understand Defra's vision for farming")}

for (time in times) {
  fot_significance(time, "Do you know what Defra's vision means for farming?", "Yes, I know roughly")}

for (time in times) {
  fot_significance(time, "Do you know what Defra's vision means for farming?", "No, I don't know, but would be interested to know more")}

for (time in times) {
  fot_significance(time, "Do you know what Defra's vision means for farming?", "No, I don't need to know")}

## Changes

# Do you have the information you need at this point to inform your business planning? 

for (time in times) {
  fot_significance(time, "Do you have the information you need at this point to inform your business planning?", "I have all the information I need")}

for (time in times) {
  fot_significance(time, "Do you have the information you need at this point to inform your business planning?", "I have most of the information I need")}

for (time in times) {
  fot_significance(time, "Do you have the information you need at this point to inform your business planning?", "Most or all information")}

for (time in times) {
  fot_significance(time, "Do you have the information you need at this point to inform your business planning?", "I do not have any information but know where to find")}

for (time in times) {
  fot_significance(time, "Do you have the information you need at this point to inform your business planning?", "I do not have any information and I don't know where to find it")}

for (time in times) {
  fot_significance(time, "Do you have the information you need at this point to inform your business planning?", "I do not have any information (either)")}

for (time in times) {
  fot_significance(time, "Do you have the information you need at this point to inform your business planning?", "I don't know")}

# Do you feel you will need to make changes to your business in the next 3-5 years?

for (time in times) {
  fot_significance(time, "Do you feel you will need to make changes to your business in the next 3-5 years?", "I am making changes to my business")}

for (time in times) {
  fot_significance(time, "Do you feel you will need to make changes to your business in the next 3-5 years?", "I will need to make changes to my business")}

for (time in times) {
  fot_significance(time, "Do you feel you will need to make changes to your business in the next 3-5 years?", "I don't need to change my business")}

for (time in times) {
  fot_significance(time, "Do you feel you will need to make changes to your business in the next 3-5 years?", "I don't know what changes I need to make")}

# What changes do you think you will need to make?

for (time in times) {
  fot_significance(time, "What changes do you think you will need to make?", "Stay farming and grow the business")}

for (time in times) {
  fot_significance(time, "What changes do you think you will need to make?", "Stay farming but reduce the size of the business")}

for (time in times) {
  fot_significance(time, "What changes do you think you will need to make?", "Stay farming but diversify business into non-farming areas")}

for (time in times) {
  fot_significance(time, "What changes do you think you will need to make?", "Stay farming but increase productivity")}

for (time in times) {
  fot_significance(time, "What changes do you think you will need to make?", "Stay farming but change core agricultural enterprises (for example, change crops and/or livestock)")}

for (time in times) {
  fot_significance(time, "What changes do you think you will need to make?", "Leave farming (planned retirement or pass onto next generation)")}

for (time in times) {
  fot_significance(time, "What changes do you think you will need to make?", "Leave farming (exit for other reasons)")}

for (time in times) {
  fot_significance(time, "What changes do you think you will need to make?", "Other")}

# Have any of the following factors led to you make changes on your farm?

for (time in times) {
  fot_significance(time, "Have any of the following factors led to you make changes on your farm?", "Input price changes")}

for (time in times) {
  fot_significance(time, "Have any of the following factors led to you make changes on your farm?", "Output price changes")}

for (time in times) {
  fot_significance(time, "Have any of the following factors led to you make changes on your farm?", "Food security and supply")}

for (time in times) {
  fot_significance(time, "Have any of the following factors led to you make changes on your farm?", "Trade agreements with other countries")}

for (time in times) {
  fot_significance(time, "Have any of the following factors led to you make changes on your farm?", "Weather / climate change")}

# How confident are you that you can respond to any changes needed?

for (time in times) {
  fot_significance(time, "How confident are you that you can respond to any changes needed?", "Very confident")}

for (time in times) {
  fot_significance(time, "How confident are you that you can respond to any changes needed?", "Somewhat confident")}

for (time in times) {
  fot_significance(time, "How confident are you that you can respond to any changes needed?", "Confident (either)")}

for (time in times) {
  fot_significance(time, "How confident are you that you can respond to any changes needed?", "Not at all confident")}

for (time in times) {
  fot_significance(time, "How confident are you that you can respond to any changes needed?", "I don't know")}

## Groups

# To what extent do you agree that farming organisations and advisors are helping you make these changes?

for (time in times) {
  fot_significance(time, "To what extent do you agree that farming organisations and advisors are helping you make these changes?", "Strongly agree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that farming organisations and advisors are helping you make these changes?", "Agree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that farming organisations and advisors are helping you make these changes?", "Agree (either)")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that farming organisations and advisors are helping you make these changes?", "Neither agree nor disagree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that farming organisations and advisors are helping you make these changes?", "Disagree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that farming organisations and advisors are helping you make these changes?", "Strongly disagree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that farming organisations and advisors are helping you make these changes?", "Disagree (either)")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that farming organisations and advisors are helping you make these changes?", "Not applicable")}

# How important is producing for the end market for your business currently?

for (time in times) {
  fot_significance(time, "How important is producing for the end market for your business currently?", "Very important")}

for (time in times) {
  fot_significance(time, "How important is producing for the end market for your business currently?", "Moderately important")}

for (time in times) {
  fot_significance(time, "How important is producing for the end market for your business currently?", "Very or moderately important")}

for (time in times) {
  fot_significance(time, "How important is producing for the end market for your business currently?", "Not at all important")}

for (time in times) {
  fot_significance(time, "How important is producing for the end market for your business currently?", "I don't know")}

# How important will producing for the end market be for your business in the future?

for (time in times) {
  fot_significance(time, "How important will producing for the end market be for your business in the future?", "Very important")}

for (time in times) {
  fot_significance(time, "How important will producing for the end market be for your business in the future?", "Moderately important")}

for (time in times) {
  fot_significance(time, "How important will producing for the end market be for your business in the future?", "Very or moderately important")}

for (time in times) {
  fot_significance(time, "How important will producing for the end market be for your business in the future?", "Not at all important")}

for (time in times) {
  fot_significance(time, "How important will producing for the end market be for your business in the future?", "I don't know")}

## Environment

# How important is it for your business that Defra pays for environmental outcomes currently?

for (time in times) {
  fot_significance(time, "How important is it for your business that Defra pays for environmental outcomes currently?", "Very important")}

for (time in times) {
  fot_significance(time, "How important is it for your business that Defra pays for environmental outcomes currently?", "Moderately important")}

for (time in times) {
  fot_significance(time, "How important is it for your business that Defra pays for environmental outcomes currently?", "Not at all important")}

for (time in times) {
  fot_significance(time, "How important is it for your business that Defra pays for environmental outcomes currently?", "I don't know")}

# How important will it be for your business that Defra pays for environmental outcomes in the future?

for (time in times) {
  fot_significance(time, "How important will it be for your business that Defra pays for environmental outcomes in the future?", "Very important")}

for (time in times) {
  fot_significance(time, "How important will it be for your business that Defra pays for environmental outcomes in the future?", "Moderately important")}

for (time in times) {
  fot_significance(time, "How important will it be for your business that Defra pays for environmental outcomes in the future?", "Very or moderately important")}

for (time in times) {
  fot_significance(time, "How important will it be for your business that Defra pays for environmental outcomes in the future?", "Not at all important")}

for (time in times) {
  fot_significance(time, "How important will it be for your business that Defra pays for environmental outcomes in the future?", "I don't know")}

# To what extent do you agree that the current approach balances enforcement with individual responsibility?

for (time in times) {
  fot_significance(time, "To what extent do you agree that the current approach balances enforcement with individual responsibility?", "Strongly agree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that the current approach balances enforcement with individual responsibility?", "Agree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that the current approach balances enforcement with individual responsibility?", "Agree (either)")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that the current approach balances enforcement with individual responsibility?", "Neither agree nor disagree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that the current approach balances enforcement with individual responsibility?", "Disagree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that the current approach balances enforcement with individual responsibility?", "Strongly disagree")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that the current approach balances enforcement with individual responsibility?", "Disagree (either)")}

for (time in times) {
  fot_significance(time, "To what extent do you agree that the current approach balances enforcement with individual responsibility?", "Not applicable")}

# How confident are you that you understand which regulations apply to your farm?

for (time in times) {
  fot_significance(time, "How confident are you that you understand which regulations apply to your farm?", "Very confident")}

for (time in times) {
  fot_significance(time, "How confident are you that you understand which regulations apply to your farm?", "Somewhat confident")}

for (time in times) {
  fot_significance(time, "How confident are you that you understand which regulations apply to your farm?", "Confident (either)")}

for (time in times) {
  fot_significance(time, "How confident are you that you understand which regulations apply to your farm?", "Not at all confident")}

for (time in times) {
  fot_significance(time, "How confident are you that you understand which regulations apply to your farm?", "I don't know")}

# Thinking of the regulations that apply to your farm (outside the rules associated with any payment schemes), to what extent do you understand their purpose?

for (time in times) {
  fot_significance(time, "Thinking of the regulations that apply to your farm (outside the rules associated with any payment schemes), to what extent do you understand their purpose?", "I fully understand the purpose")}

for (time in times) {
  fot_significance(time, "Thinking of the regulations that apply to your farm (outside the rules associated with any payment schemes), to what extent do you understand their purpose?", "I roughly understand the purpose")}

for (time in times) {
  fot_significance(time, "Thinking of the regulations that apply to your farm (outside the rules associated with any payment schemes), to what extent do you understand their purpose?", "I don’t understand but want to know")}

for (time in times) {
  fot_significance(time, "Thinking of the regulations that apply to your farm (outside the rules associated with any payment schemes), to what extent do you understand their purpose?", "I don't need to know")}

## Relationships

# How confident are you that changes to schemes and regulations will lead to a successful future for farming? 

for (time in times) {
  fot_significance(time, "How confident are you that changes to schemes and regulations will lead to a successful future for farming?", "Very confident")}

for (time in times) {
  fot_significance(time, "How confident are you that changes to schemes and regulations will lead to a successful future for farming?", "Somewhat confident")}

for (time in times) {
  fot_significance(time, "How confident are you that changes to schemes and regulations will lead to a successful future for farming?", "Confident (either)")}

for (time in times) {
  fot_significance(time, "How confident are you that changes to schemes and regulations will lead to a successful future for farming?", "Not at all confident")}

for (time in times) {
  fot_significance(time, "How confident are you that changes to schemes and regulations will lead to a successful future for farming?", "I don't know")}

# How confident are you in Defra and Defra agency's ability to deliver changes to schemes and regulations?

for (time in times) {
  fot_significance(time, "How confident are you in Defra and Defra agency's ability to deliver changes to schemes and regulations?", "Very confident")}

for (time in times) {
  fot_significance(time, "How confident are you in Defra and Defra agency's ability to deliver changes to schemes and regulations?", "Somewhat confident")}

for (time in times) {
  fot_significance(time, "How confident are you in Defra and Defra agency's ability to deliver changes to schemes and regulations?", "Confident (either)")}

for (time in times) {
  fot_significance(time, "How confident are you in Defra and Defra agency's ability to deliver changes to schemes and regulations?", "Not at all confident")}

for (time in times) {
  fot_significance(time, "How confident are you in Defra and Defra agency's ability to deliver changes to schemes and regulations?", "I don't know")}

# As part of delivering the changes, to what extent do you feel confident that your own relationship with Defra and Defra agencies, such as the Rural Payments Agency and Natural England, will develop positively in the future?

for (time in times) {
  fot_significance(time, "As part of delivering the changes, to what extent do you feel confident that your own relationship with Defra and Defra agencies, such as the Rural Payments Agency and Natural England, will develop positively in the future?", "Very confident")}

for (time in times) {
  fot_significance(time, "As part of delivering the changes, to what extent do you feel confident that your own relationship with Defra and Defra agencies, such as the Rural Payments Agency and Natural England, will develop positively in the future?", "Somewhat confident")}

for (time in times) {
  fot_significance(time, "As part of delivering the changes, to what extent do you feel confident that your own relationship with Defra and Defra agencies, such as the Rural Payments Agency and Natural England, will develop positively in the future?", "Confident (either)")}

for (time in times) {
  fot_significance(time, "As part of delivering the changes, to what extent do you feel confident that your own relationship with Defra and Defra agencies, such as the Rural Payments Agency and Natural England, will develop positively in the future?", "Not at all confident")}

for (time in times) {
  fot_significance(time, "As part of delivering the changes, to what extent do you feel confident that your own relationship with Defra and Defra agencies, such as the Rural Payments Agency and Natural England, will develop positively in the future?", "I don't know")}

# Taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about the future of farming?

for (time in times) {
  fot_significance(time, "Taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about the future of farming?", "Very positive")}

for (time in times) {
  fot_significance(time, "Taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about the future of farming?", "Somewhat positive")}

for (time in times) {
  fot_significance(time, "Taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about the future of farming?", "Positive")}

for (time in times) {
  fot_significance(time, "Taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about the future of farming?", "Not at all positive")}

for (time in times) {
  fot_significance(time, "Taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about the future of farming?", "I don't know")}

# Personally, taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about your future in farming?

for (time in times) {
  fot_significance(time, "Personally, taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about your future in farming?", "Very positive")}

for (time in times) {
  fot_significance(time, "Personally, taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about your future in farming?", "Somewhat positive")}

for (time in times) {
  fot_significance(time, "Personally, taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about your future in farming?", "Positive")}

for (time in times) {
  fot_significance(time, "Personally, taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about your future in farming?", "Not at all positive")}

for (time in times) {
  fot_significance(time, "Personally, taking into account the changes to existing payments / regulations and new schemes that will be available, how do you feel about your future in farming?", "I don't know")}

#### APRIL 2024 QUESTIONS #############################################################

# In the next year, do you plan on making changes to any agri-environment schemes / agreements you have for your farm?

for (time in times) {
  fot_significance(time, "In the next year, do you plan on making changes to any agri-environment schemes / agreements you have for your farm?", "I have an agri-environment scheme agreement already and am not planning any changes")}

for (time in times) {
  fot_significance(time, "In the next year, do you plan on making changes to any agri-environment schemes / agreements you have for your farm?", "I have an agri-environment scheme agreement already and am planning to do more e.g. more options, more land")}

for (time in times) {
  fot_significance(time, "In the next year, do you plan on making changes to any agri-environment schemes / agreements you have for your farm?", "I have an agri-environment scheme agreement already and am planning to do another scheme alongside")}

for (time in times) {
  fot_significance(time, "In the next year, do you plan on making changes to any agri-environment schemes / agreements you have for your farm?", "I have an agri-environment scheme agreement already and am planning to replace it with another scheme")}

for (time in times) {
  fot_significance(time, "In the next year, do you plan on making changes to any agri-environment schemes / agreements you have for your farm?", "I have an agri-environment scheme agreement already but will not be renewing")}

for (time in times) {
  fot_significance(time, "In the next year, do you plan on making changes to any agri-environment schemes / agreements you have for your farm?", "I don’t have an agri-environment scheme agreement already but planning to do one")}

for (time in times) {
  fot_significance(time, "In the next year, do you plan on making changes to any agri-environment schemes / agreements you have for your farm?", "I don’t have an agri-environment scheme agreement already  and not planning to do one")}

# Have any of the following issues led to you planning any of those changes to agri-environment schemes / agreements for the next year on your farm?

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you planning any of those changes to agri-environment schemes / agreements for the next year on your farm?", "New scheme or scheme options that will benefit my farm's environment")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you planning any of those changes to agri-environment schemes / agreements for the next year on your farm?", "New scheme or scheme options that will fit easily into the way the business is run")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you planning any of those changes to agri-environment schemes / agreements for the next year on your farm?", "New scheme or scheme options that are attractive financially")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you planning any of those changes to agri-environment schemes / agreements for the next year on your farm?", "New scheme or scheme options that are easy to apply for")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you planning any of those changes to agri-environment schemes / agreements for the next year on your farm?", "New scheme or scheme options that are flexible to my needs")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you planning any of those changes to agri-environment schemes / agreements for the next year on your farm?", "New scheme or scheme options that are needed as I have significantly changed the business e.g. bought more land")}

# Have any of the following issues led to you making the decision not to enroll in or renew agri-environment schemes / agreements for the next year?

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you making the decision not to enroll in or renew agri-environment schemes / agreements for the next year?", "Available schemes will not benefit my farm's environment")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you making the decision not to enroll in or renew agri-environment schemes / agreements for the next year?", "Available schemes will not fit easily into the way the business is run")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you making the decision not to enroll in or renew agri-environment schemes / agreements for the next year?", "Available schemes are not attractive financially")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you making the decision not to enroll in or renew agri-environment schemes / agreements for the next year?", "Available schemes are not easy to apply for")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you making the decision not to enroll in or renew agri-environment schemes / agreements for the next year?", "Available schemes are not flexible to my needs")}

for (time in times) {
  fot_significance(time, "Have any of the following issues led to you making the decision not to enroll in or renew agri-environment schemes / agreements for the next year?", "Available schemes are not an option as I plan to significantly change the business e.g. retire, sell land, etc")}


### Export output

write_xlsx(significance, path = "C:/Users/jb000299/Downloads/FOT_significance_Oct24.xlsx")
