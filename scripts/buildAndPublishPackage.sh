#!/bin/sh

help() {
    echo "Usage: buildAndPublishPackage.sh folder ghtoken mvntoken version"
    exit 2
}

run() {

    cd ./$folder

    echo "Configuring credentials ..."
    scala-cli --power config repositories.credentials maven.pkg.github.com value:PrivateToken "value:${mvntoken}"
    scala-cli --power config publish.credentials maven.pkg.github.com value:PrivateToken "value:${ghtoken}"

    echo "Building ${folder} ..."
    scala-cli --power version
    scala-cli --power compile .
    scala-cli --power test .

    echo "Publishing ..."
    scala-cli --power publish setup . --publish-repository github
    scala-cli --power publish . --publish-repository github --project-version $version

    echo "Done."
}

if [ $# -eq 4 ]; then

    folder=$1
    ghtoken=$2
    mvntoken=$3
    version=$4

    if [ -d "$folder" ]; then
        run
    else
        echo "Failure: Missing folder $folder"
        exit 2
    fi

else
    help
fi
