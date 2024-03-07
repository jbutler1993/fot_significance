> [!IMPORTANT]
> The last version of the Farmer Opinion Tracker run through the significance process was October 2023.

## Cheat Sheet
- [ ] Download the latest version of Farmer Opinion Tracker results
- [ ] Update the response rates in the 'responses' spreadsheet
- [ ] Change _time1_ to the latest iteration
- [ ] Add the last iteration to the _times_ list
- [ ] Verify that no new questions need to be added
- [ ] Run the process
- [ ] Replace the _responses_ spreadsheet within the repository

## Background

The A two-proportion z-test assesses if proportions from two groups significantly differ, calculating a z-statistic and standard error to compare their difference against a null hypothesis.

The release of the Farmer Opinion Tracker can be found at: https://www.gov.uk/government/collections/farmer-opinion-tracker

## Setup

The _responses_ spreadsheet will have to be downloaded and updated with the latest responses. 
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

## Running the process

## Export
Replace the spreadsheet

## Contact

Joe Butler - joseph.butler@defra.gov.uk
