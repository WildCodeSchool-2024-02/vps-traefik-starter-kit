#Stop all mailhog containers for better performance
docker container stop $(docker container ls -q --filter name=mailhog)

#Create projects directory if not exists
if [ ! -d "../../projects/ " ]; then
  mkdir "../../projects"
fi

#Clone the repository if not exists
if [ ! -d "../../projects/${1} " ]; then
  cd "../../projects/"
  git clone https://github.com/WildCodeSchool/${1}
  cd -
fi

#Update main branch
cd "../../projects/${1}"
git checkout main
git pull origin main

#Build and start Docker container and their services
PROJECT_NAME=${2} DB_NAME=`echo "${1}" | sed 's/\-/\_/g'` docker compose --env-file ../../traefik/data/.env up -d --build --remove-orphans --force-recreate

#Restart mailhog containers
docker container restart $(docker container ls -qa --filter name=mailhog)