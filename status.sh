git diff --no-ext-diff --quiet --exit-code
STATUS=$?
if [ $STATUS -eq 0 ];
  then
        echo -e "Database '$DBNAME' is created"

else
       echo -e "Failed to create database '$DBNAME'"
fi

