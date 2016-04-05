#http://www.tatvic.com/r-google-analytics-library/
install.packages("RGoogleAnalytics")

# require(devtools)
devtools::install_github("Tatvic/RGoogleAnalytics")

require(RGoogleAnalytics)

client.id <- "55306401030-06fn296mdemh7n0327htojsesklktd3j.apps.googleusercontent.com"
client.secret <- "2VBin819ZVVtjOkDXUTGX8o6"

# Authorize the Google Analytics account
# This need not be executed in every session once the token object is created 
# and saved
token <- Auth(client.id,client.secret)


# Save the token object for future sessions
save(token,file="./token_file")

# In future sessions it can be loaded by running load("./token_file")

ValidateToken(token)

# Build a list of all the Query Parameters
query.list <- Init(start.date = "2016-03-01",
                   end.date = "2013-03-31",
                   dimensions = "ga:date,ga:pagePath,ga:hour,ga:medium",
                   metrics = "ga:sessions,ga:pageviews",
                   max.results = 10000,
                   sort = "-ga:date",
                   table.id = "ga:33093633")

# Create the Query Builder object so that the query parameters are validated
ga.query <- QueryBuilder(query.list)

# Extract the data and store it in a data-frame
ga.data <- GetReportData(ga.query, token, split_daywise = T, delay = 5)