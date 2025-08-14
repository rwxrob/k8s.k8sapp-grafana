# DO NOT RUN AS SCRIPT

: "${SECRET_STORE_REF:=vault}"
: "${SECRET_STORE_KEY_PREFIX:=admin/k8s}"

write_secret() {
	local cluster=$1
	local name=$2
	local ns=$3
	if [[ "$cluster" =~ ^test0* ]]; then
		cluster=test
	fi
	test -z "$ns" && ns=default
	cat <<EOF
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
	name: "$name"
	namespace: "$ns"
spec:
	secretStoreRef:
		name: "$SECRET_STORE_REF"
		kind: ClusterSecretStore
	dataFrom:
		- extract:
				key: "$SECRET_STORE_KEY_PREFIX/$cluster"
EOF
}

extract_secrets() {
	local cluster=$1
	local file=$2
	mkdir -p "manifests/$cluster"
	secrets_file="manifests/$cluster/secrets.yaml"
	mapfile -t secret_names < <(yq -N 'select(.kind == "Secret")|.metadata.name' "$file")
	for name in "${secret_names[@]}"; do
		write_secret "$cluster" "$name" >>"$secrets_file"
	done
}
