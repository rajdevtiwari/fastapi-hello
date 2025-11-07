FROM python:3.11-slim

WORKDIR /app

# Copy dependency files if present
COPY requirements.txt /app/

# Install dependencies
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Copy the application code
COPY . /app/

# Expose port
EXPOSE 8000

# Run the FastAPI app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
