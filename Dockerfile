# Use the official Python image as a base image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir poetry

COPY . /app/

RUN poetry config virtualenvs.create false && poetry install --only main --no-interaction

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
