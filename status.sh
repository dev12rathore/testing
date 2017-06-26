#!/bin/bash

USER=cavo2

git diff --no-ext-diff --quiet --exit-code

if [ $? -eq 0 ];
  then
     echo "Git is Look good"
else
     echo -e "Please commit all changes first"
     exit 0
fi

if [ -z "$1" ]
  then
     echo "No VERSION Specify"
     exit 0
else

    read -p "Are you sure you wish to continue tag on git? (y/n)? (Default N)" CONT
       if [[ "$CONT" = "y" || "$CONT" = "Y" || "$CONT" = "yes" || "$CONT" = "YES" || "$CONT" = "Yes" ]]; then
         git tag ${1}
         git push --tags
       fi

fi

# build docker images
     docker build \
       --build-arg version=${1} \
       --build-arg gitbranch=$(git rev-parse --abbrev-ref HEAD) \
       --build-arg githash=$(git rev-parse --short HEAD) \
       -t $USER/testing:${1} -f worker-ui/Dockerfile .
 
if [ $? -eq 0 ];
  then

    read -p "Are you sure you wish to continue push images on docker hub? (y/n)? (Default N)" CONT
       if [[ "$CONT" = "y" || "$CONT" = "Y" || "$CONT" = "yes" || "$CONT" = "YES" || "$CONT" = "Yes" ]]; then
         docker login -u $USER
         docker push $USER/testing:${1}
       fi

else
     echo ""
     echo "docker images is not build"
     echo "Please find error"
     exit 0
fi
