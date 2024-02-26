#!/bin/bash

# Bring down the docker-compose services
docker-compose down

# Sleep for a brief moment to ensure shutdown is complete
sleep 2

# Bring up the docker-compose services
docker-compose up -d

# Wait for PostgreSQL to become ready
echo "Waiting for PostgreSQL to become ready..."
max_wait=60 # Maximum wait time of 60 seconds
for i in $(seq $max_wait -1 1); do
    # Attempt to connect to PostgreSQL without executing any command
    # Adjust the username and database name as necessary
    docker exec database pg_isready -U postgres  -h localhost -p 5432 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "PostgreSQL is ready!"
        break
    else
        echo -ne "PostgreSQL is not ready yet, waiting $i more seconds...\r"
        sleep 1
    fi
done

if [ $i -eq 1 ]; then
    echo "PostgreSQL did not become ready in time."
    exit 1
fi

# Proceed with your command
docker run -it --rm --network host postgres:latest psql -h localhost -p 5432 -U postgres
