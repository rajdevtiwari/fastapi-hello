# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install runtime deps
COPY pyproject.toml poetry.lock* /app/ 2>/dev/null || true
COPY requirements.txt /app/ 2>/dev/null || true

# Fallback: pip install if requirements.txt exists
RUN apt-get update && apt-get install -y --no-install-recommends gcc build-essential \
    && rm -rf /var/lib/apt/lists/*

# If you have requirements.txt:
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

# Expose port used by app
ENV PORT=8000
EXPOSE 8000

# Run uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
