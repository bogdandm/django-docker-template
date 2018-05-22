Template project with postgres, django, nginx, celery and redis.

## Requirements
- python3
- python3-venv
- docker
- docker-compose
- rpl (replace `template_project` in files)

## Usage
- Clone this repo;
- Run `./init.sh` and type your project name. It will rename folders, replace project name in files and reinit git repo;
- edit `.env` if necessary;
- `cd template_project_docker && docker-compose -f docker-compose-dev.yml up`;
- Wait until python requirements are installed;
- Check <http://localhost:8000>;
- Commit created repo.

### Note
Django and Celery containers use virtualenv in mounted volume to speed up build stage. 
Also they use checksum of requirements.txt to run `pip install -U -r requirements.txt;` 
only after `requirements.txt` was changed.