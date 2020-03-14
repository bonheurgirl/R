#	                         Men	Women
Expressed a Fear of Heights	 68	109
Did Not Express Fear of Heights  94	89

#What fraction represents the proportion of people in the study that were afraid of heights?

177/360

#How many simple events (outcomes) were possible for participants in this study?
4

#Of those participants that were afraid of heights, what percentage were men? (Round to 1 decimal place with no % sign.)
round((68/177) * 100, digits=1)

#What percentage of women were afraid of heights? (Round to 1 decimal place with no % sign.)
round((109/198) * 100, digits=1)

#What percentage of all participants were not afraid of heights? (Round to 1 decimal place with no % sign.)
round((183/360) * 100, digits=1)

#Below is a contingency table showing data from a University of Texas Southwestern Medical Center study on Hepatitis C.
#What was the total number of participants in this study?


        parlor  elsewhere  no tatoo   total
hep      17        8          18        43
no hep   35        53         495       583
total    52        61         513       626

#What was the marginal distribution for Hepatitis status in this study?
#43 had hepatitis, 583 did not

#Overall, what percentage of participants had a tattoo? ( Round to 1 decimal place and do not include % sign.)
tatoo<-17+35+8+53
tatoo

notatoo<-18+495
notatoo

round((tatoo/total) * 100, digits = 1)

#What percentage of those participants with Hepatitis C had a tattoo done in a commercial parlor? (Round to 1 decimal and do not include % sign.)
comm<-17
withhep<-43

comm/withhep * 100

#6) What percentage of those who had a tattoo done in a commercial parlor have Hepatitis C? (Round to 1 decimal and do not include % sign.)
parlor<-52

round(17/52 * 100, digits = 1)

#Calculate the probability that a randomly selected participant from the study would have Hepatitis C:
round(43/626, digits = 3)

#no hep probability
round(583/626, digits=3)

a<-43/626
b<-583/626
a+b

#       	Red	Black/White/Silver	Other   total
Married	        40	22	                19      81
Unmarried	45	10	                12      67

total           85      32                      31      148  

#P (black/white/silver)
round(32/148, digits = 3)
#[1] 0.216

#P (married)
round(81/148, digits = 3)
#[1] 0.547

#P (unmarried and black/white/silver car)
round(10/148, digits = 3)

#) P (red car | married)
round(40/81, digits = 3)

#P (married | red car)
round(40/85, digits = 3)
#[1] 0.471

#What ratio would you use to solve for P(red car| unmarried) using the contingency table?
45/67

#Now solve for P (red car | unmarried) using the formula below. (Probabilities should be reported as proportions rounded to 3 decimal places.)
round(45/67, digits = 3)

#p just unmarried
round(67/148, digits = 3)

#p red car & unmarried
round(45/148, digits = 3)


# P (red)
round(85/148, digits = 3)
# 0.574

#P (red | married)
round(40/81, digits = 3)
#[1] 0.494

# P (red | unmarried)
round (45/67, digits = 3)
#[1] 0.672

# If car color and marital status are independent, what should be true?
#P(red) = P(red | married) i think?

#We determine both our marginal and our conditional
#distributions for that variable of interest, and then
#we compare those probabilities.  if those values don't
#come close to matching, then we have a relationship between
#our 2 categorical variables.

#If car color and marital status are independent, what should be true?
P(red) = P(red | married) 

#Do car color and marital status appear to be independent?
# No, because the probability of having a red car is different for married and unmarried people, though the difference is small.
