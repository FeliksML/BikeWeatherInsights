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
- `my_directory.spec`: Specifications for 'my_directory'.
- `project_structure.txt`: Textual representation of the project structure.
- `restart.sh`: Script to restart the project setup.
- `script.ipynb`: Jupyter notebook with data analysis scripts.

### Project Objective 🎯
In this project, we aim to load data from CSV files into Pandas DataFrames to inspect and clean the data before loading it into a PostgreSQL server. This process is critical for ensuring data integrity and usability for analysis.

