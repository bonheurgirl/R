#Statistical Segmentation

# Load text file into local variable called 'data'
data = read.delim(file = 'purchases.txt', header = FALSE, sep = '\t', dec = '.')

# Add headers and interpret the last column as a date, extract year of purchase
colnames(data) = c('customer_id', 'purchase_amount', 'date_of_purchase')
data$date_of_purchase = as.Date(data$date_of_purchase, "%Y-%m-%d")
data$days_since       = as.numeric(difftime(time1 = "2016-01-01",
                                            time2 = data$date_of_purchase,
                                            units = "days"))
library(sqldf)
library(dplyr)

distinct(data)
# Compute recency, frequency, and average purchase amount
customers = sqldf("SELECT customer_id,
                  MIN(days_since) AS 'recency',
                  COUNT(*) AS 'frequency',
                  AVG(purchase_amount) AS 'amount'
                  FROM data GROUP BY 1")
# Copy customer data into new data frame
new_data = customers

# Remove customer id as a variable, store it as row names
row.names(new_data) = new_data$customer_id
new_data$customer_id = NULL


# Take the log-transform of the amount, and plot
new_data$amount = log(new_data$amount)
hist(new_data$amount)

#take the log of frequency and plot
hist(new_data$frequency)
new_data$frequency=log(new_data$frequency)
hist(new_data$frequency, main="histogram of new_data with log of frequency")

# Standardize variables
new_data = scale(new_data)

# Compute distance metrics on standardized data
# This will likely generate an error on most machines
# d = dist(new_data)

# Take a 10% sample
sample = seq(1, 18417, by = 10)
head(sample)
customers_sample = customers[sample, ]
new_data_sample  = new_data[sample, ]

# Compute distance metrics on standardized data
d = dist(new_data_sample)

# Perform hierarchical clustering on distance metrics
c = hclust(d, method="ward.D2")

# Plot de dendogram
plot(c)

# Cut at 5 segments
members = cutree(c, k = 5)

# Show 30 first customers, frequency table
members[1:30]
table(members)

# Show profile of each segment
aggregate(customers_sample[, 2:4], by = list(members), mean)

#What is the size of the largest segment?
555

#What is the average purchase amount
#of the segment which contains, on average,
#the customers who have made their last
#purchase the most recently?"""
38.29947

#Of the five following criteria to determine
#the best number of segments, which one is the
#least relevant?
Group 1 since the average time since last purchase was 2657 days (over 10 years ago).


#Does customer #260 belongs to the same segment than customer #5920?
#running error-out of bounds
new_data_sample[c(260,5920),]
new_data_sample[260,]

Answer: No, they belong to different segments.

260  2.27194014 -0.85366742 -1.13881000
5920 1.14196306  0.92424444  3.12317569

#5. Looking at the average profile of segment 1,
#would you say that members of this segment are
#typically...

Answers: Customers with poor prospects in terms of loyalty and profitability, due to the few purchases they have made so far
