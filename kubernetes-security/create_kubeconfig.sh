#!/bin/bash
CLUSTER_NAME=$(kubectl config view --minify -o jsonpath='{.contexts[0].context.cluster}')
APISERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
TOKEN=$(kubectl get secret cd-token -n homework -o jsonpath='{.data.token}' | base64 --decode)


# Создаем временный файл конфигурации
cat > kubeconfig-cd.yaml <<EOF
apiVersion: v1
kind: Config
current-context: cd-context
contexts:
- name: cd-context
  context:
    cluster: ${CLUSTER_NAME}
    namespace: homework
    user: cd-user
clusters:
- name: ${CLUSTER_NAME}
  cluster:
    certificate-authority-data: $(kubectl config view --raw -o jsonpath="{.clusters[?(@.name=='${CLUSTER_NAME}')].cluster.certificate-authority-data}")
    server: ${APISERVER}
users:
- name: cd-user
  user:
    token: ${TOKEN}
EOF

