#http://www.r-statistics.com/2014/08/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/

library(babynames) # data package
library(dplyr)     # provides data manipulating functions.
library(magrittr)  # ceci n'est pas un pipe
library(ggplot2)   # for graphics

babynames %>%
        filter(name %>% substr(1, 3) %>% equals("Ani")) %>%
        group_by(year, sex) %>%
        summarize(total = sum(n)) %>%
        qplot(year, total, color = sex, data = ., geom = "line") %>%
        add(ggtitle('Names starting with "Ani"')) %>%
        print