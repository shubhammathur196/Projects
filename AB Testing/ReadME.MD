# A/B Testing: Food & Drink Banner Analysis

This repository contains the SQL queries and analysis for the A/B testing project for GloBox. The project evaluates whether displaying a new food & drink banner on the GloBox mobile website impacts conversion rates and average spending.

## Project Overview

In this project, users are randomly assigned to one of two groups:
- **Control Group (Group A):** Users see the standard page without the banner.
- **Test Group (Group B):** Users see the page with the food & drink banner.

The goal is to compare key metrics such as:
- **Conversion Rate:** The percentage of users who make a purchase.
- **Average Spending:** The average amount spent by users.
- **Statistical Significance:** Using a two-proportion z-test to determine if the observed differences are statistically significant.

## Dataset Description

The analysis uses data from a relational database containing the following tables:

- **users:** Contains user demographic information.
  - `id`: The user ID.
  - `country`: ISO 3166 alpha-3 country code.
  - `gender`: The user's gender (M = male, F = female, O = other).

- **groups:** Contains user A/B test group assignments.
  - `uid`: The user ID.
  - `group`: The user’s test group (A or B).
  - `join_dt`: The date the user joined the test.
  - `device`: The device the user visited the page on (I = iOS, A = android).

- **activity:** Contains user purchase activity, with one row per day a purchase is made.
  - `uid`: The user ID.
  - `dt`: Date of purchase activity.
  - `device`: The device type used for the purchase (I = iOS, A = android).
  - `spent`: The purchase amount in USD.
- **Below are the groups in images which shows that the left group had no banners for advertisement and the right one had it.**
![A/B Testing Overview](images/abtesting.jpg)


## Data Access

You can access the GloBox database using the following connection URL:
postgres://Test:bQNxVzJL4g6u@ep-noisy-flower-846766-pooler.us-east-2.aws.neon.tech/Globox



