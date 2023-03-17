if [ ! -d "../../projects/ " ]; then
  mkdir "../../projects"
fi
if [ ! -d "../../projects/${1} " ]; then
  cd "../../projects/"
  git clone https://github.com/WildCodeSchool/${1}
  cd -
fi

cd "../../projects/${1}"
git pull origin main

PROJECT_NAME=${2} DB_NAME=`echo "${1}" | sed 's/\-/\_/g'` docker compose --env-file ../../traefik/data/.env up -d --build --remove-orphans --force-recreate
