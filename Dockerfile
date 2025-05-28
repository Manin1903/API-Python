# Use a lightweight Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && apt-get clean

# Copy requirements.txt and install Python dependencies
COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY ./entrypoint.sh .

# Copy application code to the container
COPY . .

# Expose the application port
EXPOSE 8000

#Execute Entrypoint when container is made
RUN ["chmod", "+x", "entrypoint.sh"]
ENTRYPOINT [ "./entrypoint.sh" ]
