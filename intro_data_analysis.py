# -*- coding: utf-8 -*-
"""
Created on Thu Dec 24 00:05:51 2015

@author: anitaowens

This page contains documentation for Python's
csv module. Instead of csv, you'll be using 
unicodecsv in this course. unicodecsv works 
exactly the same as csv, but it comes with 
Anaconda and has support for unicode. 
The csv documentation page is still the
best way to learn how to use the unicodecsv
library, since the two libraries work
exactly the same way.
"""

import unicodecsv

enrollments = []
f = open('enrollments.csv', 'rb')
reader=unicodecsv.DictReader(f)

for row in reader:
        enrollments.append(row)
        
f.close()

enrollments[0]


#alternate (the file will automatically close after the for loop)
import unicodecsv

enrollments = []
with open('enrollments.csv', 'rb') as f:
    reader=unicodecsv.DictReader(f)

    for row in reader:
        enrollments.append(row)

enrollments[0]

#reading in csv file using reader function
import unicodecsv
enrollments_filename = '/datasets/ud170/udacity-students/enrollments.csv'

with open('enrollments.csv', 'rb') as f:
    reader=unicodecsv.DictReader(f)
    enrollments=list(reader)

#reading in daily engagement file
import unicodecsv
engagement_filename = '/datasets/ud170/udacity-students/daily_engagement.csv'
with open('daily_engagement.csv', 'rb') as f:
    reader=unicodecsv.DictReader(f)
    daily_engagement=list(reader)
    
#
import unicodecsv
submissions_filename = '/datasets/ud170/udacity-students/project_submissions.csv'
with open('project_submissions.csv', 'rb') as f:
    reader=unicodecsv.DictReader(f)
    project_submissions=list(reader)