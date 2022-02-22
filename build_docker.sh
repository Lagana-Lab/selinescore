tag=`git rev-parse --short HEAD`
echo BUILDING: sinaiiidgst/selinescore:$tag
docker build -t sinaiiidgst/selinescore:${tag} .
docker push sinaiiidgst/selinescore:${tag}