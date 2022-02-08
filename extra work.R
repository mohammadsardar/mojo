#general rough work

onetoronto_shelters_clean <- 
  clean_names(toronto_shelters) %>% 
  select(occupancy_date, id, occupied_beds, location_city, capacity_actual_bed)

onetoronto_shelters_clean <- onetoronto_shelters_clean %>% 
  mutate(occupancy_month = month(occupancy_date, 
                                 label = TRUE, 
                                 abbr = FALSE))

onetoronto_shelters_clean <- onetoronto_shelters_clean %>% 
  filter(capacity_actual_bed != "NaN")
head(onetoronto_shelters_clean
     )


onetoronto_shelters_clean$capacity_actual_bed <- as.numeric(onetoronto_shelters_clean$capacity_actual_bed)

onetoronto_shelters_clean %>% 
  group_by(occupancy_month)%>%
  summarise(n = mean(capacity_actual_bed)) %>% 
  kable(caption = "Rate of Homeless shelter usage in Toronto in 2021", 
        col.names = c("Month", "Average Proportion of beds available that were occupied"),
        digits = 1,
        booktabs = TRUE,
        linesep = ""
  )

write_csv(
  x = onetoronto_shelters_clean, 
  file = "bedscleaned_toronto_shelters.csv"
)
