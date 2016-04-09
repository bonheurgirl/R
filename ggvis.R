#ggvis
setwd("/Users/anitaowens/Documents/R")
library(ggvis)

#example

faithful %>% 
        ggvis(~waiting, ~eruptions, opacity := 0.6, 
               fill = ~factor(round(eruptions)), shape = ~factor(round(eruptions)), 
               size = ~round(eruptions)) %>% 
        layer_points() %>% 
        add_legend(c("fill", "shape", "size"), 
                     title = "~ duration (m)", values = c(2, 3, 4, 5))
#plot mtcars
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()

#the grammar of graphics
<data>  %>%  ggvis(~<x property>,~<y property>, 
                   fill = ~<fill property>, ...)
                        %>% layer_<marks>()

# change the code below to plot the disp variable of mtcars on the x axis
mtcars %>% ggvis(~disp, ~mpg) %>% layer_points()

# Change the code below to make a graph with red points
mtcars %>% ggvis(~wt, ~mpg, fill := "red") %>% layer_points()

# Change the code below draw smooths instead of points
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths()

#A smooth is a smooth line that summarizes the relationship
#between a set of points.

# Change the code below to make a graph containing both points and a smoothed summary line
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()

# Make a scatterplot of the pressure dataset
pressure %>% ggvis(~temperature, ~pressure) %>% layer_points()

# Adapt the code you wrote for the first challenge: show bars instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_bars()

# Adapt the code you wrote for the first challenge: show lines instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Adapt the code you wrote for the first challenge: map the fill property to the temperature variable
pressure %>% ggvis(~temperature, ~pressure, fill = ~temperature) %>% layer_points()
pressure %>% ggvis(~temperature, ~pressure, fill = ~factor(round(temperature))) %>% layer_points()
pressure %>% ggvis(~temperature, ~pressure) %>% layer_points(fill = ~temperature)

# Extend the code you wrote for the previous challenge: map the size property to the pressure variable
pressure %>% ggvis(~temperature, ~pressure, fill = ~temperature, size = ~pressure) %>% layer_points()
