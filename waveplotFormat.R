# Refine the format of plots from waveplots.R

## Set your format preferences. Might need to see see plot.raw first to eyeball
lower.volt=-2.50 ### 
upper.volt=5.0 ### 10 for P3, 5.25 for N2/P2
volt.by=0.75 ### How much should voltage limits skip?
wavethick=1.00 ### How thick should the waves be? 1.5 for posters with three lines/conditions
prestimCustom=-200 ###
poststimCustom=400 ###
ms.by=100 ###
# a_time1=70 ### ! Lower bound of time window
# a_time2=120 ### ! Upper bound of time window
# b_time1=150 ### ! Lower bound of time window
# b_time2=300 ### ! Upper bound of time window
electrode = "x ROI" ### Can also replace with factor names

## Change handle of which conditions to plot from waveplots.R

### RAW WAVES
# plot.focus <- plot.raw; effectName <- "LVF Target, RVF Reward during Location Task" # OA LB versions all tasks overlaid
# plot.focus <- plot.raw; effectName <- "LVF Reward, RVF Target during Location Task" # OC LD versions all tasks overlaid

# plot.focus <- plot.raw; effectName <- "LOCATION (LVF Target, RVF Reward during Location Task)" # OA LB versions
# plot.focus <- plot.raw; effectName <- "OBJECT (LVF Target, RVF Reward during Location Task)" # OA LB versions
# plot.focus <- plot.raw; effectName <- "LOCATION (LVF Reward, RVF Target during Location Task)" # OC LD versions
# plot.focus <- plot.raw; effectName <- "OBJECT (LVF Reward, RVF Target during Location Task)" # OC LD versions

### DIFFERENCE WAVES
# plot.focus <- plot.raw; effectName <- "collapse LOCATION TASK EFFECTS (LVF Target during Location Task)" # OA LB versions
# plot.focus <- plot.raw; effectName <- "collapse OBJECT TASK EFFECTS (LVF Target during Location Task)" # OA LB versions

# plot.focus <- plot.raw; effectName <- "collapse LOCATION TASK EFFECTS (LVF Reward during Location Task)" # OC LD versions
# plot.focus <- plot.raw; effectName <- "collapse OBJECT TASK EFFECTS (LVF Reward during Location Task)" # OC LD versions

# plot.focus <- plot.raw; effectName <- "collapse LOCATION TASK EFFECTS " #COLLAPSE version
# plot.focus <- plot.raw; effectName <- "collapse OBJECT TASK EFFECTS " #COLLAPSE version

### ALL WAVES FROM ALL ROIs
# plot.focus <- plot.raw; effectName <- "LOCATION TASK (LVF Target, RVF Reward during Location Task)" # OA LB versions
# plot.focus <- plot.raw; effectName <- "LOCATION TASK (LVF Reward, RVF Target during Location Task)" # OC LD versions

# plot.focus <- plot.raw; effectName <- "OBJECT TASK (LVF Target, RVF Reward during Location Task)" # OA LB versions
# plot.focus <- plot.raw; effectName <- "OBJECT TASK (LVF Reward, RVF Target during Location Task)" # OC LD versions

# plot.focus <- plot.raw; effectName <- "LOCATION TASK" # COLLAPSE version
plot.focus <- plot.raw; effectName <- "OBJECT TASK" # COLLAPSE version


groupSubs = effectName

title=paste(electrode,"\n", 
            # nbSubs, "subjects", "\n", 
            groupSubs, sep=" ") 

#==============================================================================================================================

# Standard themes and formatting added onto basic graph, no need to edit anything here except maybe color palette
# theme_set(theme_grey(base_size = 10))  # Set default font size 

plot.clean <- plot.focus +
  geom_line(size=wavethick) +
  ylab("μV") +
  scale_x_continuous(breaks=seq(prestimCustom,poststimCustom,ms.by), limits=c(prestimCustom,poststimCustom)) +
  scale_y_continuous(breaks=seq(lower.volt,upper.volt,volt.by), limits=c(lower.volt, upper.volt)) +
  # theme(aspect.ratio=.5) + # Makes y-axis half as long as x-axis
  # guides(linetype=F, colour=F) # Remove legend
  ggtitle(title)

plot.bw <- plot.clean + 
  theme_bw(base_size=22) + #theme with white background,  set default font size
  theme(
    plot.background = element_blank()   # eliminate background fill
    ,panel.grid.major = element_blank() # eliminate major gridline background
    ,panel.grid.minor = element_blank() # eliminate major gridline background
    ,panel.border = element_blank() # eliminate chart border
    ,legend.title = element_blank()
    ,aspect.ratio = 0.75 # Ratio of y-axis length to x-axis
    # ,legend.position = "bottom"
  ) +
  theme(axis.line = element_line(colour = "black")) # add axis line

# print(plot.raw)
# print(plot.clean)
print(plot.bw)

#! Save plots as images
ggsave(paste(getwd(),"/pictures/", paste(groupSubs, electrode, sep="-")
             , ".png", sep=""), plot.bw, width=14, height=10)
