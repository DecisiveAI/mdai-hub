# SmartHub Documentation

SmartHub documentation helps platform teams install, operate, and understand the SmartHub telemetry platform. Octant provides a guided UI and API control plane for teams that prefer not to manage the chart or command-line setup directly.

## Source of Truth

The primary SmartHub documentation is [docs.mydecisive.ai](https://docs.mydecisive.ai/). It covers SmartHub installation, platform concepts and support.

The SmartHub Helm chart and platform source live at [github.com/MyDecisive/mdai-hub](https://github.com/MyDecisive/mdai-hub).

## SmartHub Docs

| Area | Page |
| --- | --- |
| SmartHub quick start | [Quick Start](quickstart.md) |
| Chart development | [Development](development.md) |
| Platform architecture | [Architecture](architecture.md) |
| Published platform docs | [docs.mydecisive.ai](https://docs.mydecisive.ai/) |
| SmartHub chart and source | [github.com/MyDecisive/mdai-hub](https://github.com/MyDecisive/mdai-hub) |
| Octant control plane | [Octant](https://github.com/MyDecisive/octant) |

## SmartHub Responsibilities

SmartHub owns the telemetry platform behavior underneath Octant and command-line or manifest-based operation:

- `mdai-hub` chart installation and dependency composition.
- OpenTelemetry collector runtime and routing.
- Data Fidelity Validation.
- Prometheus-backed stream, hub, collector, and validation metrics.
- GreptimeDB-backed telemetry insight, volume, and cost data.
- Valkey-backed hub variables and runtime state.
- Gateway and event hub behavior for event-driven runtime control.

## Relationship to Octant

Octant depends on SmartHub. Octant exposes guided workflows for SmartHub installation, connections, validation, settings, Clarity, and cost or volume insight. SmartHub remains the platform layer that runs collectors, validation, state, and telemetry processing.

Use SmartHub docs for chart behavior, runtime architecture, and operational detail. Use Octant when you want a guided UI and API experience.

## Related Pages

- [Architecture](architecture.md)
- [Quick Start](quickstart.md)
- [Development](development.md)
- [Octant](https://github.com/MyDecisive/octant)
