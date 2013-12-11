#!/bin/sh

set -e

#exit 0

if [ ! -d deploy ]; then
  echo "Cloning repository"
  git clone git@github.com:rithis/sberbank-frontend.git deploy 1>&2
fi

cd deploy

echo "Updating sources"
git reset --hard 1>&2
git fetch -a 1>&2
git merge origin/master 1>&2

cd sbrf

echo "Installing dependencies"
npm install 1>&2

echo "Deploing"
cp ../../.ftppass .
rm -rf .cache
grunt deploy 1>&2

echo "Publishing markup"
rm -rf ../../markup
cp -r .build ../../markup
cd ../..
zip -9r markup.zip markup 1>&2
cp markup.zip markup
