docker build -t pratikshitsingh/multi-client:latest -t pratikshitsingh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pratikshitsingh/multi-server:latest -t pratikshitsingh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pratikshitsingh/multi-worker:latest -t pratikshitsingh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pratikshitsingh/multi-client: latest
docker push pratikshitsingh/multi-server: latest
docker push pratikshitsingh/multi-worker: latest

docker push pratikshitsingh/multi-client:$SHA
docker push pratikshitsingh/multi-server:$SHA
docker push pratikshitsingh/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/client-deployment client=pratikshitsingh/multi-client:$SHA
kubectl set image deployments/server-deployment server=pratikshitsingh/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pratikshitsingh/multi-worker:$SHA