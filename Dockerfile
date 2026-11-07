FROM python:3.10.6-slim-bullseye

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    ca-certificates \
    ffmpeg \
    git \
    libffi-dev \
    libjpeg-dev \
    libpq-dev \
    libxml2-dev \
    libxslt1-dev \
    mediainfo \
    p7zip-full \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip setuptools wheel \
    && python -m pip install "Cython<3"

COPY requirements.txt /app/requirements.txt

RUN python -m pip install -r /app/requirements.txt

COPY . /app

RUN chmod +x /app/HELL

CMD ["bash", "/app/HELL"]
