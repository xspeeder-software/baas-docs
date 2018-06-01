rm -fr docs
mv _book docs 
git add .
git commit -m "deploy gitbook"
git push origin master
pause
