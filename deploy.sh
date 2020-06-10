docker build -t dzela/multi-client:latest -t dzela/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dzela/multi-server:latest -t dzela/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dzela/multi-worker:latest -t dzela/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dzela/multi-client:latest
docker push dzela/multi-server:latest
docker push dzela/multi-worker:latest
docker push dzela/multi-client:$SHA
docker push dzela/multi-server:$SHA
docker push dzela/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dzela/multi-client:$SHA
kubectl set image deployments/server-deployment server=dzela/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dzela/multi-worker:$SHA