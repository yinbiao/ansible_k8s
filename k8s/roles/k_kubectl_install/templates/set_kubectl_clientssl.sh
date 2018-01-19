kubectl config set-cluster default-cluster --server={{ KUBE_MASTER }} --certificate-authority=/data/cert/ca.crt
kubectl config set-credentials default-admin --certificate-authority=/data/cert/ca.crt --client-key=/data/cert/cs_client.key --client-certificate=/data/cert/cs_client.crt
kubectl config set-context default-system --cluster=default-cluster --user=default-admin
kubectl config use-context default-system