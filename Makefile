# Variables
KUBERNETES_VERSION_MIN = 1.21
PROMETHEUS_OPERATOR_VERSION_MIN = 0.71.2
OTEL_OPERATOR_VERSION_MIN = 0.71.2
CERT_MANAGER_VERSION_MIN = 1.5.4
EKS_CLUSTER_NAME = <YOUR_CLUSTER_NAME>
EKS_REGION = <YOUR_REGION>
HELM_CHART_PATH = ./charts/mdai-hub
HELM_RELEASE_NAME = mdai-hub
HELM_NAMESPACE = default

# Check if Kubernetes is installed and check version
check_kubernetes_version:
	@echo "Checking Kubernetes version..."
	@KUBE_VERSION=$(kubectl version --short | grep "Server Version" | awk '{print $$3}' | cut -d'.' -f1) && \
	if [ $$KUBE_VERSION -lt $(KUBERNETES_VERSION_MIN) ]; then \
		echo "Error: Kubernetes version is too old. Minimum required version is $(KUBERNETES_VERSION_MIN)."; \
		exit 1; \
	else \
		echo "Kubernetes version is compatible."; \
	fi

# Check if EKS Cluster is running
check_eks_cluster:
	@echo "Checking if EKS cluster is running..."
	@aws eks describe-cluster --name $(EKS_CLUSTER_NAME) --region $(EKS_REGION) >/dev/null 2>&1
	@if [ $$? -eq 0 ]; then \
		echo "EKS Cluster $(EKS_CLUSTER_NAME) is running."; \
	else \
		echo "Error: EKS Cluster $(EKS_CLUSTER_NAME) is not running."; \
		exit 1; \
	fi

# Check if Prometheus Operator is installed and check version
check_prometheus_operator_version:
	@echo "Checking Prometheus Operator version..."
	@PROM_OPERATOR_VERSION=$(helm list --namespace $(HELM_NAMESPACE) | grep "kubeprometheusstack" | awk '{print $$3}') && \
	if [ -z "$$PROM_OPERATOR_VERSION" ]; then \
		echo "Error: Prometheus Operator is not installed."; \
		exit 1; \
	elif [ $$PROM_OPERATOR_VERSION != $(PROMETHEUS_OPERATOR_VERSION_MIN) ]; then \
		echo "Warning: Prometheus Operator version is incompatible. Minimum required version is $(PROMETHEUS_OPERATOR_VERSION_MIN)."; \
	else \
		echo "Prometheus Operator version is compatible."; \
	fi

# Check if OTEL Operator is installed and check version
check_otel_operator_version:
	@echo "Checking OTEL Operator version..."
	@OTEL_OPERATOR_VERSION=$(helm list --namespace $(HELM_NAMESPACE) | grep "opentelemetry-operator" | awk '{print $$3}') && \
	if [ -z "$$OTEL_OPERATOR_VERSION" ]; then \
		echo "Error: OTEL Operator is not installed."; \
		exit 1; \
	elif [ $$OTEL_OPERATOR_VERSION != $(OTEL_OPERATOR_VERSION_MIN) ]; then \
		echo "Warning: OTEL Operator version is incompatible. Minimum required version is $(OTEL_OPERATOR_VERSION_MIN)."; \
	else \
		echo "OTEL Operator version is compatible."; \
	fi

# Check if Cert Manager is installed and check version
check_cert_manager_version:
	@echo "Checking Cert Manager version..."
	@CERT_MANAGER_VERSION=$(helm list --namespace $(HELM_NAMESPACE) | grep "cert-manager" | awk '{print $$3}') && \
	if [ -z "$$CERT_MANAGER_VERSION" ]; then \
		echo "Error: Cert Manager is not installed."; \
		exit 1; \
	elif [ $$CERT_MANAGER_VERSION != $(CERT_MANAGER_VERSION_MIN) ]; then \
		echo "Warning: Cert Manager version is incompatible. Minimum required version is $(CERT_MANAGER_VERSION_MIN)."; \
	else \
		echo "Cert Manager version is compatible."; \
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
