# BikeWeatherInsights 
├── README.md # Project overview and setup instructions
├── compose.yml # Docker compose file for setting up local environment
├── data_base.sql # SQL database schema
├── data # Data files for analysis
│   ├── JC-2023{01-12}-citibike-tripdata.csv # Monthly trip data from Jan to Dec 2023
│   ├── export.csv # Exported data summary
│   ├── ridership.csv # Ridership statistics
│   └── weather.csv # Weather data correlated with trip data
├── data-dictionaries
│   └── citibike.pdf # Data dictionary for Citibike data
├── my_directory.spec # Specifications for 'my_directory'
├── project_structure.txt # Textual representation of project structure
├── restart.sh # Script to restart the project setup
└── script.ipynb # Jupyter notebook with data analysis scripts

In this project I will load data from CSV files into Pandas DataFrame in order to inspect and clean data for loading 
into PostgreSQL server.
