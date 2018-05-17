rm -fr docs
gitbook build .
mv _book docs
git add .
git commit -am "deploy gitbook `date +%Y-%m-%d" "%H:%M:%S`"
git push origin master


