#!/bin/bash
set -m

if [ $CONTAINER_TYPE = 'app' ]
then
    python manage.py makemigrations
    python manage.py migrate
    echo "DATABASE success"

    python manage.py runserver 0.0.0.0:8000
    echo "RUN started"
fi

exec "$@"