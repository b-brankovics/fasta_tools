if [ -z "$1" ];
    then echo "no message was set"
else
    git add .
    git commit -m "$1"
    git push
    git checkout master
    git checkout dev README.md
    git commit -m "$1"
    git push
    git checkout dev
fi
