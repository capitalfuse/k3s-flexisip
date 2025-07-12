#!/bin/bash

set -e

# === Secret の作成 ===
echo "=== Creating Secrets ==="

# firebase api
kubectl delete secret secret-firebase-json --ignore-not-found
kubectl create secret generic secret-firebase-json \
  --from-file=/mnt/nfs/flexisip_conf/flexisip-push-notification-firebase-adminsdk-fbsvc-3383e09b3e.json

# lime-server の conf
kubectl delete secret lime-server-conf-secret --ignore-not-found
kubectl create secret generic lime-server-conf-secret \
  --from-file=lime-server.conf

# .env ファイル (環境変数を含む Secret)
kubectl delete secret flexiapi-env-secret --ignore-not-found
kubectl create secret generic flexiapi-env-secret \
  --from-env-file=.env

echo "Secrets created."

# === ConfigMap の作成 ===
echo "=== Creating ConfigMaps ==="

# php.ini
kubectl delete configmap php-ini-config --ignore-not-found
kubectl create configmap php-ini-config \
  --from-file=php.ini=/mnt/nfs/php-fpm_conf/php.ini

echo "ConfigMaps created."

echo "✅ All secrets and configmaps created successfully."

