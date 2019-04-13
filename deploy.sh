docker build -t melissabeff/multi-client:latest -t melissabeff/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t melissabeff/multi-server:latest -t melissabeff/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t melissabeff/multi-worker:latest -t melissabeff/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push melissabeff/multi-client:latest
docker push melissabeff/multi-server:latest
docker push melissabeff/multi-worker:latest
docker push melissabeff/multi-client:$GIT_SHA
docker push melissabeff/multi-server:$GIT_SHA
docker push melissabeff/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubeclt set image deployments/server-deployment server=melissabeff/multi-server:$GIT_SHA
kubeclt set image deployments/client-deployment client=melissabeff/multi-client:$GIT_SHA
kubeclt set image deployments/worker-deployment worker=melissabeff/multi-worker:$GIT_SHA
