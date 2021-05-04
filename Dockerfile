FROM python:3.8.5-alpine

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk update \
    && apk add redis postgresql-dev gcc python3-dev musl-dev
RUN apk add --no-cache jpeg-dev zlib-dev
RUN apk add --no-cache --virtual .build-deps build-base linux-headers \
    && pip install Pillow

RUN pip install --upgrade pip
COPY ./requirements/dev.txt .
RUN pip install -r dev.txt

COPY . .

RUN chmod +x ./entrypoint/dev.sh

ENTRYPOINT ["sh", "./entrypoint/dev.sh"]