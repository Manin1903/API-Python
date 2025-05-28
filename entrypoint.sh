#!/bin/bash

echo "Migrating"
python manage.py showmigrations
python manage.py migrate
echo "Seeding Dummy Data" #Optional for data seeding
python manage.py load_fixtures fixtures/ #Optional for data seeding
echo "Collecting static files"
python manage.py collectstatic --noinput
echo "Run App"
gunicorn --bind 0.0.0.0:8000 <your-app>.wsgi:application
exec"$@"
