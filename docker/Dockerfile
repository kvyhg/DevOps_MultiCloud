FROM python:3.9-slim

WORKDIR /app

# Copy requirements from the app folder
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
