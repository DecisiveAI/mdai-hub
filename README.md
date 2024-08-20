### install of MDAI without cert-manager
    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs -f values.yaml mdai .

### install of MDAI with cert-manager
    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs --set mdai-operator.webhooks.certManager.enabled=true --set mdai-operator.webhooks.autoGenerateCert.enabled=false -f values.yaml mdai .

### install of MDAI without cleanup on uninstall
    helm upgrade --install --create-namespace --namespace mdai --cleanup-on-fail --dependency-update --wait-for-jobs --set cleanup=false -f values.yaml mdai .

see `values.yaml` for other options.