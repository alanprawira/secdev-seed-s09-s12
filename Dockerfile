FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app ./app
ENV APP_HOST=0.0.0.0 APP_PORT=8080
EXPOSE 8080

CMD ["uvicorn","app.main:app","--host","0.0.0.0","--port","8080"]

HEALTHCHECK --interval=10s --timeout=3s --retries=5 CMD python -c "import urllib.request as u; u.urlopen('http://127.0.0.1:8080/').read()" || exit 1

RUN useradd -m -u 10001 appuser && chown -R appuser:appuser /app
