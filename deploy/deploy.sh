#!/bin/sh
cd $TRAVIS_BUILD_DIR/target
ssh travis@scalalaz.ru 'cd trello_shownote_target/ && rm -rf devzen-shownote-generator-1.0.zip'
rsync -r universal/* travis@scalalaz.ru:/home/travis/trello_shownote_target

# kill old process if exist
ssh travis@scalalaz.ru 'ps -ef | grep devzen-shownote-generator | grep -v grep | awk '\''{print $2}'\'' | xargs kill -9'

# clear
ssh travis@scalalaz.ru 'cd trello_shownote_target/ && rm -rf devzen-shownote-generator-1.0/'

# unzip
ssh travis@scalalaz.ru 'cd trello_shownote_target/ && unzip devzen-shownote-generator-1.0.zip'

# exec
ssh travis@scalalaz.ru << EOF
cd trello_shownote_target/devzen-shownote-generator-1.0/
nohup bin/devzen-shownote-generator > /dev/null 2>&1 &
EOF
