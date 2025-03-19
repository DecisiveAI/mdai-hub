# Variables
KUBERNETES_VERSION_MIN = 1.21
PROMETHEUS_OPERATOR_VERSION_MIN = 0.71.2
OTEL_OPERATOR_VERSION_MIN = 0.117.0
CERT_MANAGER_VERSION_MIN = 1.10.1
EKS_CLUSTER_NAME ?= Foo
EKS_REGION ?= us-east-1
HELM_CHART_PATH = ./charts/mdai-hub
HELM_RELEASE_NAME = mdai-hub
HELM_NAMESPACE ?= mdai

# Check if Kubernetes is installed and check version
check_kubernetes_version:
	@echo "Checking Kubernetes version..."
	@K8S_VERSION=$$(kubectl version 2>/dev/null | grep Server | awk '{print $$3}' | sed 's/^v//'); \
	if [ -z "$$K8S_VERSION" ]; then \
		echo "❌ Error: Unable to fetch Kubernetes version. Is your cluster running and accessible?"; \
		exit 1; \
	fi; \
    if [ "$$(printf '%s\n' "$(KUBERNETES_VERSION_MIN)" "$$K8S_VERSION" | sort -V | head -n1)" = "$(KUBERNETES_VERSION_MIN)" ]; then \
      echo "✅ Kubernetes version ($$K8S_VERSION) is sufficient."; \
    else \
      echo "❌ Kubernetes version ($$K8S_VERSION) is too old. Required: $(KUBERNETES_VERSION_MIN)."; \
      exit 1; \
    fi

# Check if EKS Cluster is running
check_eks_cluster:
	@echo "Checking if EKS cluster is running..."
	@aws eks describe-cluster --name $(EKS_CLUSTER_NAME) --region $(EKS_REGION) >/dev/null 2>&1
	@if [ $$? -eq 0 ]; then \
		echo "✅ EKS Cluster $(EKS_CLUSTER_NAME) is running."; \
	else \
		echo "❌ Error: EKS Cluster $(EKS_CLUSTER_NAME) is not running."; \
		exit 1; \
	fi

# Check if Prometheus Operator is installed and check version
check_prometheus_operator_version:
	@echo "Checking Prometheus Operator version..."
	@PROMETHEUS_OPERATOR_VERSION=$$(kubectl get crd prometheuses.monitoring.coreos.com -o jsonpath='{.metadata.annotations.operator\.prometheus\.io/version}') && \
	if [ -z "$$PROMETHEUS_OPERATOR_VERSION" ]; then \
		echo "❌ Error: Prometheus Operator is not installed."; \
		exit 1; \
	elif [ "$$(printf '%s\n' "$(PROMETHEUS_OPERATOR_VERSION_MIN)" "$$PROMETHEUS_OPERATOR_VERSION" | sort -V | head -n1)" = "$(PROMETHEUS_OPERATOR_VERSION_MIN)" ]; then \
		echo "✅ Prometheus Operator version ($$PROMETHEUS_OPERATOR_VERSION) is compatible."; \
	else \
		echo "❌ Prometheus Operator version ($$PROMETHEUS_OPERATOR_VERSION) is incompatible. Minimum required version is $(PROMETHEUS_OPERATOR_VERSION_MIN)."; \
	fi

# Check if OTEL Operator is installed and check version
check_otel_operator_version:
	@echo "Checking OTEL Operator version..."
	@OTEL_OPERATOR_VERSION=$$(kubectl get deployment -n mdai opentelemetry-operator -o jsonpath='{.spec.template.spec.containers[0].image}' | tr -d '\n' | grep -v '^$$' | cut -d':' -f2) && \
	if [ -z "$$OTEL_OPERATOR_VERSION" ]; then \
		echo "Error: OTEL Operator is not installed."; \
		exit 1; \
	elif [ "$$(printf '%s\n' "$(OTEL_OPERATOR_VERSION_MIN)" "$$OTEL_OPERATOR_VERSION" | sort -V | head -n1)" = "$(OTEL_OPERATOR_VERSION_MIN)" ]; then \
		echo "✅ OTEL Operator version ($$OTEL_OPERATOR_VERSION) is compatible."; \
	else \
		echo "❌ OTEL Operator version ($$OTEL_OPERATOR_VERSION) is incompatible. Minimum required version is $(OTEL_OPERATOR_VERSION_MIN)."; \
	fi

# Check if Cert Manager is installed and check version
check_cert_manager_version:
	@echo "Checking Cert Manager version..."
	@CERT_MANAGER_VERSION=$$(kubectl get crd clusterissuers.cert-manager.io -o jsonpath='{.metadata.labels.app\.kubernetes\.io/version}' | tr -d '\n' | grep -v '^$$' | sed 's/^v//'); \
	if [ -z "$$CERT_MANAGER_VERSION" ]; then \
		echo "Error: Cert Manager is not installed."; \
		exit 1; \
	elif [ "$$(printf '%s\n' "$(CERT_MANAGER_VERSION_MIN)" "$$CERT_MANAGER_VERSION" | sort -V | head -n1)" = "$(CERT_MANAGER_VERSION_MIN)" ]; then \
		echo "✅ Cert Manager version ($$CERT_MANAGER_VERSION) is compatible."; \
	else \
		echo "❌ Cert Manager version ($$CERT_MANAGER_VERSION) is incompatible. Minimum required version is $(CERT_MANAGER_VERSION_MIN)."; \
	fi

# Run all preflight checks
preflight_check: check_kubernetes_version check_eks_cluster check_prometheus_operator_version check_otel_operator_version check_cert_manager_version
	@echo "Preflight check passed successfully. All versions are compatible."

# Install the Helm chart
install_helm_chart:
	@echo "Installing Helm chart..."
	@helm upgrade --install $(HELM_RELEASE_NAME) $(HELM_CHART_PATH) --namespace $(HELM_NAMESPACE) --values values.yaml

# Uninstall the Helm chart
uninstall_helm_chart:
	@echo "Uninstalling Helm chart..."
	@helm uninstall $(HELM_RELEASE_NAME) --namespace $(HELM_NAMESPACE)

.PHONY: check_kubernetes_version check_eks_cluster check_prometheus_operator_version check_otel_operator_version check_cert_manager_version preflight_check install_helm_chart uninstall_helm_chart
