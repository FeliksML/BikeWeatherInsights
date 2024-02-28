# Bike Rental Data Management 📊 🚲
## Project Structure 🧬

This project is structured as follows:

- `README.md`: Project overview and setup instructions.
- `compose.yml`: Docker compose file for setting up the local environment.
- `data_base.sql`: SQL database schema.
- `data/`: Directory containing data files for analysis.
    - `JC-2023{01-12}-citibike-tripdata.csv`: Monthly trip data from Jan to Dec 2023.
    - `export.csv`: Exported data summary.
    - `ridership.csv`: Ridership statistics.
    - `weather.csv`: Weather data correlated with trip data.
- `data-dictionaries/`:
    - `citibike.pdf`: Data dictionary for Citibike data.
- `restart.sh`: Script to restart the project setup.
- `script.ipynb`: Jupyter notebook with data analysis scripts.

### Project Objective 🎯
In this project, I aimed to process data from CSV files by loading it into Pandas DataFrames for a thorough inspection and cleanup. My objective was to ensure the data's integrity and readiness for analysis. After refining the data, I proceeded to craft a Docker-compose file, deploying a streamlined PostgreSQL server within a Docker container. This step was crucial for transitioning the cleaned CSV data into a SQL database, setting the stage for in-depth analysis and enabling the creation of detailed reports for further insights.

I chose to utilize Docker and PostgreSQL for their efficiency and reliability, aiming to build a dependable data analysis foundation. This project was a solo endeavor, reflecting my commitment to applying practical tools and techniques to enhance data processing workflows, ensuring the data is reliable and actionable.

The two SQL views created, rides_per_day and rpd_grouped_by_tavg, serve to summarize and analyze bike ride data in relation to weather conditions, specifically focusing on the average duration and total number of rides per day.

📈 The rides_per_day view compiles data on all bike rides, grouped by date, and enriches this data with weather information such as average temperature and precipitation. This allows for an analysis of how daily weather conditions might affect the length and frequency of bike rides, offering insights into rider behavior under different weather scenarios.

📈 The second view, rpd_grouped_by_tavg, takes a more granular approach by categorizing days into temperature groups. This classification ranges from 'Negative to 5' degrees Celsius up to '25+' degrees, providing an average ride duration and count within these temperature ranges. This view is particularly useful for identifying trends in ride durations and volumes across different temperature bands, enabling a nuanced understanding of temperature impacts on cycling activity.

