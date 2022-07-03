gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --zone $(terraform output -raw zone) --project $(terraform output -raw project)
kubectl run nginx --namespace default --image=nginx:1.10.0
kubectl expose pod nginx --namespace=default --type=LoadBalancer --port=80
kubectl get service --watch