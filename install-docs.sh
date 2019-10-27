#!/usr/bin/env bash

usage() {
    echo "Usage:"
    echo "  install-docs.sh 'target dir' 'target_file'"
    echo ""
    echo "Options:"
    echo "  target_dir:"
    echo "    target directory name for installing components to display in swagger ui."
    echo "  target_file:"
    echo "    target file name for display swgger api file in swagger ui."
}

if [ $# -ne 2 ]; then
    usage
    exit 1
fi

target_dir=$1
target_file=$2

if [ ! -e ${target_dir}/docs ]; then
    echo "creating target directory: " ${target_dir}/docs
    mkdir -p ${target_dir}/docs
fi

# install swagger ui and update index.html
git clone https://github.com/swagger-api/swagger-ui.git
cd swagger-ui
git pull
cd ..

echo "coping swagger-ui components..."
cp -r swagger-ui/dist/* ${target_dir}/docs/.

echo "update index.html..."
sed -i'.back' \
    -e "s|url: \"https://petstore.swagger.io/v2/swagger.json\"|url: \"${target_file}\"|" ${target_dir}/docs/index.html

echo "complete!"
