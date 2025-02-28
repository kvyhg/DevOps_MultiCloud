# Use a lightweight Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy only dependencies first (for better caching)
COPY requirements.txt .

# Install dependencies in one layer to optimize caching
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose the port Flask runs on
EXPOSE 5000

# Run the application using Gunicorn (better for production)
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
