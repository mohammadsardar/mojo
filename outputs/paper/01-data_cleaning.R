#### Preamble ####
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Mohammad Sardar Sheikh
# Data: 6 January 2021
# Contact: mohammad.sheikh@mail.utoronto.ca
# License: MIT i think im not sure though



#### Workspace setup ####
# Use R Projects, not setwd().
library(haven)
library(tidyverse)
install.packages("opendatatoronto")
library(opendatatoronto)
install.packages("janitor")
library(janitor)
library(dplyr)
library(lubridate)
library(knitr)
# Read in the raw data. 

# Based on code from: 
# https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/
# Thank you to Heath Priston for assistance
#### Acquire ####
# Based on code from: 
# https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/
# Thank you to Heath Priston for assistance
toronto_shelters <- 
  list_package_resources("21c83b32-d5a8-4106-a54f-010dbe49f6f2") %>% 
  filter(name == "daily-shelter-overnight-service-occupancy-capacity-2021") %>%  
  get_resource()

write_csv(
  x = toronto_shelters, 
  file = "toronto_shelters.csv"
)

head(toronto_shelters)
toronto_shelters$OCCUPANCY_DATE <- ymd(toronto_shelters$OCCUPANCY_DATE)
head(toronto_shelters)

         
toronto_shelters$OCCUPANCY_DATE <- ymd(toronto_shelters$OCCUPANCY_DATE)
toronto_shelters_clean <- 
  clean_names(toronto_shelters) %>% 
  select(occupancy_date, id, occupied_beds, location_province, occupancy_rate_beds, capacity_actual_bed) 
head(toronto_shelters_clean)

toronto_shelters_clean <- toronto_shelters_clean %>% 
  filter(occupied_beds != "NaN")
head(toronto_shelters_clean)

toronto_shelters_clean$occupied_beds <- as.numeric(toronto_shelters_clean$occupied_beds)
toronto_shelters_clean$occupancy_rate_beds <- as.numeric(toronto_shelters_clean$occupancy_rate_beds)
toronto_shelters_clean$capacity_actual_bed <- as.numeric(toronto_shelters_clean$capacity_actual_bed)


head(toronto_shelters_clean)

write_csv(
  x = toronto_shelters_clean, 
  file = "cleaned_toronto_shelters.csv"
)
