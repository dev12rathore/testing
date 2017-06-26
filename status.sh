#!/bin/bash
USER=cavo2

git diff --no-ext-diff --quiet --exit-code
STATUS=$?

if [ $STATUS -eq 0 ];
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

    VERSION=${1}

    git tag ${VERSION}
    git push --tags

fi

    docker build \
      --build-arg version=${VERSION} \
      --build-arg gitbranch=$(git rev-parse --abbrev-ref HEAD) \
      --build-arg githash=$(git rev-parse --short HEAD) \
      -t $USER/testing:${VERSION} -f worker-ui/Dockerfile .
   
     SaTATUS=$?
     if [ $SaTATUS -eq 0 ];
       then
          docker login -u $USER
          docker push $USER/testing:${VERSION}
     else
          echo ""
          echo "docker images is not build"
          echo "Please find error"
          exit 0
     fi
