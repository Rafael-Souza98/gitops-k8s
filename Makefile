setup-cluster:
	@kind create cluster --config=cluster/cluster.yaml
	@kubectl apply -f resources/

down-cluster:
	@kind delete clusters cluster-obs


kube-prometheus:
	@helm upgrade --install -f helm/kube-prometheus-stack/values.yaml kube-prometheus-stack prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace

setup-argocd:
	@kubectl create namespace argocd
	@kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

down-argocd:
	@kubectl delete -n argocd all --all
	@kubectl delete namespace argocd

login-argocd:
	@kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d