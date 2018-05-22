#!/usr/bin/env bash

if [ ! -d venv ]; then
    # create venv
    python3 -m venv venv;
fi
source ./venv/bin/activate || { echo "Are you not using venv?" && exit; };
pip install -r requirements.txt

echo "Choose name of your project (A-Za-z0-9_):"
read NAME

PROJECT_PATH=$(pwd)

# === Rename section ===

which rpl > /dev/null || { echo "'rpl' tool not found. Run 'sudo apt-get install rpl' to install it." && exit; };

mv template_project_docker ${NAME}_docker
rpl template_project ${NAME} .env_default

cd src
mv template_project ${NAME}
rpl template_project ${NAME} manage.py

cd ${NAME}
rpl template_project ${NAME} celery.py settings.py wsgi.py

SECRET_KEY=$(python -c "import django.core.management.utils as u; print(u.get_random_secret_key())")
rpl REPLACE_THIS_TO_SECRET_KEY $SECRET_KEY settings.py
unset SECRET_KEY

cd $PROJECT_PATH/${NAME}_docker
rpl template_project ${NAME} docker-compose.yml docker-compose-dev.yml \
    run_celery.sh run_django.sh run_nginx.sh uwsgi.yml;

cd submodules
rpl template_project ${NAME} submodules_rm.sh

cd ../nginx
rpl template_project ${NAME} nginx.conf

# === End rename ===

cd $PROJECT_PATH
cp .env_default .env && echo "'.env' created. Please, paste actual variables values in it."

rm -rf .git
echo "init.sh" >> .gitignore
git init