# COVID-19 Prognostic Tool
![Introduction au cours R Shiny](https://github.com/universdesdonnees/PredictCovid/blob/main/architecture.png?raw=true)
## About the Project

This project is a R Shiny application developed to predict the clinical outcomes of COVID-19 patients. 
It is based on a study titled "Prognostic factors of coronavirus disease 2019 (COVID-19) patients" which can be found [here](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7571674/). 

This study identifies early prognostic factors upon admission to optimize the management of COVID-19 patients hospitalized in medical wards.

## Getting Started

### Prerequisites

- R (version 3.6.0 or higher)
- RStudio
- Shiny package

### Installation

1. Clone the repo:
   ```sh
   git clone https://github.com/universdesdonnees/PredictCovid.git
   ```
2. Open the project in RStudio and install the required packages:
   ```R
   install.packages("shiny")
   # Add any other packages you need here
   ```

## Usage

Run the application locally by opening the `ui.R` file in RStudio and clicking 'Run App'. 

## Application Structure

- `ui.R`: Defines the user interface where the user inputs their data.
- `server.R`: Contains the server logic to reactively update the outputs based on user input.
- `config.R`: Includes the code that is shared among the `ui.R` and `server.R` files.

## Data

The application uses patient data to predict outcomes based on various parameters such as age, respiratory status, CRP levels, and lymphocyte count. 
The data has been anonymized and aggregated to ensure patient confidentiality.

## Contact
 
- [LinkedIn](https://www.linkedin.com/in/menyssacherifa/) 
- [Email](cmenyssa@live.fr)
- [Personal Website](https://mcherifaluron.com)
