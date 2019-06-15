docker build -t sangkwun/multi-client:latest -t sangkwun/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sangkwun/multi-server:latest -t sangkwun/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sangkwun/multi-worker:latest -t sangkwun/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sangkwun/multi-client:latest
docker push sangkwun/multi-server:latest
docker push sangkwun/multi-worker:latest

docker push sangkwun/multi-client:$SHA
docker push sangkwun/multi-server:$SHA
docker push sangkwun/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sangkwun/multi-server:$SHA
kubectl set image deployments/client-deployment client=sangkwun/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sangkwun/multi-worker:$SHA
