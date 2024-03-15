if [ -f ../.gitignore ]; then
    echo 'File exists.'
    exit 0
else
    echo 'File does not exist.'
    exit 1
fi
