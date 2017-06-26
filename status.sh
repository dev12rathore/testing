git diff --no-ext-diff --quiet --exit-code
STATUS=$?
if [ $STATUS -eq 0 ];
  then
        echo -e "Database is updated"

else
       echo -e "Please commit all cheanges first"
       exit 0
fi

if [ -z "$1" ]
  then
    echo "No VERSION Specify"
else
    echo "$1"
    VERSION=${1}

docker build \
--build-arg version=${VERSION} \
--build-arg gitbranch=$(git rev-parse --abbrev-ref HEAD) \
--build-arg githash=$(git rev-parse --short HEAD) \
-t cavo2/testing:${VERSION} -f worker-ui/Dockerfile . 
    
git tag ${VERSION}
git push --tags
fi
