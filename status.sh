git diff --no-ext-diff --quiet --exit-code
STATUS=$?
if [ $STATUS -eq 0 ];
  then
        echo -e "Database is updated"

else
       echo -e "Please commit all cheanges first"
       exit 0
fi

ls -l

