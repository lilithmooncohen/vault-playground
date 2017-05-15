#!/bin/bash

set -e

docker-compose up -d vault

sleep 10

docker-compose exec vault vault init > init-secret.txt

VAULT_UNSEAL_KEY_1=$(grep "Unseal Key 1" init-secret.txt | awk '{print $4}')
VAULT_UNSEAL_KEY_2=$(grep "Unseal Key 2" init-secret.txt | awk '{print $4}')
VAULT_UNSEAL_KEY_3=$(grep "Unseal Key 3" init-secret.txt | awk '{print $4}')
VAULT_UNSEAL_KEY_4=$(grep "Unseal Key 4" init-secret.txt | awk '{print $4}')
VAULT_UNSEAL_KEY_5=$(grep "Unseal Key 5" init-secret.txt | awk '{print $4}')
VAULT_INITIAL_ROOT_KEY=$(grep "Initial Root Token" init-secret.txt | awk '{print $4}')

echo "Unsealing Vault:"
docker-compose exec vault vault unseal ${VAULT_UNSEAL_KEY_1}
docker-compose exec vault vault unseal ${VAULT_UNSEAL_KEY_2}
docker-compose exec vault vault unseal ${VAULT_UNSEAL_KEY_3}
docker-compose exec vault vault auth ${VAULT_INITIAL_ROOT_KEY}
docker-compose exec vault vault status

echo "Creating user token"
docker-compose exec vault vault token-create

echo "Have fun!"
