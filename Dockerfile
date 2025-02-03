# Use a more specific Python version
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Copy only requirements first to leverage Docker cache
COPY requirements.txt ./ 

# Install Python dependencies without cache
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application
COPY . ./ 

# Expose port for Flask app (make sure Flask runs on port 80)
EXPOSE 80

# Run your Flask application, listening on all interfaces
CMD ["python", "web.py"]
