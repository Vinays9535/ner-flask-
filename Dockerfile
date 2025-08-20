FROM python:3.11-slim

# Install system deps needed by spaCy
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# copy Python requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# download spaCy model
RUN python -m spacy download en_core_web_sm

# copy app
COPY . .

EXPOSE 8010

ENV FLASK_APP=app.py
CMD ["gunicorn", "--bind", "0.0.0.0:8010", "app:app", "--workers", "1"]
