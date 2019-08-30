## NEW AND IMPROVED WITH TIDYVERSE! 2/26/19

# Average over a montage per condition
require(tidyverse)

omni.data <- do.call(rbind,list(
  cond1=cond1.data,
  cond2=cond2.data,
  cond3=cond3.data,
  cond4=cond4.data,
  cond5=cond5.data,
  cond6=cond6.data))

omni.data <- cbind(rw.Names = rownames(omni.data), omni.data) %>% # Turn row.names from the rbind above into a legit column 
  mutate(cond=substr(rw.Names, 1,5)) %>%   # Make new column called "cond" that is simply a substring of the row.Names
  select(-c(rw.Names)) ## VERY IMPORTANT. MUST DROP THIS FIRST COLUMN BECAUSE OTHERWISE IT WILL MESS UP YOUR rowMeans averaging by 1 column

# Get respective montages for condition and cast into one table, per condition
omni.roi <- omni.data %>% 
  select(
    ms, cond,
    roi1,
    roi2,
    roi3) %>% 
  mutate(roi1.ave = rowMeans(omni.data[roi1]),
         roi2.ave = rowMeans(omni.data[roi2]),
         roi3.ave = rowMeans(omni.data[roi3])
  ) %>% 
  select(ms,cond,
         roi1.ave,
         roi2.ave,
         roi3.ave)

# Rename conditions
omni.roi.cond <- omni.roi %>% 
  # select(ms,cond,roi1.L.ave,roi1.R.ave) %>% 
  # mutate(roi.name = roi1.name) %>% 
  gather(key=roi,value=value,roi1.ave:roi3.ave,-cond) %>% 
  mutate(roi.name = case_when(
    str_detect(roi, "roi1") ~ roi1.name,
    str_detect(roi, "roi2") ~ roi2.name,
    str_detect(roi, "roi3") ~ roi3.name,
    TRUE ~ NA_character_
  )) %>% 
  mutate(condition = case_when(
    str_detect(cond, "cond1") ~ "Location Task - Nontarget",
    str_detect(cond, "cond2") ~ "Location Task - Reward",
    str_detect(cond, "cond3") ~ "Location Task - Target",
    str_detect(cond, "cond4") ~ "Object Task - Nontarget",
    str_detect(cond, "cond5") ~ "Object Task - Reward",
    str_detect(cond, "cond6") ~ "Object Task - Target",
    TRUE ~ NA_character_
  ))

task1.table <- omni.roi.cond %>% 
  filter(condition %in% c("Location Task - Nontarget"
                          ,"Location Task - Reward"
                          ,"Location Task - Target")) %>% 
  select(ms,value,roi.name,condition)

task2.table <- omni.roi.cond %>% 
  filter(condition %in% c("Object Task - Nontarget"
                          ,"Object Task - Reward"
                          ,"Object Task - Target")) %>% 
  select(ms,value,roi.name,condition)

