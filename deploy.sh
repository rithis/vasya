#!/bin/sh

if [ ! -d deploy ]; then
  git clone git@github.com:rithis/sberbank-frontend.git deploy
fi

cp .ftppass deploy

cd deploy

git reset --hard
git pull origin master

npm install

grunt deploy

cd .tmp
rm -rf ../../markup
cp -r markup ../..
zip -9r markup.zip markup
cp markup.zip ../../markup
