#ggvis
setwd("/Users/anitaowens/Documents/R")
library(ggvis)

#plot mtcars
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points()

#the grammar of graphics
<data>  %>%  ggvis(~<x property>,~<y property>, 
                   fill = ~<fill property>, ...)
                        %>% layer_<marks>()


