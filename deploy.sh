docker build -t hackerman4047/multi-client:latest -t hackerman4047/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hackerman4047/multi-server:latest -t hackerman4047/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hackerman4047/multi-worker:latest -t hackerman4047/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hackerman4047/multi-client:latest
docker push hackerman4047/multi-server:latest
docker push hackerman4047/multi-worker:latest

docker push hackerman4047/multi-client:$SHA
docker push hackerman4047/multi-server:$SHA
docker push hackerman4047/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hackerman4047/multi-server:$SHA
kubectl set image deployments/client-deployment client=hackerman4047/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hackerman4047/multi-worker:$SHA