#Dockerfile for python web app
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --upgrade pip \
    && pip install -r requirements.txt
COPY app app
RUN mkdir -p /app/uploads /app/downloads
CMD ["python", "app/app.py"]
