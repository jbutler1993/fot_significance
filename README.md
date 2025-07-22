> [!IMPORTANT]
> The last version of the Farmer Opinion Tracker run through the significance process was April 2025.

## Cheat Sheet
- [ ] Download the latest version of Farmer Opinion Tracker results
- [ ] Update the response rates in the 'responses' spreadsheet
- [ ] Change _time1_ to the latest iteration
- [ ] Add the last iteration to the _times_ list
- [ ] Verify that no new questions need to be added
- [ ] Run the process
- [ ] Replace the _responses_ spreadsheet within the repository

## Background

The code in fot_twoprop_ztest.R is designed to compare the responses from the [Farmer Opinion Tracker](https://www.gov.uk/government/collections/farmer-opinion-tracker). As we are unable to access the raw data due to sharing agreements, this methods uses the published numbers to compare the responses using a Two-Proportion Z-Test.

A two-proportion z-test assesses if proportions from two groups significantly differ, calculating a z-statistic and standard error to compare their difference against a null hypothesis. Using the proportions of the surveyed population that answered each question, this is designed to look for significant differences between iterations. 

## Setup

The _responses_ spreadsheet will have to be downloaded and updated with the latest responses. This is a manual process of adding a new set of rows to each section and adding in the latest responses to each answer of each question from the latest [timeseries](https://www.gov.uk/government/statistical-data-sets/farmer-opinion-tracker-for-england) once it is received from Farming Statistics. This can take up to thirty minutes.

> [!IMPORTANT]
> Some answers are created by combining others. For instance, 'somewhat positive' and 'very positive' will be combined to 'positive' in order to created a bigger sample and a more general view of the sentiment.

If any new questions need to be added, this can be done at the bottom of the list. 

> [!WARNING]
> All iterations must be present in every question, since R does not understand if listed times are absent when reading from the spreadsheet. If an iteration predates a question, simply enter a zero and ignore them in the output.

Update the filepath within the code to point at the file location for the run.
```
responses <-  read_excel("C:/Users/xxxxxxxx/Downloads/responses.xlsx")
```

You will need to update _time1_ to the latest iteration, which will need to match exactly what the _responses_ spreadsheet says.
```
time1 <- "April 2023"
```

The last iteration (which you will have just replaced in _time1_) needs to be added to the list of _times_.
```
times <- c("October 2022", "April 2022", "October 2021", "April 2021", "October 2020", "September 2019")
```

Any new questions will need to be added to the bottom of the list in the format:

```
for (time in times) {
  fot_significance(time, "question", "answer")}
```

## Running the process

Folllowing setup, the process should simply be a case of hitting 'Run'.

The process in a nutshell:

- Create the base table for output
- Create function for Z-Test
  - Load in time of latest iteration
- Run questions through function
  - Load question
  - Load answer
  - Compare latest iteration to all previous iterations
  - Write results in table
- Export table   

## Export
The process will export a .xlsx to your working directory. This will contain the results of every z-test that has been run including the question, answer, times and p-values. Filter down to the rows where p<0.05 to find the statistically significant results.

Replace the spreadsheet

## Contact

Joe Butler - joseph.butler@defra.gov.uk
