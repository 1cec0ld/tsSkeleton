echo $NODE_ENV 
#mount.cifs -o user=$SMB_USER,pass=$SMB_PASS,uid=1000,gid=1000,vers=3.0 $SMB_REQ_HOST /mnt/reqs 
#mount.cifs -o user=$SMB_USER,pass=$SMB_PASS,uid=1000,gid=1000,vers=3.0 $SMB_WATCH_HOST /mnt/watch 
if [ "$NODE_ENV" == "development" ]
then
  nodemon src/index.ts
else
  NODE_PATH=./build node build/index.js
fi