# Plot waves separated by condition for each montage you computed in averages.R

### Customize colors that vary like: Valid darkest, Invalid lightest, Uncued pale
### Reward greens, Nonreward reds, Control oranges
color3 <- c("dodgerblue")
color2 <- c("green4")
color1 <- c("tan2")

# mont.table <- task1.table; linet <- "solid" # Switch
mont.table <- task2.table; linet <- "31"  # Switch

#==============================================================================================================================  
# Add time window of interest (TOI) depending on task and ROI
mont.table <- mont.table %>% 
  mutate(toi_min = case_when(
    str_detect(condition, "Location Task") & str_detect(roi.name, "Frontal") ~ 150,
    str_detect(condition, "Location Task") & str_detect(roi.name, "Dorsal") ~ 150,
    str_detect(condition, "Location Task") & str_detect(roi.name, "Ventral") ~ 150,
    str_detect(condition, "Object Task") & str_detect(roi.name, "Frontal") ~ 150,
    str_detect(condition, "Object Task") & str_detect(roi.name, "Dorsal") ~ 230,
    str_detect(condition, "Object Task") & str_detect(roi.name, "Ventral") ~ 230,
    TRUE ~ NA_real_
  )) %>% 
  mutate(toi_max = case_when(
    str_detect(condition, "Location Task") & str_detect(roi.name, "Frontal") ~ 300,
    str_detect(condition, "Location Task") & str_detect(roi.name, "Dorsal") ~ 220,
    str_detect(condition, "Location Task") & str_detect(roi.name, "Ventral") ~ 220,
    str_detect(condition, "Object Task") & str_detect(roi.name, "Frontal") ~ 300,
    str_detect(condition, "Object Task") & str_detect(roi.name, "Dorsal") ~ 300,
    str_detect(condition, "Object Task") & str_detect(roi.name, "Ventral") ~ 300,
    TRUE ~ NA_real_
  ))


require(reshape)
d2 <- melt(mont.table, id=c("ms","roi.name","condition", "toi_min","toi_max")) 
d2$roi.name = factor(d2$roi.name, levels=c('Frontal','Dorsal','Ventral')) # Change order for facets

require(ggplot2)

# Basic graph showing ALL conditions
plot.raw <- 
  ggplot(d2, aes(x=ms, y=value, 
                 colour=condition # Color will vary with RP (Reward green, Nonreward red, Control tan)
                 ,linetype=condition # Linetype will vary with Stimulus (Target solid, Distractor broken)
  )
  ) + 
  geom_hline(yintercept=0) + geom_vline(xintercept=0) + ##! Moved from plot.clean ## yintercept and xintercept are now the args, not just "x" or "y"
  geom_line() +
  scale_colour_manual(values=c(rep(color1,1), 
                               rep(color2,1),
                               rep(color3,1)
                               # rep(color1,1), 
                               # rep(color2,1),
                               # rep(color3,1)
  )) + 
  scale_linetype_manual(values = c(rep(linet,3)
                                   # , rep("31",3)
                                   # , rep("solid",3)
                                   # , rep("31",3)
                                   # , rep("solid",3)
                                   # , rep("31",3)
  )
  ) +
  facet_grid(roi.name ~ .) +
  geom_rect(data=d2,
            aes(x=NULL,y=NULL,xmin=toi_min,xmax=toi_max,ymin=-Inf,ymax=Inf)
            , fill = "grey90"
            , alpha = 0.025 # Translucent fill
            , colour=alpha("grey",0) # Remove bold outline by setting to transparent
  ) 

print(plot.raw)
