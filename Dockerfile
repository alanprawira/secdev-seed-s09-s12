FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

ENV APP_HOST=0.0.0.0 APP_PORT=8080

EXPOSE 8080

# Create user first
RUN useradd -m -u 10001 appuser && chown -R appuser:appuser /app

# HEALTHCHECK should come BEFORE CMD and use the correct health endpoint
HEALTHCHECK --interval=10s --timeout=3s --start-period=15s --retries=3 \
    CMD curl -f http://localhost:8080/healthz || exit 1

# Switch to non-root user and run app
USER appuser
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]