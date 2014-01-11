#!/bin/bash

# Sacado de http://stackoverflow.com/questions/15214762/how-can-i-sync-documentation-with-github-pages
mkdir _layouts
mv index.html _layouts/
git checkout master -- README.md
mv README.md index.md
echo -e "---\nlayout: index\n---" |cat - index.md > /tmp/out && mv /tmp/out index.md
echo "Remember to edit now index.html"

#inspirado por http://stackoverflow.com/questions/8467424/echo-new-line-in-bash-prints-literal-n