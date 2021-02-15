docker build -t ryancraigdavis/multi-client:latest -t ryancraigdavis/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ryancraigdavis/multi-server:latest -t ryancraigdavis/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ryancraigdavis/multi-worker:latest -t ryancraigdavis/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ryancraigdavis/multi-client:latest
docker push ryancraigdavis/multi-server:latest
docker push ryancraigdavis/multi-worker:latest
docker push ryancraigdavis/multi-client:$SHA
docker push ryancraigdavis/multi-server:$SHA
docker push ryancraigdavis/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ryancraigdavis/multi-server:$SHA
kubectl set image deployments/client-deployment client=ryancraigdavis/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ryancraigdavis/multi-worker:$SHA
