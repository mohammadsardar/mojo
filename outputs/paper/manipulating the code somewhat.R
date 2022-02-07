#this will be used to manipulate the dataset and make it more useful for our purposes.
toronto_shelters_clean <- 
  read_csv(
    "cleaned_toronto_shelters.csv")

# Based on code from Florence Vallée-Dubois and Lisa Lendway
toronto_shelters_clean %>% 
  mutate(occupancy_month = month(occupancy_date, 
                                 label = TRUE, 
                                 abbr = FALSE)) %>% 
  drop_na(occupied_beds) %>%  # We only want rows that have data
  group_by(occupancy_month) %>%  # We want to know the occupancy by month
  summarize(number_occupied = mean(occupied_beds)) %>% 
  kable()

toronto_shelters_clean <- toronto_shelters_clean %>% 
  mutate(occupancy_month = month(occupancy_date, 
                                 label = TRUE, 
                                 abbr = FALSE))
  
toronto_shelters_clean <- toronto_shelters_clean %>% 
  mutate(occupancy_year = year(occupancy_date, 
                                 label = TRUE, 
                                 abbr = FALSE))

toronto_shelters_clean$occupancy_year <- year(toronto_shelters_clean$occupancy_date)

#there is only one year for all the data though.

toronto_shelters_clean %>% group_by(location_province) %>% 
  summarise(sum(occupied_beds))

