# Vault Playground

## Get server up and running
```
git clone git@github.com:ryanckoch/vault-playground.git && \
cd vault-playground && \
./init.sh
```

## Use vault client outside of Docker
```
export VAULT_ADDR="http://127.0.0.1:8200"
vault auth ${VAULT_USER_TOKEN}
vault status
```