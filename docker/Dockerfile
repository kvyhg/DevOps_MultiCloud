# Use a Python base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install flask

# Copy the application code
COPY . .

# Expose the port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
