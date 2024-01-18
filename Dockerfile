#Dockerfile for python web app
FROM python:3.9-slim as init-build
RUN mkdir -p /kagajpatra/app/uploads \
    && mkdir /kagajpatra/app/downloads
WORKDIR /kagajpatra
COPY * .
RUN pip install --upgrade pip \
    && pip install -r requirements.txt
CMD ["python", "app.py"]
