# SmartHub Quick Start

Install SmartHub with `mdai-cli` when you want a command-line setup path. Octant is available when your team wants a guided UI and API control plane over SmartHub.

## Installation Guide

The published SmartHub installation guide covers prerequisites, supported local setup, values files, and environment-specific installation options:

- [Install the SmartHub Locally](https://docs.mydecisive.ai/installation/)

## Before You Start

Confirm the target environment before installation:

- A Kubernetes cluster is available and selected.
- `kubectl` can reach the intended cluster context.
- `mdai-cli` is installed and configured for the environment.
- The cluster can pull required SmartHub images and dependencies.
- The default namespace and any required values-file overrides match the published installation guide.

For shared or production-oriented environments, use reviewed deployment configuration and approved secret handling. Do not copy local learning-cluster assumptions into a shared environment.

## Fast Path

In a ready Kubernetes environment, install SmartHub with `mdai-cli`:

```shell
kubectl config current-context
mdai install
```

If your environment requires a values file, namespace override, or local learning-cluster setup, follow the command variant in the [SmartHub installation guide](https://docs.mydecisive.ai/installation/) instead of inventing local overrides here.

## Validation

Confirm SmartHub workloads are coming up:

```shell
kubectl get pods --namespace mdai
```

Expected result: SmartHub workloads are running or progressing to ready, and the hub is available for Octant, Kubernetes manifests, or `mdai-cli` operation.

If workloads do not become ready, check Kubernetes events, pod logs, image pull access, dependency readiness, namespace assumptions, and any values-file overrides used during installation.

## Rollback

Use the same control path that installed SmartHub:

1. Revert the reviewed source-control change, or run the documented uninstall or rollback command from the published SmartHub installation guide.
2. Confirm SmartHub workloads, services, and related dependencies are removed or returned to the expected version.
3. Re-run validation before routing production telemetry through the hub.

## Next Steps

After SmartHub is running, choose how users will interact with it:

| Path | Use when |
| --- | --- |
| Octant | Operators need a visual UI and API control plane over SmartHub. |
| Direct manifests | Platform operators need reviewed Kubernetes manifests or GitOps automation. |
| `mdai-cli` | Platform operators need command-line setup using supported SmartHub manifests. |

## Related Pages

- [SmartHub Architecture](architecture.md)
- [SmartHub Documentation](index.md)
- [Development](development.md)
- [Octant](https://github.com/MyDecisive/octant)
